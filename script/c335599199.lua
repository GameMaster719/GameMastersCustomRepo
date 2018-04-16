--The Stern Mystic (DOR)
--scripted by GameMaster (GM)
function c335599199.initial_effect(c)
--fLIP cards FACEup
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_FLIP)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
e1:SetOperation(c335599199.operation)
c:RegisterEffect(e1)
end

function c335599199.operation(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
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
if bit.band(tet,EFFECT_TYPE_ACTIVATE)>0  then
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
e2:SetCondition(c335599199.condition)
e2:SetOperation(c335599199.operation2)
e2:SetReset(RESET_EVENT+0x1fe0000)
Duel.RegisterEffect(e2,tp)				
end
sgc=sg:GetNext()
end
end
end

function c335599199.condition(e,tp,eg,ep,ev,re,r,rp)
return e:GetLabelObject():IsContains(re:GetHandler())
end

function c335599199.operation2(e,tp,eg,ep,ev,re,r,rp)
return Duel.SendtoGrave(re:GetHandler(),REASON_EFFECT)
end

