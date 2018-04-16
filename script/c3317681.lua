--UH: Arrow the scycle 
function c3317681.initial_effect(c)
		--pendulum summon
	aux.EnablePendulumAttribute(c)
		--Destroy Spell & Trap
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3317681,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,33176814)
	e2:SetCondition(c3317681.descon2)
	e2:SetTarget(c3317681.destg2)
	e2:SetOperation(c3317681.desop2)
	c:RegisterEffect(e2)
	--Kill bounce back row
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3317681,2))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1,33176811)
	e3:SetCost(c3317681.cost4)
	e3:SetTarget(c3317681.target4)
	e3:SetOperation(c3317681.operation4)
	c:RegisterEffect(e3)
	 --death into scale
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(3317681,3))
	e4:SetCountLimit(1,33176821)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c3317681.pencon)
	e4:SetTarget(c3317681.pentg)
	e4:SetOperation(c3317681.penop)
	c:RegisterEffect(e4)
	
end

--death into scale
function c3317681.pencon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0 and e:GetHandler():IsPreviousLocation(LOCATION_MZONE)
end
function c3317681.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) end
end
function c3317681.penop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(tp,LOCATION_SZONE,6) and not Duel.CheckLocation(tp,LOCATION_SZONE,7) then return false end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end

--Effect 2 (Destroy spell & trap) Code
function c3317681.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_PENDULUM
end
function c3317681.filter1(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c3317681.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c3317681.filter1(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c3317681.filter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c3317681.filter1,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c3317681.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end

function c3317681.filter4(c)
	return c:IsFaceup() and c:IsSetCard(0x667)
end
function c3317681.cost4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(c3317681.filter4,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c3317681.filter4,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.Destroy(g,REASON_EFFECT)
end
function c3317681.filter(c,e)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand() and c:IsCanBeEffectTarget(e)
end
function c3317681.target4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c3317681.filter(chkc,e) end
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c3317681.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,e)
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
function c3317681.operation4(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not tg then return end
	local dg=tg:Filter(Card.IsRelateToEffect,nil,e)
	if dg:GetCount()==1 then
		Duel.SendtoHand(dg,nil,REASON_EFFECT)
	end
end