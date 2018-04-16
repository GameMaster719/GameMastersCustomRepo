--Perdiction of the fool 
function c33589948.initial_effect(c)
   --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33589948.tg)
	e1:SetOperation(c33589948.op)
	c:RegisterEffect(e1) 
	end

function c33589948.filter(c)
	return  c:GetOriginalCode()==33589945 or c:GetOriginalCode()==511016002
end
	
	
function c33589948.filter2(c)
	return  c:GetOriginalCode()==511002417
end
	
function c33589948.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c33589948.filter,tp,LOCATION_MZONE+LOCATION_DECK+LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTODECK)
	local g=Duel.SelectTarget(tp,c33589948.filter,tp,LOCATION_MZONE+LOCATION_DECK+LOCATION_HAND,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c33589948.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		 Duel.SendtoDeck(tc,1-tp,POS_FACEUP,REASON_EFFECT)
		 Duel.ShuffleDeck(1-tp)
		 Duel.BreakEffect()
	local g=Duel.SelectMatchingCard(tp,c33589948.filter2,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
end
