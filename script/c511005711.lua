--Performpal five-Rainbow Magician (Anime)
--scripted by GameMaster(GM)
function c33599996.initial_effect(c)
aux.EnablePendulumAttribute(c,true)
--Double atk monster effect self
local e0=Effect.CreateEffect(c)
e0:SetDescription(aux.Stringid(33599996,0))
e0:SetCategory(CATEGORY_ATKCHANGE)
e0:SetType(EFFECT_TYPE_IGNITION)
e0:SetRange(LOCATION_MZONE)
e0:SetTargetRange(LOCATION_MZONE,0)
e0:SetCode(EVENT_FREE_CHAIN)
e0:SetCountLimit(1)
e0:SetOperation(c33599996.op)
e0:SetCondition(c33599996.con)
e0:SetTarget(c33599996.tg0)
c:RegisterEffect(e0)
--skip draw phase
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
e1:SetCode(EVENT_PHASE+PHASE_END)
e1:SetRange(LOCATION_PZONE)
e1:SetOperation(c33599996.op2)
e1:SetCondition(c33599996.con2)
e1:SetCountLimit(1)
c:RegisterEffect(e1)
--end turn if you set card
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
e2:SetCode(EVENT_SSET)
e2:SetOperation(c33599996.op22) 
e2:SetRange(LOCATION_PZONE)
c:RegisterEffect(e2)
--set card if you draw it outside drawphase
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(3167573,0))
e4:SetCategory(CATEGORY_TODECK)
e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
e4:SetRange(LOCATION_PZONE)
e4:SetCode(EVENT_TO_HAND)
e4:SetCondition(c33599996.con3)
e4:SetTarget(c33599996.tg3)
e4:SetOperation(c33599996.activate)
c:RegisterEffect(e4)
--cannot attack/attack to 0/cannot trigger/ == self
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetRange(LOCATION_PZONE)
e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e5:SetCode(EFFECT_SET_ATTACK_FINAL)
e5:SetTargetRange(LOCATION_MZONE,0)
e5:SetValue(0)
e5:SetCondition(c33599996.con5)
c:RegisterEffect(e5)
local e6=e5:Clone()
e6:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
e6:SetTarget(c33599996.tg7)
c:RegisterEffect(e6)
local e7=e6:Clone()
e7:SetCode(EFFECT_CANNOT_TRIGGER)
c:RegisterEffect(e7)
--cannot attack/attack to 0/cannot trigger/ == opp
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_FIELD)
e8:SetRange(LOCATION_PZONE)
e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e8:SetCode(EFFECT_SET_ATTACK_FINAL)
e8:SetTargetRange(0,LOCATION_MZONE)
e8:SetValue(0)
e8:SetCondition(c33599996.con8)
c:RegisterEffect(e8)
local e9=e8:Clone()
e9:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
e9:SetTarget(c33599996.tg7)
c:RegisterEffect(e9)
local e10=e9:Clone()
e10:SetCode(EFFECT_CANNOT_TRIGGER)
c:RegisterEffect(e10)
--atk double if 5 set cards negate other effects
local e10=Effect.CreateEffect(c)
e10:SetDescription(aux.Stringid(33599996,1))
e10:SetCategory(CATEGORY_ATKCHANGE)
e10:SetType(EFFECT_TYPE_IGNITION)
e10:SetRange(LOCATION_PZONE)
e10:SetTargetRange(LOCATION_MZONE,0)
e10:SetCode(EVENT_FREE_CHAIN)
e10:SetCountLimit(1)
e10:SetOperation(c33599996.op10)
e10:SetCondition(c33599996.con10)
c:RegisterEffect(e10)
--Double atk monster effect
local e12=Effect.CreateEffect(c)
e12:SetDescription(aux.Stringid(33599996,0))
e12:SetCategory(CATEGORY_ATKCHANGE)
e12:SetProperty(EFFECT_FLAG_BOTH_SIDE)
e12:SetType(EFFECT_TYPE_IGNITION)
e12:SetRange(LOCATION_MZONE)
e12:SetTargetRange(0,LOCATION_MZONE)
e12:SetCode(EVENT_FREE_CHAIN)
e12:SetCountLimit(1)
e12:SetOperation(c33599996.op12)
e12:SetCondition(c33599996.con12)
e12:SetTarget(c33599996.tg12)
c:RegisterEffect(e12)
end



function c33599996.op10(e,tp,eg,ep,ev,re,r,rp)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e1:SetCode(EFFECT_DISABLE)
e1:SetReset(RESET_EVENT+0x00800000)
e:GetHandler():RegisterEffect(e1)
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_DISABLE_EFFECT)
e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e2:SetReset(RESET_EVENT+0x00800000)
e:GetHandler():RegisterEffect(e2)
local g=Duel.GetMatchingGroup(c33599996.filter2,tp,LOCATION_MZONE,0,nil)
local tc=g:GetFirst()
while tc do
--double base attack
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_ATTACK_FINAL)
e1:SetValue(tc:GetBaseAttack()*2)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1,true)
tc=g:GetNext()
end
end



