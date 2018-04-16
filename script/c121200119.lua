--Tengu High Council
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
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--No counter!
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetValue(scard.a_val)
	c:RegisterEffect(e2)
	--Search
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetCountLimit(1,s_id+EFFECT_COUNT_CODE_OATH)
	e3:SetDescription(aux.Stringid(s_id,0))
	e3:SetCost(scard.b_cs)
	e3:SetTarget(scard.b_tg)
	e3:SetOperation(scard.b_op)
	c:RegisterEffect(e3)
	--Lolwhat
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCategory(CATEGORY_DECKDES)
	e4:SetCountLimit(1,s_id+1+EFFECT_COUNT_CODE_OATH)
	e4:SetDescription(aux.Stringid(s_id,1))
	e4:SetTarget(scard.c_tg)
	e4:SetOperation(scard.c_op)
	c:RegisterEffect(e4)
end

function scard.a_val(e,re,rp)
	return re:GetHandler():IsType(TYPE_COUNTER) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end

function scard.b_fil(c)
	return scten(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end

function scard.b_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.b_fil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.b_fil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1,g)
	end
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>0 end
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetFieldGroupCount(1-tp,LOCATION_DECK,0)>0 then
		Duel.DisableShuffleCheck()
		Duel.ConfirmDecktop(1-tp,1)
		local tc=Duel.GetDecktopGroup(1-tp,1):GetFirst()
		if Duel.SelectOption(tp,aux.Stringid(s_id,2),aux.Stringid(s_id,3))==1 then
			Duel.MoveSequence(tc,1)
		end
	end
end
