--Alize, Tengu of the Entwined Souls
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
	--Spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCountLimit(1,s_id+EFFECT_COUNT_CODE_OATH)
	e1:SetDescription(aux.Stringid(s_id,0))
	e1:SetCost(scard.a_cs)
	e1:SetTarget(scard.a_tg)
	e1:SetOperation(scard.a_op)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(s_id,ACTIVITY_SUMMON,scard.a_scount)
	Duel.AddCustomActivityCounter(s_id,ACTIVITY_SPSUMMON,scard.a_scount)
	Duel.AddCustomActivityCounter(s_id,ACTIVITY_FLIPSUMMON,scard.a_scount)
end

function scard.a_sfil(c,e,tp)
	return scten(c) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function scard.a_dfil(c)
	return scten(c) and c:IsDiscardable()
end

function scard.a_scount(c)
	return c:IsRace(RACE_WINDBEAST)
end

function scard.a_slim(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsRace(RACE_WINDBEAST)
end

function scard.a_cs(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() and Duel.IsExistingMatchingCard(scard.a_dfil,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,scard.a_dfil,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and
		 Duel.GetCustomActivityCount(s_id,tp,ACTIVITY_SUMMON)==0 and
		 Duel.GetCustomActivityCount(s_id,tp,ACTIVITY_SPSUMMON)==0 and
		 Duel.GetCustomActivityCount(s_id,tp,ACTIVITY_FLIPSUMMON)==0 and
		 not Duel.IsPlayerAffectedByEffect(tp,59822133) and
		 (Duel.IsExistingMatchingCard(scard.a_sfil,tp,LOCATION_GRAVE,0,2,nil,e,tp) or
		 (Duel.GetCurrentChain()>=2 and Duel.IsExistingMatchingCard(scard.a_sfil,tp,LOCATION_DECK,0,2,nil,e,tp)))
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
	local e1=Effect.CreateEffect(e:GetHandler())	
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(scard.a_slim)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	Duel.RegisterEffect(e3,tp)
end

function scard.a_op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local gs=Duel.IsExistingMatchingCard(scard.a_sfil,tp,LOCATION_GRAVE,0,2,nil,e,tp)
	local ds=Duel.GetCurrentChain()>=2 and Duel.IsExistingMatchingCard(scard.a_sfil,tp,LOCATION_DECK,0,2,nil,e,tp)
	if gs or ds then
		local g
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		if ds and (not gs or Duel.SelectYesNo(tp,aux.Stringid(s_id,1))) then
			g=Duel.SelectMatchingCard(tp,scard.a_sfil,tp,LOCATION_DECK,0,2,2,nil,e,tp)
		else
			g=Duel.SelectMatchingCard(tp,scard.a_sfil,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
		end
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local tc=g:GetFirst()
			local fid=e:GetHandler():GetFieldID()
			while tc do
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_CANNOT_ATTACK)
				e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1)
				tc:RegisterFlagEffect(s_id,RESET_EVENT+0x1fe0000,0,0,fid)
				tc=g:GetNext()
			end
			g:KeepAlive()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCountLimit(1)
			e1:SetCondition(scard.a_descd)
			e1:SetOperation(scard.a_desop)
			e1:SetLabel(fid)
			e1:SetLabelObject(g)
			Duel.RegisterEffect(e1,tp)
		end
	end
end

function scard.a_desfil(c,fid)
	return c:GetFlagEffectLabel(s_id)==fid
end

function scard.a_descd(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(scard.a_desfil,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end

function scard.a_desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(scard.a_desfil,nil,e:GetLabel())
	Duel.Destroy(tg,REASON_EFFECT)
end
