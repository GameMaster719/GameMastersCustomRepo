--Dream Clown (DOR)
--Scripted by GameMaster(GM)
function c33589903.initial_effect(c)
  --battled
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_BATTLED)
    e1:SetCondition(c33589903.condition2)
    e1:SetOperation(c33589903.atop)
    c:RegisterEffect(e1)
end

function c33589903.condition2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local pos=c:GetBattlePosition()
	return c==Duel.GetAttackTarget() and (pos==POS_FACEDOWN_DEFENSE or pos==POS_FACEDOWN_ATTACK) and c:IsLocation(LOCATION_MZONE)
end

function c33589903.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc==Duel.GetAttacker() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetCondition(c33589903.con)
		e1:SetReset(RESET_EVENT+0x00040000)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCondition(c33589903.con)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetReset(RESET_EVENT+0x00040000)
		bc:RegisterEffect(e2)
	 end
end

function c33589903.con(e,c)
local c=e:GetHandler()
	return not c:IsHasEffect(33589953)
end
