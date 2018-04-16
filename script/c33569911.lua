--Shining Friendship (DOR)
--scripted by GameMaster (GM)
function c33569911.initial_effect(c)
   	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e2:SetCondition(c33569911.con2)
	e2:SetOperation(c33569911.op2)
	c:RegisterEffect(e2)
end

function c33569911.con2(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local pos=c:GetBattlePosition()
    return c==Duel.GetAttackTarget() and (pos==POS_FACEDOWN_DEFENSE or pos==POS_FACEDOWN_ATTACK) and c:IsLocation(LOCATION_MZONE)
end

function c33569911.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc==Duel.GetAttacker() then
 		local e1=Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_CANNOT_ATTACK)
     	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
        bc:RegisterEffect(e1)
        local e2=Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
        e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
        bc:RegisterEffect(e2)
end
end
