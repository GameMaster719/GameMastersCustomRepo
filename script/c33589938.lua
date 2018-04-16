--cALL OF THE GRAVE(DOR)
--scripted by GameMaster (GM)
function c33589938.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_SZONE)
	e1:SetOperation(c33589938.disop)
	e1:SetCondition(c33589938.condition)
	c:RegisterEffect(e1)
	--negate destroy ritual
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_QUICK_F)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c33589938.discheck)
	e2:SetTarget(c33589938.target)
	e2:SetOperation(c33589938.activate)
	c:RegisterEffect(e2)
	--necro valley
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_NECRO_VALLEY)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(LOCATION_GRAVE,LOCATION_GRAVE)
	c:RegisterEffect(e6)
	--disable
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(EVENT_CHAIN_SOLVING)
	e10:SetRange(LOCATION_SZONE)
	e10:SetOperation(c33589938.disop)
	c:RegisterEffect(e10)
end

function c33589938.condition(e,tp,eg,ep,ev,re,r,rp)
return re:IsActiveType(TYPE_TRAP+TYPE_SPELL+TYPE_MONSTER) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) and Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
end

function c33589938.disfilter(c,im0,im1)
	if c:IsControler(0) then return im0 and c:IsHasEffect(EFFECT_NECRO_VALLEY)
	else return im1 and c:IsHasEffect(EFFECT_NECRO_VALLEY) end
end



function c33589938.discheck(ev,category,re,im0,im1,targets)
	local ex,tg,ct,p,v=Duel.GetOperationInfo(ev,category)
	if not ex then return false end
	if v==LOCATION_GRAVE then
		if p==0 then return im0
		elseif p==1 then return im1
		elseif p==PLAYER_ALL then return im0 and im1
		end
	end
	if tg and tg:GetCount()>0 then
		if targets and targets:IsContains(re:GetHandler()) then
			return tg:IsExists(c33589938.disfilter,1,nil,im0,im1)
		else
			return tg:IsExists(c33589938.disfilter,1,re:GetHandler(),im0,im1)
		end
	end
	return false
end

function c33589938.disop(e,tp,eg,ep,ev,re,r,rp)
	local tc=re:GetHandler()
	if not Duel.IsChainDisablable(ev) or tc:IsHasEffect(EFFECT_NECRO_VALLEY_IM) then return end
	local res=false
	local targets=nil
	if re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		targets=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	end
	local im0=not Duel.IsPlayerAffectedByEffect(0,EFFECT_NECRO_VALLEY_IM)
	local im1=not Duel.IsPlayerAffectedByEffect(1,EFFECT_NECRO_VALLEY_IM)
	if not res and c33589938.discheck(ev,CATEGORY_SPECIAL_SUMMON,re,im0,im1,targets) then res=true end
	if not res and c33589938.discheck(ev,CATEGORY_REMOVE,re,im0,im1,targets) then res=true end
	if not res and c33589938.discheck(ev,CATEGORY_TOHAND,re,im0,im1,targets) then res=true end
	if not res and c33589938.discheck(ev,CATEGORY_TODECK,re,im0,im1,targets) then res=true end
	if not res and c33589938.discheck(ev,CATEGORY_LEAVE_GRAVE,re,im0,im1,targets) then res=true end
	if res then	Duel.NegateEffect(ev) end
end

function c33589938.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	end

function c33589938.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=re:GetHandler()
	if not Duel.IsChainDisablable(ev) or tc:IsHasEffect(EFFECT_NECRO_VALLEY_IM) then return end
	local res=false
	local targets=nil
	if re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
		targets=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	end
	local im0=not Duel.IsPlayerAffectedByEffect(0,EFFECT_NECRO_VALLEY_IM)
	local im1=not Duel.IsPlayerAffectedByEffect(1,EFFECT_NECRO_VALLEY_IM)
	if not res and c33589938.discheck(ev,CATEGORY_SPECIAL_SUMMON,re,im0,im1,targets) then res=true end
	if not res and c33589938.discheck(ev,CATEGORY_REMOVE,re,im0,im1,targets) then res=true end
	if not res and c33589938.discheck(ev,CATEGORY_TOHAND,re,im0,im1,targets) then res=true end
	if not res and c33589938.discheck(ev,CATEGORY_TODECK,re,im0,im1,targets) then res=true end
	if not res and c33589938.discheck(ev,CATEGORY_LEAVE_GRAVE,re,im0,im1,targets) then res=true end
	if res then	Duel.NegateEffect(ev) end
end




