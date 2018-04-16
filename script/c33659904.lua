--Pot of envy
--scripted by GameMaster(GM)
function c33659904.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_TOKEN)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33659904.target)
e1:SetOperation(c33659904.activate)
c:RegisterEffect(e1)
end

function c33659904.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>1 end
Duel.SetTargetPlayer(tp)
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,0,1-tp,1)
end


function c33659904.activate(e,tp,eg,ep,ev,re,r,rp)
--check opponents hand if 2cards or >
local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
if g:GetCount()>1 then
Duel.ConfirmCards(tp,g)
Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33659904,0))
local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,0,LOCATION_HAND,2,2,nil)
if g:GetCount()<2 then return end
Duel.ConfirmCards(1-tp,g)
Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(33659904,1))
local sg=g:Select(1-tp,1,1,nil)
Duel.SetTargetCard(sg)
local tc=Duel.GetFirstTarget()
if tc  then
local token=Duel.CreateToken(tp,tc:GetOriginalCode())
Duel.SendtoHand(token,tp,REASON_EFFECT)
end
end
Duel.ShuffleHand(1-tp)
end

