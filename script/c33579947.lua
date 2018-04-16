--Time Travel
function c33579947.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33579947.destg)
	e1:SetOperation(c33579947.desop)
    c:RegisterEffect(e1)
end


function c33579947.filter2(c)
	return c:IsType(TYPE_MONSTER)
end

function c33579947.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33579947.filter2(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c33579947.filter2,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c33579947.filter2,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetTargetCard(g)
	local g=Group.FromCards(c,g)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end

function c33579947.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local seq=tc:GetSequence()
	if tc:IsControler(1-tp) then seq=seq+16 end
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY,1)
		e1:SetLabelObject(tc)
		e1:SetCountLimit(1)
		e1:SetCondition(c33579947.rtcon)
		e1:SetOperation(c33579947.retop)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_DISABLE_FIELD)
		e2:SetReset(RESET_PHASE+PHASE_DRAW,2)
		e2:SetLabel(seq)
		e2:SetLabelObject(tc)
		e2:SetCondition(c33579947.discon)
		e2:SetOperation(c33579947.disop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c33579947.rtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c33579947.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
function c33579947.discon(e,c)
	if e:GetLabelObject():IsLocation(LOCATION_REMOVED) then return true end
	return false
end
function c33579947.disop(e,tp)
	local dis1=bit.lshift(0x1,e:GetLabel())
	return dis1
end
		