--UH: FireFly the blaze 
function c3317678.initial_effect(c)
aux.EnablePendulumAttribute(c,true)
 --atk
 local e1=Effect.CreateEffect(c)
 e1:SetType(EFFECT_TYPE_FIELD)
 e1:SetCode(EFFECT_UPDATE_ATTACK)
 e1:SetRange(LOCATION_PZONE)
 e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
 e1:SetTarget(c3317678.efilter)
 e1:SetValue(300)
 c:RegisterEffect(e1)
	--If deal damage,kill a thing
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3317678,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c3317678.descon)
	e3:SetTarget(c3317678.destg)
	e3:SetOperation(c3317678.desop)
	c:RegisterEffect(e3)
	 --death into scale
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(3317678,3))
	e4:SetCountLimit(1,3317678)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c3317678.pencon)
	e4:SetTarget(c3317678.pentg)
	e4:SetOperation(c3317678.penop)
	c:RegisterEffect(e4)
end
function c3317678.efilter(e,c)
 return c:IsSetCard(0x667)
end
--Death into scale
function c3317678.pencon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c3317678.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c3317678.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) and not Duel.CheckLocation(tp,LOCATION_SZONE,7) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end

--If deal damage,kill a thing
function c3317678.descon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c3317678.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c3317678.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
