--Tainted Wisdom (DOR)
function c33579988.initial_effect(c)
   --check
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCode(EVENT_MSET)
    e1:SetOperation(c33579988.chkop)
	e1:SetCondition(c33579988.con)
    c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SSET)
	c:RegisterEffect(e2)
	end
	
	
function c33579988.chkop(e,tp,eg,ep,ev,re,r,rp)
	local conf=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD,POS_FACEDOWN)
	if conf:GetCount()>0 then
		Duel.ConfirmCards(tp,conf)
	end
end
	
	function c33579988.con(e,tp)
	return e:GetHandler():IsDefensePos() and Duel.GetTurnPlayer()~=tp
end