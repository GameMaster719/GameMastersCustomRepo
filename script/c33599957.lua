--Shift (DOR)
--scripted by GameMaster(GM)
function c33599957.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DESTROY)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33599957.tg)
e1:SetOperation(c33599957.activate)
c:RegisterEffect(e1)
end

function c33599957.filter2(c)
return c:IsType(TYPE_MONSTER) 
end

function c33599957.tg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return  Duel.IsExistingTarget(c33599957.filter2,tp,LOCATION_MZONE,0,1,nil) end
local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
if g:GetCount()>0 then
	local tg=g:GetMaxGroup(Card.GetAttack) end
end

function c33599957.filter(c,e,tp)
local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_MZONE,0,c,TYPE_MONSTER)
local tg=g:GetMaxGroup(Card.GetAttack)
return  tg 
end


function c33599957.activate(e,tp,eg,ep,ev,re,r,rp)
local seq=e:GetHandler():GetSequence()
if not e:GetHandler():IsRelateToEffect(e) then return end
local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
if g:GetCount()>0 then
local tg=g:GetMaxGroup(Card.GetAttack)
local tc=tg:GetFirst()
Duel.MoveSequence(tc,seq)
end
end


