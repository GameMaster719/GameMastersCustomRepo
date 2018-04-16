--Kosava, Tengu of the Maelstrom
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
	--Xyz Summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),6,2)
	c:EnableReviveLimit()
	--Place topdeck
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetCountLimit(1)
	e1:SetDescription(aux.Stringid(s_id,0))
	e1:SetCost(scard.a_cs)
	e1:SetTarget(scard.a_tg)
	e1:SetOperation(scard.a_op)
	c:RegisterEffect(e1)
end

function scard.a_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,0x1c,0x1c,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,0)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,0x1c,0x1c,1,1,nil)
	if g:GetCount()>0 then Duel.SendtoDeck(g,nil,0,REASON_EFFECT) end
	if Duel.GetCurrentChain()>=7 then
		local tg=Duel.GetFieldGroup(tp,0,0x1e)
		Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(1-tp)
		Duel.BreakEffect()
		Duel.Draw(1-tp,5,REASON_EFFECT)
		Duel.SetLP(1-tp,8000)
	end
end
