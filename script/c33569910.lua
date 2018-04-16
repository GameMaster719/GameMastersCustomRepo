--Genin (DOR)
--scripted by GameMaster (GM)
function c33569910.initial_effect(c)
	--battled
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c33569910.condition2)
	e3:SetOperation(c33569910.atop)
	c:RegisterEffect(e3)
	end


function c33569910.filter(c,e)
	return c:IsFaceup() and c:IsCode(15259703)
end


function c33569910.condition2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local pos=c:GetBattlePosition()
	return c==Duel.GetAttackTarget() and (pos==POS_FACEDOWN_DEFENSE or pos==POS_FACEDOWN_ATTACK) and c:IsLocation(LOCATION_MZONE)
end

function c33569910.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc==Duel.GetAttacker() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+0x20000000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetReset(RESET_EVENT+0x20000000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
		bc:RegisterEffect(e2)
	 end
end