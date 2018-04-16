--Magical Neutralizing ForceField (DOR)
--scripted by GameMaster(GM)
function c33599986.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetDescription(aux.Stringid(33599986,0))
    e1:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CARD_TARGET)
    e1:SetTarget(c33599986.target)
    e1:SetOperation(c33599986.activate)
    c:RegisterEffect(e1)
end
    
   ---trap filter 
function c33599986.filter(c)
 return c:IsFaceup() and c:IsType(TYPE_TRAP)
end

--monster filter
function c33599986.filter2(c)
    return c:IsFaceup()
end

function c33599986.filter32(c)
	return  c:GetCounter(0x113B)~=0
end	

function c33599986.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c33599986.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) or 
	Duel.IsExistingTarget(c33599986.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
    local dg=Duel.GetMatchingGroup(c33599986.filter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
   Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0) 
   local mg=Duel.GetMatchingGroup(c33599986.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
    Duel.SetOperationInfo(0,CATEGORY_ATKCHANGE,mg,mg:GetCount(),0,0)
    Duel.SetOperationInfo(0,CATEGORY_DEFCHANGE,mg,mg:GetCount(),0,0)
end

function c33599986.activate(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
	--destroy face up traps
    local dg=Duel.GetMatchingGroup(c33599986.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
    local tc=dg:GetFirst()
    while tc do
        tc=dg:GetNext()
        Duel.Destroy(dg,REASON_EFFECT)
    end
Duel.BreakEffect()	
	local sg1=Duel.GetMatchingGroup(c33599986.filter32,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc1=sg1:GetFirst()
	local count1=0
	while tc1 do
		count1=tc1:GetCounter(0x113B)
		tc1:RemoveCounter(tp,0,0,0)
		tc1=sg1:GetNext()
		end 
Duel.BreakEffect()		
 local mg=Duel.GetMatchingGroup(c33599986.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
    local tm=mg:GetFirst()
    while tm do
        local atk=tm:GetBaseAttack()
        local def=tm:GetBaseDefense()
        local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_SET_ATTACK_FINAL)
        e1:SetValue(atk)
        e1:SetReset(RESET_EVENT+RESET_CHAIN)
        tm:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
        e2:SetValue(def)
        e2:SetReset(RESET_EVENT+RESET_CHAIN)
        tm:RegisterEffect(e2)
        tm=mg:GetNext()
    end
end


