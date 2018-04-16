--Three Card Summon
--Scripted by GameMaster(GM)
function c33599914.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetCost(c33599914.Cost)
e1:SetOperation(c33599914.activate)
c:RegisterEffect(e1)
end

--hand filter of monster
function c33599914.filterlv1d(c,lv)
return  c:IsType(TYPE_MONSTER) and c:GetLevel()==4
end
function c33599914.filterlv1c(c,lv)
return c:IsType(TYPE_MONSTER) and c:GetLevel()==3
end

function c33599914.filterlv1b(c,lv)
return  c:IsType(TYPE_MONSTER) and c:GetLevel()==2
end

function c33599914.filterlv1a(c,lv)
return c:IsType(TYPE_MONSTER) and c:GetLevel()==1
end
function c33599914.filter0(c)
return c:IsType(TYPE_MONSTER) and c:IsLevelBelow(4)
end
--level filter
function c33599914.filter2(c,rc)
return c:GetLevel()==rc 
end

function c33599914.filter3(c)
return c:GetLevel()==rc 
end

function c33599914.Cost(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and c33599914.filter0(chkc) end
if chk==0 then return Duel.IsExistingTarget(c33599914.filterlv1a,tp,LOCATION_HAND,0,3,nil) or 
Duel.IsExistingTarget(c33599914.filterlv1b,tp,LOCATION_HAND,0,3,nil) or 
Duel.IsExistingTarget(c33599914.filterlv1c,tp,LOCATION_HAND,0,3,nil) or 
Duel.IsExistingTarget(c33599914.filterlv1d,tp,LOCATION_HAND,0,3,nil) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
local g1=Duel.SelectTarget(tp,c33599914.filter0,tp,LOCATION_HAND,0,1,1,nil)
local rc=g1:GetFirst():GetLevel()
if Duel.IsExistingTarget(c33599914.filter2,tp,LOCATION_HAND,0,2,g1:GetFirst(),rc) then
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,c33599914.filter2,tp,LOCATION_HAND,0,2,2,g1:GetFirst(),rc)
end
end

function c33599914.activate(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
Duel.ConfirmCards(1-tp,g)
if g:GetCount()<3 then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
local sg=g:Select(tp,1,1,nil)
local tc=sg:GetFirst()
if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) then
Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end
end



