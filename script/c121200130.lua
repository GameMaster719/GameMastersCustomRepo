--Solano, Tengu of the Ancient Pyres
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
	--summon 0
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetDescription(aux.Stringid(s_id,0))
	e1:SetCondition(scard.a_cd)
	e1:SetOperation(scard.a_op)
	c:RegisterEffect(e1)
	--grave effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(scard.b_op)
	c:RegisterEffect(e2)
end

function scard.a_cd(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp,c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetValue(1900)
	c:RegisterEffect(e1)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCountLimit(1,s_id+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(TIMING_MAIN_END)
	e1:SetDescription(aux.Stringid(s_id,1))
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e1:SetCondition(scard.c_cd)
	e1:SetTarget(scard.c_tg)
	e1:SetOperation(scard.c_op)
	e:GetHandler():RegisterEffect(e1)
end

function scard.c_fil(c,e,tp)
	return scten(c) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.c_cd(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc~=e:GetHandler() and scard.c_fil(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(scard.c_fil,tp,LOCATION_GRAVE,0,1,e:GetHandler(),e,tp) end
	local n=1
	if Duel.GetCurrentChain()>=4 and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) then n=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,scard.c_fil,tp,LOCATION_GRAVE,0,1,n,e:GetHandler(),e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local n=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if n<1 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then n=1 end
	local tn=tg:GetCount()
	if tn>0 then
		if tn>n then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			tg=tg:Select(tp,n,n,nil)
		end
		Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
	end
end
