--Kosava's Memorial
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
	e1:SetTarget(scard.a_tg)
	c:RegisterEffect(e1)
	--Tohand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetDescription(aux.Stringid(s_id,1))
	e2:SetCondition(scard.a_cd)
	e2:SetTarget(scard.b_tg)
	e2:SetOperation(scard.b_op)
	c:RegisterEffect(e2)
	--Spsum
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(s_id,2))
	e3:SetCondition(scard.a_cd)
	e3:SetTarget(scard.c_tg)
	e3:SetOperation(scard.c_op)
	c:RegisterEffect(e3)
end

function scard.a_cd(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,s_id)==0
end

function scard.a_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local l=e:GetLabel()
		if l==1 then
			return scard.b_tg(e,tp,eg,ep,ev,re,r,rp,0,chkc)
		elseif l==2 then
			return scard.c_tg(e,tp,eg,ep,ev,re,r,rp,0,chkc)
		end
		return false
	end
	if chk==0 then
		e:SetProperty(0)
		e:SetCategory(0)
		e:SetOperation(nil)
		e:SetLabel(0)
		return true
	end
	if Duel.GetFlagEffect(tp,s_id)~=0 then return end
	local a=scard.b_tg(e,tp,eg,ep,ev,re,r,rp,0)
	local s=scard.c_tg(e,tp,eg,ep,ev,re,r,rp,0)
	if (a or s) and Duel.SelectYesNo(tp,aux.Stringid(s_id,0)) then
		local opt=0
		if a then
			if s then
				opt=Duel.SelectOption(tp,aux.Stringid(s_id,1),aux.Stringid(s_id,2))
			else
				opt=Duel.SelectOption(tp,aux.Stringid(s_id,1))
			end
		else
			opt=Duel.SelectOption(tp,aux.Stringid(s_id,2))+1
		end
		if opt==0 then
			e:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e:SetCategory(CATEGORY_TOHAND)
			e:SetOperation(scard.b_op)
			e:SetLabel(1)
			scard.b_tg(e,tp,eg,ep,ev,re,r,rp,1)
		else
			e:SetProperty(EFFECT_FLAG_CARD_TARGET)
			e:SetCategory(CATEGORY_SPECIAL_SUMMON)
			e:SetOperation(scard.c_op)
			e:SetLabel(2)
			scard.c_tg(e,tp,eg,ep,ev,re,r,rp,1)
		end
	end
end

function scard.b_fil(c)
	return scten(c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end

function scard.b_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and scard.b_fil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(scard.b_fil,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.SelectTarget(tp,scard.b_fil,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(s_id,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,0,0,aux.Stringid(s_id,1))
	Duel.RegisterFlagEffect(tp,s_id,RESET_PHASE+PHASE_END,0,0)
end

function scard.b_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then Duel.SendtoHand(tc,nil,REASON_EFFECT) end
end

function scard.c_fil(c,e,tp)
	return scten(c) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end

function scard.c_tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and scard.c_fil(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(scard.c_fil,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local g=Duel.SelectTarget(tp,scard.c_fil,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(s_id,RESET_EVENT+0x1fe0000+RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,0,0,aux.Stringid(s_id,2))
	Duel.RegisterFlagEffect(tp,s_id,RESET_PHASE+PHASE_END,0,0)
end

function scard.c_op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) end
end
