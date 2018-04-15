--Antopolis
--scripted by GameMaster(GM)
function c22335502.initial_effect(c)
--special summon 2 tokens to opponents side when destroyed
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e1:SetCode(EVENT_DESTROYED)
e1:SetCondition(c22335502.con)
e1:SetOperation(c22335502.op)
c:RegisterEffect(e1)
end

function c22335502.con(e,c)
local c=e:GetHandler()
local tp=c:GetControler()
return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>=2 
and Duel.IsPlayerCanSpecialSummonCount(1-tp,2)
end

function c22335502.op(e,tp,eg,ep,ev,re,r,rp,c)
for i=1,2 do
local token=Duel.CreateToken(1-tp,22335503)
Duel.SpecialSummonStep(token,0,1-tp,1-tp,false,false,POS_FACEUP)
--tokens effect goes here before  special summon complete**
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UNRELEASABLE_SUM)
e1:SetValue(1)
token:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
token:RegisterEffect(e2)
--damage+recover
local e3=Effect.CreateEffect(e:GetHandler())
e3:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e3:SetRange(LOCATION_MZONE)
e3:SetCountLimit(1)
e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
e3:SetCondition(c22335502.damcon)
e3:SetTarget(c22335502.damtg)
e3:SetOperation(c22335502.damop)
token:RegisterEffect(e3)
end
Duel.SpecialSummonComplete()
end
function c22335502.damcon(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==tp
end

function c22335502.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(300)
Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,300)
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,300)
end

function c22335502.damop(e,tp,eg,ep,ev,re,r,rp)
Duel.Damage(tp,300,REASON_EFFECT)
Duel.Recover(1-tp,300,REASON_EFFECT)
end


