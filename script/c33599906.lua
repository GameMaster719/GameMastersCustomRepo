--Tin Balloons
--scripted by GameMaster(GM)+ André
function c33599906.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN+CATEGORY_DESTROY+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c33599906.condition)
	e1:SetTarget(c33599906.target)
	e1:SetOperation(c33599906.operation)
	c:RegisterEffect(e1)
end
function c33599906.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and re:IsActiveType(TYPE_XYZ)
end
function c33599906.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,22222238,0xf,0x4011,0,1000,3,RACE_MACHINE,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0)
end
function c33599906.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=Group.CreateGroup()
	g:KeepAlive()
	while ft>0 do
		local token=Duel.CreateToken(tp,22222238)
		Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP)
		token:RegisterFlagEffect(33599906,RESET_EVENT+0x1fe0000,0,1)
		g:AddCard(token)
		ft=ft-1
	end
	Duel.SpecialSummonComplete()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabelObject(g)
	e1:SetLabel(1)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCondition(c33599906.descon)
	e1:SetOperation(c33599906.desop)
	Duel.RegisterEffect(e1,tp)
end
function c33599906.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local c=g:GetFirst()
	local dg=Group.CreateGroup()
	while c do
		if c:GetFlagEffect(33599906)~=0 then dg:AddCard(c) end
		c=g:GetNext()
	end
	if dg:GetCount()>0 then
		return true
	else
		e:Reset()
		g:DeleteGroup()
		return false
	end
end
function c33599906.chfilter(c)
	return c:IsFaceup() and c:IsPosition(POS_DEFENSE)
end
function c33599906.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local c=g:GetFirst()
	local dg=Group.CreateGroup()
	while c do
		if c:GetFlagEffect(33599906)~=0 then dg:AddCard(c) end
		c=g:GetNext()
	end
	local chv=Duel.Destroy(dg,REASON_EFFECT)
	local tc=Duel.SelectMatchingCard(tp,c33599906.chfilter,tp,0,LOCATION_MZONE,1,1,nil):GetFirst()
	if tc then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetValue(-500*chv)
		if Duel.GetTurnPlayer()~=tp then
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,2)
		else
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,3)
		end
		tc:RegisterEffect(e1)
	end
end