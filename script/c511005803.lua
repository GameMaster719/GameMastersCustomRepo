--Embryonic Beast (DOR)
--scripted by GameMaster (GM)
function c511005803.initial_effect(c)
--special summon Ryu-Kyshin
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(511005803,0))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e1:SetRange(LOCATION_MZONE)
e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
e1:SetCondition(c511005803.spcon)
e1:SetCost(c511005803.spcost)
e1:SetTarget(c511005803.sptg)
e1:SetOperation(c511005803.spop)
c:RegisterEffect(e1)
--get turn counter
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e2:SetCode(EVENT_PREDRAW)
e2:SetRange(LOCATION_MZONE)
e2:SetCountLimit(1)
e2:SetCondition(c511005803.con2)
e2:SetOperation(c511005803.op2)
c:RegisterEffect(e2)
--required
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e3:SetCode(EVENT_CHANGE_POS)
e3:SetOperation(c511005803.regop)
e3:SetCondition(c511005803.con)
c:RegisterEffect(e3)
--to defense
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(511005803,0))
e4:SetCategory(CATEGORY_POSITION)
e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e4:SetCode(EVENT_SUMMON_SUCCESS)
e4:SetTarget(c511005803.potg)
e4:SetOperation(c511005803.poop)
c:RegisterEffect(e4)
local e5=e4:Clone()
e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
c:RegisterEffect(e5)
local e6=e4:Clone()
e4:SetCode(EVENT_SPSUMMON_SUCCESS)
c:RegisterEffect(e4)
end

function c511005803.con2(e,tp)
return (Duel.GetTurnPlayer()==tp and e:GetHandler():IsDefensePos() )
end

--counter set with reset - reset at 3 ct
function c511005803.op2(e,tp,eg,ep,ev,re,r,rp)
local ct=e:GetLabel()
ct=ct+1
e:SetLabel(ct)
e:GetHandler():SetTurnCounter(ct)
if ct==3 then
e:Reset()
end
end

function c511005803.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return e:GetHandler():IsAttackPos() end
Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end

function c511005803.poop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
c:SetTurnCounter(0)
Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
end
end

function c511005803.regop(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(511005803,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
end

function c511005803.con(e)
return e:GetHandler():IsDefensePos()
end

function c511005803.spcon(e,c)
if c==nil then return true end
return e:GetHandler():GetTurnCounter(e)==3 and  e:GetHandler():IsDefensePos()
end

function c511005803.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end

function c511005803.spfilter2(c,e,tp)
return c:IsCode(15303296) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end

function c511005803.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
and Duel.IsExistingMatchingCard(c511005803.spfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end

function c511005803.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
local g=Duel.SelectMatchingCard(tp,c511005803.spfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
local tc=g:GetFirst()
if tc then
Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
tc:CompleteProcedure()
end
end

