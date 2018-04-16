--Rescuer from the Grave (GM)
function c33559940.initial_effect(c)
--disable attack
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(91990040,0))
e1:SetType(EFFECT_TYPE_QUICK_O)
e1:SetCode(EVENT_ATTACK_ANNOUNCE)
e1:SetHintTiming(TIMING_BATTLE_PHASE)
e1:SetRange(LOCATION_GRAVE)
e1:SetCountLimit(1)
e1:SetCondition(c33559940.con40)
e1:SetOperation(c33559940.operation)
c:RegisterEffect(e1)
end
function c33559940.con40(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end

function c33559940.operation(e,tp,eg,ep,ev,re,r,rp)
Duel.NegateAttack()
Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end