--Coffin seller (Anime)
--scripted by GameMaster(GM)
function c33589942.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c33589942.operation)
	c:RegisterEffect(e2)
end


function c33589942.filter(c,tp)
	return c:IsControler(tp) and c:IsType(TYPE_MONSTER)
end


function c33589942.operation(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c33589942.filter,nil,1-tp)
	Duel.Damage(1-tp,ct*300,REASON_EFFECT)
end
