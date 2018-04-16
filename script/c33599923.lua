--Weather Control (DOR)
--scripted by GameMaster (GM)
function c33599923.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31560081,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c33599923.activate)
	c:RegisterEffect(e1)
end

function c33599923.activate(e,tp,eg,ep,ev,re,r,rp)
local token=Duel.CreateToken(tp,23424603)
Duel.SendtoHand(token,tp,2,REASON_EFFECT)
if Duel.SendtoHand(token,tp,2,REASON_EFFECT) then  
Duel.MoveToField(token,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
local token=Duel.CreateToken(1-tp,23424603)
Duel.SendtoHand(token,1-tp,2,REASON_EFFECT)
if Duel.SendtoHand(token,1-tp,2,REASON_EFFECT) then  
Duel.MoveToField(token,1-tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
if token:IsRelateToEffect(e) then  
token:CancelToGrave(false)
		end
end
end
end



