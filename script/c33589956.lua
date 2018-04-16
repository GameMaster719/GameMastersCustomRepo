--Kumbhandas wrath
--scripted by GameMaster(GM)
function c33589956.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetTarget(c33589956.target)
e1:SetOperation(c33589956.activate)
c:RegisterEffect(e1)
end

--special summon 2 Black binding tokens
function c33589956.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222235,0,0x4011,0,0,1,RACE_REPTILE,ATTRIBUTE_DEVINE) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end

function c33589956.activate(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
if not Duel.IsPlayerCanSpecialSummonMonster(tp,22222235,0,0x4011,0,0,1,RACE_REPTILE,ATTRIBUTE_DEVINE) then return end
for i=1,2 do
local token=Duel.CreateToken(tp,22222235)
Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
e1:SetReset(RESET_EVENT+0x1fe0000)
token:RegisterEffect(e1,true)
token:SetStatus(STATUS_NO_LEVEL,true)
token:SetStatus(STATUS_NO_SCALE,true)
end
Duel.SpecialSummonComplete()
end


