--UH cont spell
function c3317676.initial_effect(c)
	c:EnableCounterPermit(0x667)
	c:SetCounterLimit(0x667,2)
		--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
		--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c3317676.ctop)
	c:RegisterEffect(e2)
	--remove 2 counters sp summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3317676,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c3317676.descost)
	e3:SetTarget(c3317676.target)
	e3:SetOperation(c3317676.activate)
	c:RegisterEffect(e3)
end

--add counter
function c3317676.ctop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp and r==REASON_RULE then
		e:GetHandler():AddCounter(0x667,1)
	end
end
--remove 2 counters sp summon
function c3317676.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x667,2,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x667,2,REASON_COST)
end
function c3317676.filter(c,e,tp)
	return c:IsSetCard(0x667) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c3317676.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c3317676.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c3317676.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c3317676.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end