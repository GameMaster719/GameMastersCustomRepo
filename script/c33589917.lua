--Jigen Bakudan (DOR)
--scripted by GameMaster (GM)
function c33589917.initial_effect(c)
--Destruction effect
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33589917,0))
e1:SetCategory(CATEGORY_DESTROY)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e1:SetRange(LOCATION_MZONE)
e1:SetCode(EVENT_PREDRAW)
e1:SetCondition(c33589917.con)
e1:SetCost(c33589917.cost)
e1:SetOperation(c33589917.desop)
c:RegisterEffect(e1)
--get turn counter
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e2:SetCode(EVENT_PREDRAW)
e2:SetRange(LOCATION_MZONE)
e2:SetCondition(function(e) return e:GetHandler():IsDefensePos() end)   
e2:SetCountLimit(1)
e2:SetOperation(function (e) e:GetHandler():SetTurnCounter(e:GetHandler():GetTurnCounter()+1) end)
c:RegisterEffect(e2)
--to defense
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(33589917,0))
e4:SetCategory(CATEGORY_POSITION)
e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e4:SetCode(EVENT_SUMMON_SUCCESS)
e4:SetTarget(c33589917.potg)
e4:SetOperation(c33589917.poop)
c:RegisterEffect(e4)
local e5=e4:Clone()
e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
c:RegisterEffect(e5)
local e6=e4:Clone()
e4:SetCode(EVENT_SPSUMMON_SUCCESS)
c:RegisterEffect(e4)
c:SetTurnCounter(0)
end

function c33589917.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return e:GetHandler():IsAttackPos() end
Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c33589917.poop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
c:SetTurnCounter(0)
Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
end
end


function c33589917.con(e,tp)
return e:GetHandler():IsDefensePos() and Duel.GetTurnPlayer==tp
end


function c33589917.desop(e,tp,eg,ep,ev,re,r,rp)
local seq=e:GetHandler():GetPreviousSequence()
local g=Group.CreateGroup()
if seq>0 then
local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq-1)
if tc  then g:AddCard(tc) end
end
if seq<4 then
local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq+1)
if tc then g:AddCard(tc) end
local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,seq)
if tc then g:AddCard(tc) end
end
local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,seq-1)
if tc  then g:AddCard(tc) end
local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,seq+1)
if tc  then g:AddCard(tc) end
local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4-seq)
if tc then g:AddCard(tc) end
local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,4+seq)
if tc then g:AddCard(tc) end
if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end

function c33589917.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end	


function c33589917.con(e,c)
if c==nil then return true end
return e:GetHandler():GetTurnCounter(e)==2  and  e:GetHandler():IsDefensePos()
end