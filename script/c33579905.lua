--Beelzebub
function c33579905.initial_effect(c)
  --spsummon
    local e0=Effect.CreateEffect(c)
    e0:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
    e0:SetRange(LOCATION_EXTRA+LOCATION_GRAVE)
    e0:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
    e0:SetCode(EVENT_DESTROYED)
    e0:SetCondition(c33579905.condition)
    e0:SetCost(c33579905.cost)
    e0:SetTarget(c33579905.target)
    e0:SetOperation(c33579905.operation)
    c:RegisterEffect(e0)
	--DESTROY COPIES
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetDescription(aux.Stringid(33579905,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c33579905.target2)
	e1:SetOperation(c33579905.operation2)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--DESTROY COPIES
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetDescription(aux.Stringid(33579905,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c33579905.target3)
	e4:SetCountLimit(1)
	e4:SetOperation(c33579905.operation3)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e6)
end

function c33579905.filter3(c)
	return c:IsFaceup() and c:GetAttack()<=1000 and c:IsAbleToRemove()
end
function c33579905.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return eg:IsExists(c33579905.filter3,1,nil) end
	local g=eg:Filter(c33579905.filter3,nil)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c33579905.efilter09(c,e)
	return c:IsFaceup() and c:IsAttackBelow(1000) and c:IsRelateToEffect(e)
end
function c33579905.operation3(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(c33579905.efilter09,nil,e)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	local rg=Group.CreateGroup()
	local tc=sg:GetFirst()
	while tc do
		if tc:IsLocation(LOCATION_REMOVED) then
			local tpe=tc:GetType()
			if bit.band(tpe,TYPE_TOKEN)==0 then
				local g1=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_DECK+LOCATION_HAND,nil,tc:GetCode())
				rg:Merge(g1)
			end
		end
		tc=sg:GetNext()
	end
	if rg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	end
end


function c33579905.filter2(c,e)
	return c:IsFaceup() and c:IsAttackBelow(2000) and c:IsCanBeEffectTarget(e)
end
function c33579905.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) end
	if chk==0 then return eg:IsExists(c33579905.filter2,1,nil,e) end
	if eg:GetCount()==1 then
		Duel.SetTargetCard(eg)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=eg:FilterSelect(tp,c33579905.filter2,1,1,nil,e)
		Duel.SetTargetCard(g)
	end
end
function c33579905.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local tpe=tc:GetType()
	if bit.band(tpe,TYPE_TOKEN)~=0 then return end
	local dg=Duel.GetMatchingGroup(Card.IsCode,tc:GetControler(),LOCATION_DECK+LOCATION_HAND,0,nil,tc:GetCode())
	Duel.Destroy(dg,REASON_EFFECT)
end



function c33579905.cfilter(c)
    return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_INSECT) and c:IsPreviousPosition(POS_FACEUP)
        and c:IsPreviousLocation(LOCATION_MZONE) and bit.band(c:GetPreviousRaceOnField(),RACE_INSECT)~=0
end
function c33579905.condition(e,tp,eg,ep,ev,re,r,rp)
    return not eg:IsContains(e:GetHandler()) and eg:IsExists(c33579905.cfilter,1,nil,tp)
end
function c33579905.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckLPCost(tp,1500) end
    Duel.PayLPCost(tp,1500)
end
function c33579905.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c33579905.operation(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e) then
        Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
    end
end