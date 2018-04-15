--Magical Neutralizing ForceField
--scripted by GameMaster(GM)
function c33559913.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33559913,0))
e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE+CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CARD_TARGET)
e1:SetTarget(c33559913.target)
e1:SetOperation(c33559913.activate)
c:RegisterEffect(e1)
end


function c33559913.filter1(c)
return c:IsFaceup() and (c:IsType(TYPE_SPELL+TYPE_TOKEN) and not c:IsCode(22222234))
end

function c33559913.filter2(c)
return c:IsFaceup()
end

function c33559913.filter3(c)
return c:IsFaceup() and (c:IsType(TYPE_TOKEN) and not c:IsCode(22222234))
end

function c33559913.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chkc then return chkc:IsOnField() and c33559913.filter(chkc) and chkc~=e:GetHandler() end
if chk==0 then return Duel.IsExistingTarget(c33559913.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
local dg=Duel.GetMatchingGroup(c33559913.filter1,tp,0,LOCATION_ONFIELD,nil)
local g2=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_MZONE,nil,511005062)
local g3=Duel.GetMatchingGroup(c33559913.filter3,tp,0,LOCATION_MZONE,nil)
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,g2:GetCount(),0,0)
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g3,g3:GetCount(),0,0)
Duel.SetOperationInfo(0,CATEGORY_NEGATE,dg,dg:GetCount(),0,0)
Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
Duel.SetOperationInfo(0,CATEGORY_DISABLE,dg,dg:GetCount(),0,0)
end
function c33559913.activate(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local dg=Duel.GetMatchingGroup(c33559913.filter1,tp,0,LOCATION_ONFIELD,nil)
local tc=dg:GetFirst()
while tc do
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_DISABLE)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_DISABLE_EFFECT)
e2:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e2)
tc=dg:GetNext()
Duel.Destroy(dg,REASON_EFFECT)
end
--destroy magical hat token/monsters-they were made as monsters not treated as tok.	
Duel.BreakEffect()
local g2=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_ONFIELD,nil,511005062)
local tc=g2:GetFirst()
while tc do
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_DISABLE)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_DISABLE_EFFECT)
e2:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e2)
tc=g2:GetNext()
Duel.Destroy(g2,REASON_EFFECT)
end
Duel.BreakEffect()
local g3=Duel.GetMatchingGroup(c33559913.filter3,tp,0,LOCATION_ONFIELD,nil)
local tc=g3:GetFirst()
while tc do
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_DISABLE)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_DISABLE_EFFECT)
e2:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e2)
tc=g3:GetNext()
Duel.Destroy(g3,REASON_EFFECT)
end
end



----Activate
function c33559913.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetValue(c33559913.imfilter)
e1:SetReset(RESET_CHAIN)
Duel.RegisterEffect(e1,tp)
end
function c33559913.imfilter(e,re)
return re:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER) and re:GetOwner()~=e:GetOwner()
end