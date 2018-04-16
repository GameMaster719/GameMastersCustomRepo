--Mystery Hand (DOR)
function c33589918.initial_effect(c)
    --atk def
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33589918,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(EVENT_FLIP)
	e1:SetCondition(c33589918.con)
	e1:SetTarget(c33589918.tg)
	e1:SetOperation(c33589918.op)
	c:RegisterEffect(e1)
end

function c33589918.filter2(c)
	return c:GetCode(90020065) 
end

function c33589918.con(e,c)
	return Duel.IsExistingMatchingCard(c33589918.filter2,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil,90020065)
end


function c33589918.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler()
		and Duel.IsExistingTarget(Card.IsCode,tp,LOCATION_MZONE,0,1,nil,90020065) and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>1 end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	Duel.SelectTarget(tp,Card.IsCode,tp,LOCATION_MZONE,0,1,1,nil,90020065)
end

function c33589918.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
	Duel.GetControl(tc,1-tc:GetControler())
		end
end



