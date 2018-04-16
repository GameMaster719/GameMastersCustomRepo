--Marin, Tengu of Ruin
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
	--Synchro Summon
	aux.AddSynchroProcedure2(c,aux.TRUE,aux.NonTuner(aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST)))
	c:EnableReviveLimit()
	--Negatesummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_F)
	e1:SetCode(EVENT_SUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_TODECK)
	e1:SetDescription(aux.Stringid(s_id,0))
	e1:SetCondition(scard.a_cd)
	e1:SetTarget(scard.a_tg)
	e1:SetOperation(scard.a_op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e3)
	--leave
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_LEAVE_FIELD_P)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetOperation(scard.b_regop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetDescription(aux.Stringid(s_id,1))
	e5:SetTarget(scard.b_tg)
	e5:SetOperation(scard.b_op)
	c:RegisterEffect(e5)
	e4:SetLabelObject(e5)
end

function scard.a_tfil(c)
	return scten(c) and c:IsFaceup()
end

function scard.a_attr(tp)
	local g=Duel.GetMatchingGroup(scard.a_tfil,tp,LOCATION_MZONE,0,nil)
	local res=0
	local c=g:GetFirst()
	while c do
		res=bit.bor(res,c:GetAttribute())
		c=g:GetNext()
	end
	return res
end

function scard.a_cd(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(s_id)==0 and tp~=ep and Duel.GetCurrentChain()==0 and eg:IsExists(Card.IsAttribute,1,nil,scard.a_attr(tp))
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():RegisterFlagEffect(s_id,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,0,0)
	local g=eg:Filter(Card.IsAttribute,nil,scard.a_attr(tp))
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(Card.IsAttribute,nil,scard.a_attr(tp))
	Duel.NegateSummon(g)
	Duel.SendtoDeck(g,nil,0,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	local sc0=og:Filter(Card.IsControler,nil,tp):FilterCount(Card.IsLocation,nil,LOCATION_DECK)
	if sc0>1 then Duel.SortDecktop(tp,tp,sc0) end
	local sc1=og:Filter(Card.IsControler,nil,1-tp):FilterCount(Card.IsLocation,nil,LOCATION_DECK)
	if sc1>1 then Duel.SortDecktop(1-tp,1-tp,sc1) end
end

function scard.b_fil(c,e,tp,sc)
	return c:IsLocation(LOCATION_GRAVE) and bit.band(c:GetReason(),0x80008)==0x80008 and c:GetReasonCard()==sc and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY) and c:IsCanBeEffectTarget(e)
end

function scard.b_regop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO then
		e:GetLabelObject():SetLabel(1)
	else
		e:GetLabelObject():SetLabel(0)
	end
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local c=e:GetHandler()
	if chk==0 then return e:GetLabel()==1 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:GetMaterial():IsExists(scard.b_fil,1,nil,e,tp,c) end
	local n=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then n=math.min(n,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=c:GetMaterial():FilterSelect(tp,scard.b_fil,1,n,nil,e,tp,c)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
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
