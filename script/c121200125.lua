--Crivat, Tengu of the Twirling Waves
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
	--Setting
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,s_id+EFFECT_COUNT_CODE_OATH)
	e1:SetDescription(aux.Stringid(s_id,0))
	e1:SetCost(scard.a_cs)
	e1:SetTarget(scard.a_tg)
	e1:SetOperation(scard.a_op)
	c:RegisterEffect(e1)
end

function scard.a_fil(c,loc)
	return scten(c) and c:IsType(TYPE_SPELL+TYPE_TRAP) and (c:IsType(TYPE_FIELD) or loc>0) and c:IsSSetable(true)
end

function scard.a_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.a_fil,tp,LOCATION_DECK,0,1,nil,loc) end
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local g=Duel.GetMatchingGroup(scard.a_fil,tp,LOCATION_DECK,0,nil,loc)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local tg=g:Select(tp,1,1,nil)
		if Duel.GetCurrentChain()>=3 then
			if tg:GetFirst():IsType(TYPE_FIELD) then
				if loc==0 then
					g:Clear()
				else
					g:Remove(Card.IsType,nil,TYPE_FIELD)
				end
			else
				g=g:Filter(scard.a_fil,nil,loc-1)
			end
			g:Sub(tg)
			if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(s_id,1)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
				g=g:Select(tp,1,1,nil)
				tg:Merge(g)
			end
		end
		Duel.ConfirmCards(1-tp,tg)
		Duel.SSet(tp,tg)
	end
end
