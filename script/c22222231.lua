--Eternity 8 Orb
function c22222231.initial_effect(c)
--control
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e1)  
	  --detach
    local e6=Effect.CreateEffect(c)
    e6:SetDescription(aux.Stringid(22222231,1))
    e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
    e6:SetCode(EVENT_TO_GRAVE)
    e6:SetOperation(c22222231.detop)
    c:RegisterEffect(e6)
	
end


function c22222231.detop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()  
    Duel.Remove(c,POS_FACEUP,REASON_EFFECT,tp)
    Duel.SendtoDeck(c,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
  end

	
	
	