--Raigeki (DOR)
--scripted by GameMaster(GM)
--*This card version works in percy pre link version- 511005783 works in link version
function c33559921.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DESTROY)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33559921.target)
e1:SetOperation(c33559921.activate)
c:RegisterEffect(e1)
end

function c33559921.filter(c)
return c:IsType(TYPE_MONSTER)
end

function c33559921.target(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
local seq=e:GetHandler():GetSequence()
local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
if chk==0 then return true end
local g=Group.CreateGroup()
if tc then g:AddCard(tc) end
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end

function c33559921.activate(e,tp,eg,ep,ev,re,r,rp)
local seq=e:GetHandler():GetSequence()
 local g=Group.CreateGroup()
 local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
 if tc then g:AddCard(tc) end
 local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
if tc then g:AddCard(tc) end
if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT) end
end