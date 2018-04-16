--Brain Control (DOR)
--scripted by GameMaster(GM)
function c33599985.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_CONTROL)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33599985.target)
e1:SetOperation(c33599985.activate)
c:RegisterEffect(e1)
end

function c33599985.filter(c,e,tp)
return c:IsControlerCanBeChanged() 
end

function c33599985.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return  Duel.IsExistingTarget(c33599985.filter,tp,0,LOCATION_MZONE,1,nil) end
local g=Duel.GetMatchingGroup(c33599985.filter,tp,0,LOCATION_MZONE,nil)
if g:GetCount()>0 then
local tg=g:GetMaxGroup(Card.GetAttack) end
return tg 
end

function c33599985.activate(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local g=Duel.GetMatchingGroup(c33599985.filter,tp,0,LOCATION_MZONE,nil)
if g:GetCount()>0 then
local tg=g:GetMaxGroup(Card.GetAttack)
local tc=tg:GetFirst()
Duel.GetControl(tc,tp,PHASE_END,1)
end
end


