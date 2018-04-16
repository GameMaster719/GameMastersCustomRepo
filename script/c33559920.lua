--Monster Eye (DOR)
--scripted by GameMaster (GM)
function c33559920.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31560081,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c33559920.op)
	e1:SetTarget(c33559920.target)
	c:RegisterEffect(e1)
end




function c33559920.filter(c,e,tp,tid)
	return c:IsFacedown() and c:GetTurnID()==tid-1 and c:GetOwner()~=tp
end


function c33559920.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_ONFIELD) and c33559920.filter(chkc,e,tp,tid) end
	if chk==0 then return Duel.IsExistingTarget(c33559920.filter,tp,0,LOCATION_ONFIELD,1,nil,e,tp,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local g=Duel.SelectTarget(tp,c33559920.filter,tp,0,LOCATION_ONFIELD,1,1,nil,e,tp,tid)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end

function c33559920.op(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) and tc:IsFacedown() then 
Duel.ChangePosition(tc,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
end
end
