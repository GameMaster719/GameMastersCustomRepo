--Advanced Duel - 2 VS 1
function c33559908.initial_effect(c)
--Activate 
local e1=Effect.CreateEffect(c) 
e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PREDRAW)
e1:SetRange(0x5f)
e1:SetOperation(c33559908.op)
c:RegisterEffect(e1)
--unaffectable
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e2:SetRange(LOCATION_REMOVED)
e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e2:SetValue(1)
c:RegisterEffect(e2)
local e2a=e2:Clone()
e2a:SetCode(EFFECT_IMMUNE_EFFECT)
e2a:SetValue(c33559908.ctcon2)
c:RegisterEffect(e2a)
--skip turn
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e3:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e3:SetRange(LOCATION_REMOVED)
e3:SetCountLimit(1)
e3:SetCode(EVENT_PHASE+PHASE_END)
e3:SetCondition(c33559908.skipcon)
e3:SetTarget(c33559908.skiptg)
e3:SetOperation(c33559908.skipop)
c:RegisterEffect(e3)
end
function c33559908.op(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,33559908) then
Duel.DisableShuffleCheck()
Duel.SendtoDeck(c,nil,-2,REASON_RULE)
else
Duel.Remove(c,POS_FACEUP,REASON_RULE)
Duel.SetLP(tp,math.ceil(Duel.GetLP(tp)/2))
Duel.Hint(HINT_CARD,0,33559908)
end
if c:GetPreviousLocation()==LOCATION_HAND then
Duel.Draw(tp,1,REASON_RULE)
end
end
function c33559908.ctcon2(e,re)
return not re:IsCode(33559908)
end
function c33559908.skipcon(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==tp
end
function c33559908.skiptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,EFFECT_SKIP_TURN) end
end
function c33559908.skipop(e,tp,eg,ep,ev,re,r,rp)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetCode(EFFECT_SKIP_TURN)
e1:SetTargetRange(1,0)
e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
Duel.RegisterEffect(e1,tp)
end