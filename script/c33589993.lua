--House of Adhisive Tape (DOR)
--scripted by GameMaster(GM)

function c33589993.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c33589993.target)
	e1:SetOperation(c33589993.activate)
	e1:SetCondition(c33589993.con)
	c:RegisterEffect(e1)
	
end

function c33589993.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33589993.filter,1,nil,tp)
end

function c33589993.filter(c,tp)
	return c:GetReasonPlayer()~=tp and c:GetAttack()<=1000 
end

function c33589993.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return eg:IsContains(chkc) and c33589993.filter(chkc,e,1-tp) end
	if chk==0 then return eg:IsExists(c33589993.filter,1,nil,e,1-tp) end
	local tc=eg:GetFirst()
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c33589993.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and tc:GetAttack()<=1000 then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
