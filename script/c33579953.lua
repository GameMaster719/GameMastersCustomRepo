--Guardian Eatos (Anime)
function c33579953.initial_effect(c)
    --sum limit
    local e1=Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_CANNOT_SUMMON)
    e1:SetCondition(c33579953.sumlimit)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
    c:RegisterEffect(e2)
    local e3=e1:Clone()
    e3:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e3)
    --special summon
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_SPSUMMON_PROC)
    e4:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e4:SetRange(LOCATION_HAND)
    e4:SetCondition(c33579953.spcon)
    c:RegisterEffect(e4)
    --remove
    local e5=Effect.CreateEffect(c)
    e5:SetDescription(aux.Stringid(33579953,0))
    e5:SetCategory(CATEGORY_REMOVE)
    e5:SetType(EFFECT_TYPE_IGNITION)
    e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c33579953.con53)
    e5:SetTarget(c33579953.rmtg)
    e5:SetOperation(c33579953.rmop)
    c:RegisterEffect(e5)
end

function c33579953.cfilter(c)
	return c:IsFaceup() and  c:GetOriginalCode()==33579952 
end
function c33579953.sumlimit(e)
	return not Duel.IsExistingMatchingCard(c33579953.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end

function c33579953.eqfilter(c)
	return c:GetOriginalCode()==33579952 
end

function c33579953.con53(e)
	return e:GetHandler():GetEquipGroup():IsExists(c33579953.eqfilter,1,nil) 
end	

function c33579953.cfilter(c)
    return c:IsFaceup() and c:GetOriginalCode()==33579952 
end

function c33579953.filter6(c)
    return c:IsType(TYPE_MONSTER)
end


function c33579953.spcon(e)
     return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)<5 and  not Duel.IsExistingMatchingCard(c33579953.filter6,e:GetHandler():GetControler(),LOCATION_GRAVE,0,1,nil) 
	 and Duel.IsExistingMatchingCard(c33579953.cfilter,e:GetHandlerPlayer(),LOCATION_SZONE,0,1,nil)
end


function c33579953.rmfilter(c)
    return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c33579953.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
    local tc=Duel.GetFieldCard(1-tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(1-tp,LOCATION_GRAVE,0)-1)
    if chk==0 then return tc and tc:IsType(TYPE_MONSTER) and tc:IsAbleToRemove() and tc:GetAttack()>0 end
    Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c33579953.rmop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if not c:IsRelateToEffect(e) then return end
    local tc=Duel.GetFieldCard(1-tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(1-tp,LOCATION_GRAVE,0)-1)
    local sum=0
    while tc and tc:IsType(TYPE_MONSTER) and tc:IsAbleToRemove() and tc:GetAttack()>0 do
        Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
        sum=sum+tc:GetAttack()
        tc=Duel.GetFieldCard(1-tp,LOCATION_GRAVE,Duel.GetFieldGroupCount(1-tp,LOCATION_GRAVE,0)-1)
    end
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
    e1:SetRange(LOCATION_MZONE)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetValue(sum)
    c:RegisterEffect(e1)
end