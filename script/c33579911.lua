--Jenna Anjel final form
function c33579911.initial_effect(c)
  aux.EnablePendulumAttribute(c,false)  
 --Activate
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetCode(EVENT_FREE_CHAIN)
e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e0:SetCost(c33579911.cost)
e0:SetCountLimit(1)
c:RegisterEffect(e0)  
 --attribute cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCondition(c33579911.atcon)
	e1:SetTarget(c33579911.target)
	e1:SetOperation(c33579911.atop)
	c:RegisterEffect(e1)	
end

function c33579911.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetValue(c33579911.imfilter)
e1:SetReset(RESET_CHAIN)
Duel.RegisterEffect(e1,tp)
end

function c33579911.imfilter(e,re)
return re:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER+TYPE_PENDULUM) and re:GetOwner()~=e:GetOwner()
end

function c33579911.atcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end

function c33579911.target(e,tp,eg,ep,ev,re,r,rp,chk)	
if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) 
		and e:GetHandler():GetFlagEffect(33579911)==0 end
	e:GetHandler():RegisterFlagEffect(33579911,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,c,1,nil)
	end
	
	
	function c33579911.atop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,c,nil)
			local rc=Duel.AnnounceAttribute(tp,1,0xffff)
			if rc then
		local c=g:GetFirst()
		e:GetLabelObject()
		e:GetHandler():SetHint(CHINT_ATTRIBUTE,rc)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,rc))
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		c=g:GetNext()
	end
end

