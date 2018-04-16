--Dark-Piercing light (DOR)
--scripted by GameMaster (GM) + MLD
function c33569928.initial_effect(c)
--
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33569928.target)
e1:SetOperation(c33569928.operation)
c:RegisterEffect(e1)
end
function c33569928.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsFacedown() and chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(1-tp) end
if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c33569928.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_ONFIELD,nil)
local stg=g:Filter(Card.IsType,nil,TYPE_SPELL+TYPE_TRAP)
local mg=g:Filter(Card.IsType,nil,TYPE_MONSTER)
if g:GetCount()>0 then
Duel.ChangePosition(stg,POS_FACEUP)
Duel.ChangePosition(mg,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK)
local sg=stg:Filter(function (c) return c:GetType()==TYPE_SPELL and c:IsFaceup() end,nil)
local sgc=sg:GetFirst()
while sgc do
local te=sgc:GetActivateEffect()
local tet=te:GetType()
if bit.band(tet,EFFECT_TYPE_ACTIVATE)>0 and Duel.GetTurnPlayer()==tp then
local e1=Effect.CreateEffect(sgc)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_SZONE)
if te:GetCost() then e1:SetCost(te:GetCost()) end
if te:GetCondition() then e1:SetCondition(te:GetCondition()) end
if te:GetTarget() then e1:SetTarget(te:GetTarget()) end
if te:GetOperation() then e1:SetOperation(te:GetOperation()) end
e1:SetReset(RESET_EVENT+0x1fe0000)
e1:SetCountLimit(1)
sgc:RegisterEffect(e1)
sgc:SetStatus(STATUS_ACTIVATED,true) 
sg:KeepAlive()-- keep alive then do stuff 
--Send to grave after activating -- special thanks to MLD for helping me.
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetRange(LOCATION_SZONE)
e2:SetCode(EVENT_CHAIN_SOLVED)
e2:SetLabelObject(sg)
e2:SetCondition(c33569928.condition)
e2:SetOperation(c33569928.operation2)
e2:SetReset(RESET_EVENT+0x1fe0000)
Duel.RegisterEffect(e2,tp)				
end
sgc=sg:GetNext()
end
end
end

function c33569928.condition(e,tp,eg,ep,ev,re,r,rp)
return e:GetLabelObject():IsContains(re:GetHandler())
end

function c33569928.operation2(e,tp,eg,ep,ev,re,r,rp)
return Duel.SendtoGrave(re:GetHandler(),REASON_EFFECT)
end