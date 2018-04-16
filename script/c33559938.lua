--Sacred Stone of Ojhat (Aime)
--scripted by GameMaster(GM)
function c33559938.initial_effect(c)
c:EnableReviveLimit()
--special summon
local e0=Effect.CreateEffect(c)
e0:SetDescription(aux.Stringid(33559938,0))
e0:SetType(EFFECT_TYPE_FIELD)
e0:SetCode(EFFECT_SPSUMMON_PROC)
e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
e0:SetRange(LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
e0:SetCondition(c33559938.spcon)
c:RegisterEffect(e0)
--opponent cannot draw
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetCode(EFFECT_CANNOT_DRAW)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetTargetRange(0,1)
e1:SetCondition(c33559938.con3)
e1:SetValue(1)
e1:SetRange(LOCATION_MZONE)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_DRAW_COUNT)
e2:SetValue(0)
c:RegisterEffect(e2)
--opponent cannot summon/set monsters
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetCode(EFFECT_CANNOT_SUMMON)
e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e3:SetCondition(c33559938.con3)
e3:SetTargetRange(0,1)
e3:SetRange(LOCATION_MZONE)
c:RegisterEffect(e3)
local e4=e3:Clone()
e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
c:RegisterEffect(e4)
local e5=e4:Clone()
e5:SetCode(EFFECT_CANNOT_MSET)
c:RegisterEffect(e5)
--cannot set spells/traps/pendulums
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_FIELD)
e6:SetCode(EFFECT_CANNOT_SSET)
e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e6:SetRange(LOCATION_MZONE)
e6:SetCondition(c33559938.con3)
e6:SetTargetRange(0,1)
e6:SetTarget(aux.TRUE)
c:RegisterEffect(e6)
local e7=e6:Clone()
e7:SetCode(EFFECT_CANNOT_TURN_SET)
c:RegisterEffect(e7)
local e8=e5:Clone()
e8:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
c:RegisterEffect(e8)
-- Cannot Disable effect
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e9:SetProperty(EFFECT_FLAG_IMMEDIATELY_APPLY+EFFECT_FLAG_CANNOT_DISABLE)
e9:SetCode(EFFECT_CANNOT_DISABLE)
e9:SetRange(LOCATION_MZONE)
e9:SetCondition(c33559938.con1)
c:RegisterEffect(e9)
--cannot activate
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_FIELD)
e10:SetCode(EFFECT_CANNOT_ACTIVATE)
e10:SetRange(LOCATION_MZONE)
e10:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e10:SetTargetRange(0,1)
e10:SetCondition(c33559938.con3)
e10:SetValue(c33559938.actlimit)
c:RegisterEffect(e10)
end

function c33559938.actlimit(e,te,tp)
return te:IsHasType(EFFECT_TYPE_ACTIVATE) and te:GetHandler():IsType(TYPE_SPELL+TYPE_TRAP+TYPE_PENDULUM)
end



function c33559938.con1(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33559938.spfilter,tp,LOCATION_MZONE,0,1,nil,43730887)
and Duel.IsExistingMatchingCard(c33559938.spfilter,tp,LOCATION_MZONE,0,1,nil,70124586) then return true
else return false end
end

function c33559938.con3(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33559938.spfilter,tp,LOCATION_MZONE,0,1,nil,43730887)
and Duel.IsExistingMatchingCard(c33559938.spfilter,tp,LOCATION_MZONE,0,1,nil,70124586) then return true
else return false end
end


c33559938.collection={ [43730887]=true; [70124586]=true; [511000166]=true;  }

function c33559938.filter3(c)
return c:IsFaceup() and c33559938.collection[c:GetCode()]
end

function c33559938.spfilter(c,code)
return c:IsCode(code) and c:IsFaceup()
end
function c33559938.spcon(e,c)
if c==nil then return true end
local tp=c:GetControler()
return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c33559938.spfilter,tp,LOCATION_MZONE,0,1,nil,43730887)
	and Duel.IsExistingMatchingCard(c33559938.spfilter,tp,LOCATION_MZONE,0,1,nil,70124586)
end
