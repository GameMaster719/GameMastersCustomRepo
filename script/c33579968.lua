--Nightmare's Chain
--Scripted by GameMaster(GM)
function c33579968.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_STANDBY_PHASE,0x1c0)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c33579968.target)
	e1:SetOperation(c33579968.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c33579968.descon)
	e3:SetOperation(c33579968.desop)
	c:RegisterEffect(e3)
	e1:SetLabelObject(e3)
end
function c33579968.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(c33579968.filter2,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33579968.filter2,tp,0,LOCATION_MZONE,1,1,nil)
end
function c33579968.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		c:CreateRelation(tc,RESET_EVENT+0x1fe0000)
		e:GetLabelObject():SetLabelObject(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(c33579968.efftg)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD)
		e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
		e4:SetRange(LOCATION_SZONE)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e4:SetTarget(c33579968.cfilter)
		c:RegisterEffect(e4)
	end
end


function c33579968.filter2(c)
	return  c:IsRace(RACE_SPELLCASTER) and (c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK))
end

function c33579968.cfilter(e,c)
	return e:GetHandler():IsRelateToCard(c)
end

function c33579968.efftg(e,c)
	return e:GetHandler():IsRelateToCard(c)
end
function c33579968.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=e:GetLabelObject()
	return tc and eg:IsContains(tc) and c:IsRelateToCard(tc)
end
function c33579968.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end

