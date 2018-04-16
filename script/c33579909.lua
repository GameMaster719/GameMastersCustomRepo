--Hakushin
function c33579909.initial_effect(c)
   aux.EnablePendulumAttribute(c,false) 
--Activate
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetCode(EVENT_FREE_CHAIN)
e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e0:SetCost(c33579909.cost)
e0:SetCountLimit(1)
c:RegisterEffect(e0)  
  --monsters become 0 atk
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(33579909,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c33579909.condition)
	e1:SetTarget(c33579909.target)
	e1:SetOperation(c33579909.operation)
	e1:SetCountLimit(1)
	c:RegisterEffect(e1)
	--monsters become unknown
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33579909,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetTarget(c33579909.target2)
	e2:SetOperation(c33579909.operation2)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33579909,2))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_PZONE)
	e3:SetHintTiming(TIMING_DAMAGE_STEP)
	e3:SetTarget(c33579909.target3)
	e3:SetOperation(c33579909.operation3)
	e3:SetCountLimit(1)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33579909,3))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetTarget(c33579909.target4)
	e4:SetOperation(c33579909.operation4)
	c:RegisterEffect(e4)
	--Return to deck if destroyed
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_PZONE)
	e5:SetTarget(c33579909.desreptg)
	c:RegisterEffect(e5)
	-- Cannot Disable effect
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCode(EFFECT_CANNOT_DISABLE)
	e6:SetRange(LOCATION_PZONE)
	c:RegisterEffect(e6)
end

function c33579909.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetValue(c33579909.imfilter)
e1:SetReset(RESET_CHAIN)
Duel.RegisterEffect(e1,tp)
end

function c33579909.imfilter(e,re)
return re:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER+TYPE_PENDULUM) and re:GetOwner()~=e:GetOwner()
end

function c33579909.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_DESTROY+REASON_EFFECT) and c:IsFaceup()  end
		Duel.SendtoDeck(c,tp,2,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
 end

function c33579909.filter4(c)
	return c:IsType(0xff)
end
function c33579909.target4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsOnField() and c33579909.filter4(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33579909.filter4,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33579909.filter4,tp,LOCATION_ONFIELD,0,1,1,nil)
end
function c33579909.operation4(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCountLimit(1)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end


function c33579909.filter3(c)
	return c:IsAbleToRemove()
end
function c33579909.target3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c33579909.filter3(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33579909.filter3,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c33579909.filter3,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c33579909.operation3(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local seq=tc:GetSequence()
	if tc:IsControler(1-tp) then seq=seq+16 end
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY,2)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetCondition(c33579909.rtcon)
		e1:SetOperation(c33579909.retop)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_DISABLE_FIELD)
		e2:SetReset(RESET_PHASE+PHASE_DRAW,2)
		e2:SetLabel(seq)
		e2:SetLabelObject(tc)
		e2:SetCondition(c33579909.discon)
		e2:SetOperation(c33579909.disop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c33579909.rtcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c33579909.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
function c33579909.discon(e,c)
	if e:GetLabelObject():IsLocation(LOCATION_REMOVED) then return true end
	return false
end
function c33579909.disop(e,tp)
	local dis1=bit.lshift(0x1,e:GetLabel())
	return dis1
end

function c33579909.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c33579909.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.IsExistingMatchingCard(c33579909.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
end

function c33579909.operation2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33579909.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
	--make all monsters unknown race
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetTarget(c33579909.target2)
			e1:SetCode(EFFECT_CHANGE_RACE)
			e1:SetValue(0x10000000)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
	end
end



function c33579909.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c33579909.filter(c)
	return c:IsFaceup() and c:GetBaseAttack()~=0
end
function c33579909.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33579909.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c33579909.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33579909.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	local tc=g:GetFirst()
	while tc do
		if not tc:IsImmuneToEffect(e) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(0)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(33579909,RESET_EVENT+0x17a0000+RESET_PHASE+PHASE_END,0,1,fid)
		end
		tc=g:GetNext()
	end
end