function c33599996.tg12(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingTarget(c33599996.filter1,tp,0,LOCATION_MZONE,5,nil) end
end


function c33599996.filter1(c)
return c:IsFaceup() and c:IsType(TYPE_MONSTER)  and c:IsType(TYPE_PENDULUM)
end

function c33599996.con12(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)==5 
end

function c33599996.op12(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33599996.filter1,tp,0,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while tc do
--double base attack
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_ATTACK_FINAL)
e1:SetValue(tc:GetBaseAttack()*2)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1,true)
--Cannot Attack Directly
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
e2:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e2,true)
tc=g:GetNext()
end
end


function c33599996.con10(e)
return Duel.IsExistingMatchingCard(Card.IsFacedown,e:GetHandlerPlayer(),LOCATION_SZONE,0,5,nil)
end

function c33599996.tg7(e,c,tp)
	return c:IsType(TYPE_MONSTER) 
end

function c33599996.con5(e)
return not Duel.IsExistingMatchingCard(Card.IsFacedown,e:GetHandlerPlayer(),LOCATION_SZONE,0,5,nil)
end

function c33599996.con8(e)
return not Duel.IsExistingMatchingCard(Card.IsFacedown,e:GetHandlerPlayer(),0,LOCATION_SZONE,5,nil)
end

function c33599996.cfilter(c,tp)
return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)  and Duel.GetCurrentPhase()~=PHASE_DRAW
end

function c33599996.con3(e,tp,eg,ep,ev,re,r,rp)
return eg:IsExists(c33599996.cfilter,1,nil,tp)
end

function c33599996.tg3(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetTargetCard(eg)
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,0,tp,1)
end

function c33599996.filter(c,e,tp)
return c:IsRelateToEffect(e) and c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK)
end

function c33599996.activate(e,tp,eg,ep,ev,re,r,rp)
local g=eg:Filter(c33599996.filter,nil,e,tp)
while g:GetCount()>0 do 
if not Duel.SelectYesNo(tp,aux.Stringid(60082869,0)) then return end
Duel.BreakEffect()
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
local sg=g:Select(tp,1,1,nil)
g:Sub(sg)
if sg:GetFirst():IsType(TYPE_MONSTER) then 
Duel.MSet(tp,sg:GetFirst(),true,nil)
else 
Duel.SSet(tp,sg:GetFirst())
if g:GetCount()==0  then return end
end
end
end

function c33599996.op22(e,tp,eg,ep,ev,re,r,rp)
local sk=Duel.GetTurnPlayer()
Duel.BreakEffect()
Duel.SkipPhase(sk,PHASE_DRAW,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(sk,PHASE_STANDBY,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(sk,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(sk,PHASE_BATTLE,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(sk,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
Duel.SkipPhase(sk,PHASE_END,RESET_PHASE+PHASE_END,1)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetCode(EFFECT_CANNOT_BP)
e1:SetTargetRange(1,1)
e1:SetReset(RESET_PHASE+PHASE_END)
Duel.RegisterEffect(e1,tp)
end

function c33599996.con2(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(Card.IsFacedown,e:GetHandlerPlayer(),LOCATION_SZONE,0,5,nil) then return end
return Duel.GetTurnPlayer()~=tp 
end

function c33599996.filter2(c)
return c:IsFaceup() and c:IsType(TYPE_MONSTER)  
end

function c33599996.op2(e,tp,eg,ep,ev,re,r,rp)
if Duel.SelectYesNo(tp,aux.Stringid(33599996,2)) then 
--cannot draw
local e5=Effect.CreateEffect(e:GetHandler())
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e5:SetTargetRange(1,0)
e5:SetCode(EFFECT_SKIP_DP)
e5:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN)
Duel.RegisterEffect(e5,tp)
else 
local e6=Effect.CreateEffect(e:GetHandler())
e6:SetType(EFFECT_TYPE_FIELD)
e6:SetCode(EFFECT_CANNOT_SSET)
e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e6:SetTargetRange(1,0)
e6:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,2)
Duel.RegisterEffect(e6,tp)
end
end

function c33599996.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingTarget(c33599996.filter1,tp,LOCATION_MZONE,0,5,nil) end
end


function c33599996.filter1(c)
return c:IsFaceup() and c:IsType(TYPE_MONSTER)  and c:IsType(TYPE_PENDULUM)
end

function c33599996.con(e)
return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)==5
end

function c33599996.op(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33599996.filter1,tp,LOCATION_MZONE,0,nil)
local tc=g:GetFirst()
while tc do
--double base attack
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_ATTACK_FINAL)
e1:SetValue(tc:GetBaseAttack()*2)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1,true)
--Cannot Attack Directly
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
e2:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e2,true)
tc=g:GetNext()
end
end
