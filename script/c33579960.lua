--Cup of Sealed Soul
function c33579960.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
	--indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetValue(1)
	e4:SetCondition(c33579960.incon)
	e4:SetTarget(c33579960.infilter)
	c:RegisterEffect(e4)
end
function c33579960.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end

function c33579960.incon(e)
	return Duel.IsExistingMatchingCard(c33579960.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil,511001305)
end
function c33579960.infilter(e,c)
	return c:GetCode()==89194033
end
