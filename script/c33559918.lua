--Larva of moth (DOR)
--scripted by GameMaster (GM)
function c33559918.initial_effect(c)
--if destroyed summon larva moth
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33559918,1))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e1:SetCode(EVENT_BATTLE_DESTROYED)
e1:SetCondition(c33559918.condition)
e1:SetTarget(c33559918.target)
e1:SetOperation(c33559918.operation)
c:RegisterEffect(e1)
--cannot attack
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e2:SetRange(LOCATION_MZONE)
e2:SetCode(EFFECT_CANNOT_ATTACK)
c:RegisterEffect(e2)
--to defense
local e3=Effect.CreateEffect(c)
e3:SetDescription(aux.Stringid(33559918,0))
e3:SetCategory(CATEGORY_POSITION)
e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
e3:SetCode(EVENT_SUMMON_SUCCESS)
e3:SetTarget(c33559918.potg)
e3:SetOperation(c33559918.poop)
c:RegisterEffect(e3)
local e4=e3:Clone()
e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
c:RegisterEffect(e4)
local e5=e3:Clone()
e5:SetCode(EVENT_SPSUMMON_SUCCESS)
c:RegisterEffect(e5)
--special summon pupa of moth
local e6=Effect.CreateEffect(c)
e6:SetDescription(aux.Stringid(33559918,0))
e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e6:SetRange(LOCATION_MZONE)
e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
e6:SetCondition(c33559918.spcon)
e6:SetCost(c33559918.spcost)
e6:SetTarget(c33559918.sptg)
e6:SetOperation(c33559918.spop)
c:RegisterEffect(e6)
--required
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e7:SetCode(EVENT_CHANGE_POS)
e7:SetOperation(c33559918.regop)
e7:SetCondition(c33559918.condition2)
c:RegisterEffect(e7)
--get turn counter
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e8:SetCode(EVENT_PHASE+PHASE_END)
e8:SetRange(LOCATION_MZONE)
e8:SetCountLimit(1)
e8:SetCondition(c33559918.condition2)
e8:SetOperation(c33559918.op7)
c:RegisterEffect(e8)
end

c33559918.collection={ [87756343]=true; [511002500]=true;  }


--counter reset at 4 ct
function c33559918.op7(e,tp,eg,ep,ev,re,r,rp)
local ct=e:GetLabel()
ct=ct+1
e:SetLabel(ct)
e:GetHandler():SetTurnCounter(ct)
if ct==4 then
e:Reset()
end
end


--position change
function c33559918.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return e:GetHandler():IsAttackPos() end
Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c33559918.poop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
c:SetTurnCounter(0)
Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
end
end
--count summon
function c33559918.regop(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(33559918,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
end

function c33559918.condition2(e)
return e:GetHandler():IsDefensePos()
end
function c33559918.spcon(e,c)
if c==nil then return true end
return e:GetHandler():GetTurnCounter(e)==4
end
function c33559918.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c33559918.spfilter2(c,e,tp)
return c:IsCode(511005602) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c33559918.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsExistingMatchingCard(c33559918.spfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c33559918.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
local g=Duel.SelectMatchingCard(tp,c33559918.spfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
local tc=g:GetFirst()
if tc then
Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
tc:CompleteProcedure()
end
end
------------------------------
--summon larva moth
function c33559918.condition(e,tp,eg,ep,ev,re,r,rp)
return not e:GetHandler():IsLocation(LOCATION_DECK) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c33559918.spfilter(c,e,tp)
return c33559918.collection[c:GetCode()] and c:IsRace(RACE_INSECT) and c:IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACE_UP)
end
function c33559918.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsExistingMatchingCard(c33559918.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c33559918.operation(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
local g=Duel.SelectMatchingCard(tp,c33559918.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
if g:GetCount()>0 then
Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
Duel.ConfirmCards(1-tp,g)
end
Duel.SpecialSummonComplete()
end
