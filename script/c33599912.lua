--Selection of Fate
--scripted by GameMaster(GM)
function c33599912.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33599912.target)
	e1:SetOperation(c33599912.activate)
	c:RegisterEffect(e1)
end
function c33599912.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c33599912.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33599912.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
end
function c33599912.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0  then return end
    local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
    tc=g:Select(1-tp,1,1,nil):GetFirst()
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		else
			Duel.ShuffleHand(tp)
		end
	end
end
