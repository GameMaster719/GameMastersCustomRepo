--Condemned World
function c33579908.initial_effect(c)
     --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetOperation(c33579908.activate)
    c:RegisterEffect(e1)
	--recover conversion
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_REVERSE_RECOVER)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,1)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--damage conversion
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EFFECT_REVERSE_DAMAGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(1,1)
	e3:SetValue(c33579908.rev)
	c:RegisterEffect(e3)
end
function c33579908.rev(e,re,r,rp,rc)
	return bit.band(r,REASON_EFFECT)>0
end

function c33579908.activate(e,tp,eg,ep,ev,re,r,rp)
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD)
    e1:SetCode(EFFECT_REVERSE_UPDATE)
    e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
    Duel.RegisterEffect(e1,tp)
end
  

