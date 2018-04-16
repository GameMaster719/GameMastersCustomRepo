--Rare Hunter's Invisable ink 
--Scripted by GameMaster
function c33659909.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_SEARCH)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33659909.target)
e1:SetOperation(c33659909.activate)
c:RegisterEffect(e1)
end

c33659909.collection={ [7902349]=true; [44519536]=true; [8124921]=true; [70903634]=true; [33396948]=true; }
 
function c33659909.filter(c)
    return  c:IsType(TYPE_MONSTER) and  c33659909.collection[c:GetCode()] and not c:ReverseInDeck()
end

function c33659909.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33659909.filter,tp,LOCATION_DECK,0,1,nil) end
Duel.SetOperationInfo(0,CATEGORY_SEARCH,nil,nil,tp,LOCATION_DECK)
end



function c33659909.activate(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c33659909.filter,tp,LOCATION_DECK,0,nil)
    local tc=g:GetFirst()
    while tc do
        tc:ReverseInDeck()
        tc=g:GetNext()
    end
end





