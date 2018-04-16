--Dark Magician GIrl (DOR)
function c33579992.initial_effect(c)
   --adup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33579992,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_FLIP)
	e1:SetOperation(c33579992.op)
	c:RegisterEffect(e1)
	end

	
function c33579992.filter(c)
	return c:IsCode(46986414)
end


function c33579992.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct,g=Duel.GetMatchingGroupCount(c33579992.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)*500
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct)
		c:RegisterEffect(e1) 
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
		end



