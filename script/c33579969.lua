--Beads of the Spirit-Realm
function c33579969.initial_effect(c)
   --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1) 
	--cannot disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_CANNOT_DISABLE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SPIRIT))
	c:RegisterEffect(e2)
	--destroy card on field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33579969,0))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c33579969.tg)
	e3:SetOperation(c33579969.op)
	c:RegisterEffect(e3)
end


function c33579969.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToDeck() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToDeck,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c33579969.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		 Duel.SendtoDeck(tc,1-tp,POS_FACEUP,REASON_EFFECT)
		 Duel.ShuffleDeck(1-tp)
	end
end