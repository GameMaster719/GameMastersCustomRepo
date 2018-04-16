--Swords of Revealing Light (DOR)
--scripted by GameMaster(GM)
function c33589910.initial_effect(c)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
e1:SetOperation(c33589910.operation)
e1:SetTarget(c33589910.target)
c:RegisterEffect(e1)
end

function c33589910.target(e,tp,eg,ep,ev,re,r,rp,chk)
local oppmonNum = Duel.GetMatchingGroupCount(c33589910.filter2,tp,0,LOCATION_MZONE,nil)
local s1=math.min(oppmonNum,oppmonNum)
if chk==0 then return Duel.IsExistingMatchingCard(Card.IsOnfield,tp,0,LOCATION_ONFIELD,1,nil,e,tp) end

local g=Duel.GetMatchingGroup(c33589910.filter2,tp,0,LOCATION_MZONE,nil)
if g:GetCount()>0 then
local tg=g
if tg:GetCount()>1 then
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SetTargetCard(tg)
Duel.HintSelection(g)
end
end
end


function c33589910.filter(c)
return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsFacedown()
end

function c33589910.filter3(c)
return c:IsType(TYPE_MONSTER) and c:IsFacedown()
end

function c33589910.filter2(c)
return c:IsType(TYPE_MONSTER) 
end 

function c33589910.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33589910.filter2,tp,0,LOCATION_MZONE,nil)
local tc=g:GetFirst()
while  tc do
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK)
e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
tc:RegisterEffect(e2)
tc=g:GetNext()
end
Duel.BreakEffect()
local g=Duel.GetMatchingGroup(c33589910.filter,tp,0,LOCATION_SZONE,nil)
if g:GetCount()>0 then
Duel.ChangePosition(g,POS_FACEUP)
end
Duel.BreakEffect()
local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_MZONE,nil)
if g:GetCount()>0 then
Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
end
end


