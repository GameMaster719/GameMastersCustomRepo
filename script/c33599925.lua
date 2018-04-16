--Active Guard
function c33599925.initial_effect(c)
	--defup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c33599925.val)
	c:RegisterEffect(e1)
	--no damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33599925,0))
	e2:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c33599925.con)
	e2:SetOperation(c33599925.op)
	c:RegisterEffect(e2)
	if not c33599925.global_check then
		c33599925.global_check=true
		if Duel.GetFlagEffect(0,110000104)==0 and Duel.GetFlagEffect(1,110000104)==0 then
			Duel.RegisterFlagEffect(0,110000104,0,0,1)
			Duel.RegisterFlagEffect(1,110000104,0,0,1)
		--cannot attack
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		ge1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		ge1:SetCondition(c33599925.atkcon)
		ge1:SetTarget(c33599925.atktg)
		Duel.RegisterEffect(ge1,0)
		--check
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge2:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge2:SetOperation(c33599925.checkop)
		ge2:SetLabelObject(e2)
		Duel.RegisterEffect(ge2,0)
		--change attack target
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_BE_BATTLE_TARGET)
		ge3:SetCondition(c33599925.atcon)
		ge3:SetOperation(c33599925.atop)
		Duel.RegisterEffect(ge3,0)
		local ge4=ge3:Clone()
		Duel.RegisterEffect(ge4,1)
		end
	end
end
function c33599925.atkcon(e)
	return Duel.GetFlagEffect(e:GetHandlerPlayer(),33599925)~=0 and Duel.GetFlagEffect(1-e:GetHandlerPlayer(),33599925)~=0
end
function c33599925.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel() and c:IsType(0x10000000)
end
function c33599925.checkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsType(0x10000000) then return end
	if Duel.GetFlagEffect(tp,33599925)~=0 and Duel.GetFlagEffect(1-tp,33599925)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	Duel.RegisterFlagEffect(tp,33599925,RESET_PHASE+PHASE_END,0,1)
	Duel.RegisterFlagEffect(1-tp,33599925,RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
function c33599925.atcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsFaceup() and at:IsControler(tp) and at:IsType(0x10000000)
end
function c33599925.atop(e,tp,eg,ep,ev,re,r,rp)
	local atg=Duel.GetAttacker():GetAttackableTarget()
	local d=Duel.GetAttackTarget()
	if atg:IsExists(c33599925.filter,1,d) and Duel.SelectYesNo(tp,aux.Stringid(21558682,0)) then
		local g=atg:FilterSelect(tp,c33599925.filter,1,1,d)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
function c33599925.filter(c)
	return c:IsFaceup() and c:IsType(0x10000000)
end
function c33599925.val(e,c)
	return Duel.GetMatchingGroupCount(c33599925.filter,c:GetControler(),LOCATION_MZONE,0,nil)*500
end

function c33599925.con(e,tp,eg,ep,ev,re,r,rp)
return  Duel.GetBattleDamage(tp)>0 or bit.band(r,REASON_EFFECT+REASON_BATTLE)~=0
end

function c33599925.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c33599925.val2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	--
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetOperation(c33599925.tgop)
	e3:SetReset(RESET_EVENT+0xc6e0000)
	e:GetHandler():RegisterEffect(e3)
end

function c33599925.val2(e,re,val,r,rp,rc)
	if e:GetHandlerPlayer()~=rp then
		return 0
	else return val end
end

function c33599925.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
