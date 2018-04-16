--UH: Mind the gap
function c3317682.initial_effect(c)
		--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Kill bounce back monster
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3317682,2))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,33176821)
	e1:SetCost(c3317682.cost4)
	e1:SetTarget(c3317682.target4)
	e1:SetOperation(c3317682.operation4)
	c:RegisterEffect(e1)
	 --death into scale
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3317682,3))
	e2:SetCountLimit(1,33176822)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(c3317682.pencon)
	e2:SetTarget(c3317682.pentg)
	e2:SetOperation(c3317682.penop)
	c:RegisterEffect(e2)
		--change card battle position
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33176823,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,33176823)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c3317682.postg)
	e3:SetOperation(c3317682.posop)
	c:RegisterEffect(e3)
	
end
--change card battle position
function c3317682.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c3317682.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end

--death into scale
function c3317682.pencon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c3317682.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c3317682.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) and not Duel.CheckLocation(tp,LOCATION_SZONE,7) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end

function c3317682.filter4(c)
	return c:IsFaceup() and c:IsSetCard(0x667)
end
function c3317682.cost4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c3317682.filter4,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c3317682.filter4,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.Destroy(g,REASON_EFFECT)
end
function c3317682.filter2(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function c3317682.target4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c3317682.filter2(chkc,e) end
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c3317682.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,e)
	if g:GetCount()<1 then
		g:Clear()
		Duel.SetTargetCard(g)
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,sg,1,0,0)
end
function c3317682.operation4(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg then return end
	local dg=tg:filter2(Card.IsRelateToEffect,nil,e)
	if dg:GetCount()==1 then
		Duel.SendtoHand(dg,nil,REASON_EFFECT)
	end
end