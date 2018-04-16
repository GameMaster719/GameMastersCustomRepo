--Aquila, Tengu of the Night Haze
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
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TODECK)
	e1:SetCountLimit(1,s_id+EFFECT_COUNT_CODE_OATH)
	e1:SetDescription(aux.Stringid(s_id,0))
	e1:SetCondition(scard.a_cd)
	e1:SetCost(scard.a_cs)
	e1:SetTarget(scard.a_tg)
	e1:SetOperation(scard.a_op)
	c:RegisterEffect(e1)
end

function scard.a_fil(c)
	return scten(c) and c:IsOnField() and c:IsFaceup()
end

function scard.a_cd(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsExists(scard.a_fil,1,nil) and Duel.IsChainNegatable(ev)
end

function scard.a_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if Duel.GetCurrentChain()>=3 and re:GetHandler():IsRelateToEffect(re) and Duel.SelectYesNo(tp,aux.Stringid(s_id,1)) then
		eg:GetHandler():CancelToGrave()
		Duel.SendtoDeck(eg,nil,0,REASON_EFFECT)
	end
end
