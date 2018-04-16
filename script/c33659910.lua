--Soul Demolition
--scripted by GameMaster(GM)
--refixed by GM 
function c33659910.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetCondition(c33659910.condition)
e1:SetCost(c33659910.cost)
e1:SetTarget(c33659910.target)
c:RegisterEffect(e1)
--remove opp monster- self
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33659910,0))
e2:SetCategory(CATEGORY_REMOVE)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
e2:SetType(EFFECT_TYPE_QUICK_O)
e2:SetRange(LOCATION_SZONE)
e2:SetCode(EVENT_FREE_CHAIN)
e2:SetCondition(c33659910.rmcon)
e2:SetCost(c33659910.rmcost)
e2:SetTarget(c33659910.rmtg)
e2:SetOperation(c33659910.rmop)
c:RegisterEffect(e2)
--opp remove monster-
local e3=Effect.CreateEffect(c)
e3:SetDescription(aux.Stringid(33659910,0))
e3:SetCategory(CATEGORY_REMOVE)
e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_BOTH_SIDE)
e3:SetType(EFFECT_TYPE_QUICK_O)
e3:SetRange(LOCATION_SZONE)
e3:SetCode(EVENT_FREE_CHAIN)
e3:SetCondition(c33659910.rmcon2)
e3:SetCost(c33659910.rmcost2)
e3:SetTarget(c33659910.rmtg2)
e3:SetOperation(c33659910.rmop2)
c:RegisterEffect(e3)
end
function c33659910.cfilter(c)
return c:IsFaceup() and c:IsRace(RACE_FIEND)
end
function c33659910.condition(e,tp,eg,ep,ev,re,r,rp)
return Duel.IsExistingMatchingCard(c33659910.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c33659910.cost(e,tp,eg,ep,ev,re,r,rp,chk)
e:SetLabel(1)
if chk==0 then return true end
end
function c33659910.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
local label=e:GetLabel()
if chkc then return c33659910.rmtg(e,tp,eg,ep,ev,re,r,rp,0,chkc) end
if chk==0 then
if label==1 then e:SetLabel(0) end
return true
end
if c33659910.rmcon(e,tp,eg,ep,ev,re,r,rp) and label==1 and c33659910.rmcost(e,tp,eg,ep,ev,re,r,rp,0) 
and c33659910.rmtg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,65) then
e:SetCategory(CATEGORY_REMOVE)
e:SetProperty(EFFECT_FLAG_CARD_TARGET)
e:SetOperation(c33659910.rmop)
c33659910.rmcost(e,tp,eg,ep,ev,re,r,rp,1)
c33659910.rmtg(e,tp,eg,ep,ev,re,r,rp,1)
else
e:SetCategory(0)
e:SetProperty(0)
e:SetOperation(nil)
end
end

--self
function c33659910.rmcon(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(c33659910.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c33659910.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckLPCost(tp,500) end
local lp=Duel.GetLP(tp)
local ct=Duel.GetTargetCount(c33659910.rfilter,tp,0,LOCATION_GRAVE,nil)
local t={}
local l=1
while l<=ct and l*500<=lp do
t[l]=l*500
l=l+1
end
Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(67196946,0))
local announce=Duel.AnnounceNumber(tp,table.unpack(t))
Duel.PayLPCost(tp,announce)
e:SetLabel(announce/500)
end
function c33659910.rfilter(c)
return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove() 
end
function c33659910.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c33659910.rfilter(chkc) end
if chk==0 then return Duel.IsExistingTarget(c33659910.rfilter,tp,0,LOCATION_GRAVE,1,nil) end
local ct=e:GetLabel()
e:SetLabel(0)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
local g=Duel.SelectTarget(tp,c33659910.rfilter,tp,0,LOCATION_GRAVE,ct,ct,nil)
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c33659910.rmop(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end


--opp
function c33659910.rmcon2(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==1-tp and Duel.IsExistingMatchingCard(c33659910.cfilter,tp,0,LOCATION_MZONE,1,nil)
end

function c33659910.rmcost2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckLPCost(tp,500) end
local lp=Duel.GetLP(tp)
local ct=Duel.GetTargetCount(c33659910.rfilter,tp,0,LOCATION_GRAVE,nil)
local t={}
local l=1
while l<=ct and l*500<=lp do
t[l]=l*500
l=l+1
end
Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(67196946,0))
local announce=Duel.AnnounceNumber(tp,table.unpack(t))
Duel.PayLPCost(tp,announce)
e:SetLabel(announce/500)
end

function c33659910.rfilter(c)
return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove() 
end

function c33659910.rmtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) and chkc:IsControler(1-tp) and c33659910.rfilter(chkc) end
if chk==0 then return Duel.IsExistingTarget(c33659910.rfilter,tp,0,LOCATION_GRAVE,1,nil) end
local ct=e:GetLabel()
e:SetLabel(0)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
local g=Duel.SelectTarget(tp,c33659910.rfilter,tp,0,LOCATION_GRAVE,ct,ct,nil)
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c33659910.rmop2(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
