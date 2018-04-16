--Vampiric Leech
function c33599994.initial_effect(c)
	--attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_BP_FIRST_TURN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
	--reg
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetOperation(c33599994.regop)
	c:RegisterEffect(e2)
	--change battle position
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33599994,1))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c33599994.poscon)
	e3:SetCost(c33599994.poscost)
	e3:SetOperation(c33599994.posop)
	c:RegisterEffect(e3)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(33599994)
	e5:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e5)
	if not c33599994.global_check then
		c33599994.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(EFFECT_CANNOT_ATTACK)
		ge1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		ge1:SetCondition(c33599994.atkcon)
		ge1:SetTarget(c33599994.atktg)
		Duel.RegisterEffect(ge1,0)
	end
end
function c33599994.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetAttackTarget() then return end
	c:RegisterFlagEffect(511000174,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c33599994.poscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c33599994.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511000174)>0 and e:GetHandler():IsAttackPos()
end
function c33599994.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		if e:GetHandler():IsAttackPos() then
		Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)
	end
end

function c33599994.atkcon(e)
	return Duel.GetTurnCount()==1
end
function c33599994.atktg(e,c)
	return not c:IsHasEffect(33599994)
end
