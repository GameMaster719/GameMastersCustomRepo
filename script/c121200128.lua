--Cierzo, Tengu of the Sanguine Sands
--  Idea: Lenfried
--  Script: Shad3

local function getID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local s_id=tonumber(string.sub(str,2))
	return scard,s_id
end

local scard,s_id=getID()
local function scten(c)
	return c:IsSetCard(0xa8c) or c:IsCode(2356994,3072808,82050203,10028593,4149689,100001002,511002143)
end

function scard.initial_effect(c)
	--BaniSummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCountLimit(1,s_id+EFFECT_COUNT_CODE_OATH)
	e1:SetDescription(aux.Stringid(s_id,0))
	e1:SetCost(scard.a_cs)
	e1:SetTarget(scard.a_tg)
	e1:SetOperation(scard.a_op)
	c:RegisterEffect(e1)
	--HandSummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetCountLimit(1,s_id+1+EFFECT_COUNT_CODE_OATH)
	e2:SetDescription(aux.Stringid(s_id,1))
	e2:SetTarget(scard.b_tg)
	e2:SetOperation(scard.b_op)
	c:RegisterEffect(e2)
end

function scard.a_cfil(c)
	return scten(c) and c:IsAbleToRemoveAsCost()
end

function scard.a_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.a_cfil,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,scard.a_cfil,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP) end
end

function scard.b_fil(c,e,tp)
	return scten(c) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.b_afil(c)
	return scten(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_HAND,0,1,nil,e,tp) and (Duel.IsExistingMatchingCard(scard.b_afil,tp,LOCATION_DECK,0,1,nil) or Duel.GetCurrentChain()<2) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
	if Duel.GetCurrentChain()>=2 then
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	end
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,scard.b_fil,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP) end
	if Duel.GetCurrentChain()>=2 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local tg=Duel.SelectMatchingCard(tp,scard.b_afil,tp,LOCATION_DECK,0,1,1,nil)
		if tg:GetCount()>0 then
			Duel.SendtoHand(tg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tg)
		end
	end
end
