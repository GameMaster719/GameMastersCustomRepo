--power of pride
--scripted by GameMaster (GM)
function c33559911.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33559911.tg)
e1:SetOperation(c33559911.activate)
c:RegisterEffect(e1)
end

function c33559911.filter1(c)
return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end

function c33559911.filter2(c)
return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_EFFECT)
end


function c33559911.tg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingTarget(c33559911.filter1,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingTarget(c33559911.filter2,tp,LOCATION_MZONE,0,1,nil) end
Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33559911,0))
local g1=Duel.SelectTarget(tp,c33559911.filter1,tp,LOCATION_MZONE,0,1,1,nil) --first target
Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33559911,1))
local g2=Duel.SelectTarget(tp,c33559911.filter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst()) --second target
Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,g1,1,tp,0)
Duel.SetOperationInfo(0,CATEGORY_RELEASE,g2,1,tp,0)
end

function c33559911.activate(e,tp,eg,ep,ev,re,r,rp)
local gg,g1=Duel.GetOperationInfo(0,CATEGORY_ANNOUNCE)
local gg,g2=Duel.GetOperationInfo(0,CATEGORY_RELEASE)
local tc1=g1:GetFirst()
local tc2=g2:GetFirst()
if tc1 and tc1:IsRelateToEffect(e) and tc2 and tc2:IsRelateToEffect(e) then
Duel.Release(tc2,REASON_COST)
Duel.SetTargetCard(tc2)
tc1:CreateEffectRelation(e)
tc1:CopyEffect(tc2:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
end
end
