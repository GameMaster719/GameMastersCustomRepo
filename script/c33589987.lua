--strike back
--scripted by GaMEMASTER(GM)
function c33589987.initial_effect(c)
--Activate- 
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetHintTiming(0,TIMING_BATTLE_START+TIMING_BATTLE_END)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetCondition(c33589987.con)
e1:SetOperation(c33589987.op)
c:RegisterEffect(e1)
end


function c33589987.con(e,tp,eg,ep,ev,re,r,rp)
return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and Duel.GetTurnPlayer()~=tp
end

function c33589987.op(e,tp,eg,ep,ev,re,r,rp)
local e0=Effect.CreateEffect(e:GetHandler())
e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e0:SetType(EFFECT_TYPE_FIELD)
e0:SetCode(EFFECT_CANNOT_M2)
e0:SetTargetRange(0,1)
e0:SetReset(RESET_PHASE+PHASE_END)
Duel.RegisterEffect(e0,tp)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetCode(EFFECT_SKIP_TURN)
e1:SetTargetRange(0,1)
e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
Duel.RegisterEffect(e1,tp)
local e5=Effect.CreateEffect(e:GetHandler())
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e5:SetTargetRange(1,0)
e5:SetCode(EFFECT_SKIP_DP)
if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_BATTLE then
e5:SetCondition(c33589987.skipcon)
e5:SetLabel(Duel.GetTurnCount())
e5:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN,2)
else
e5:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN)
end
Duel.RegisterEffect(e5,tp)
local e6=e5:Clone()
e6:SetCode(EFFECT_SKIP_SP)
Duel.RegisterEffect(e6,tp)
local e7=e6:Clone()
e7:SetCode(EFFECT_SKIP_M1)
Duel.RegisterEffect(e7,tp)
local e8=e7:Clone()
e8:SetCode(EFFECT_CANNOT_EP)
e8:SetTargetRange(1,0)
if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_MAIN1 then
e8:SetReset(RESET_PHASE+PHASE_MAIN1,2)
else
e8:SetReset(RESET_PHASE+PHASE_MAIN1)
end
Duel.RegisterEffect(e8,tp)
local e9=e8:Clone()
e9:SetCode(EFFECT_SKIP_M2)
Duel.RegisterEffect(e9,tp)
end


function c33589987.skipcon(e)
return Duel.GetTurnCount()~=e:GetLabel()
end	