--Ancient Lamp Anime
--scripted by GameMaster(GM)
function c33659903.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetHintTiming(0,TIMING_ATTACK)
e1:SetCode(EVENT_ATTACK_ANNOUNCE)
e1:SetTarget(c33659903.target)
e1:SetCondition(c33659903.condition)
e1:SetOperation(c33659903.activate)
c:RegisterEffect(e1)
--change attack target
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e2:SetRange(LOCATION_MZONE)
e2:SetCode(EVENT_ATTACK_ANNOUNCE)
e2:SetTarget(c33659903.tg2)
e2:SetOperation(c33659903.op2)
e2:SetCondition(c33659903.con2)
c:RegisterEffect(e2)
end
-------------------------------------------
function c33659903.con2(e,tp,eg,ep,ev,re,r,rp)
local a=Duel.GetAttacker()
local d=Duel.GetAttackTarget()
return Duel.GetTurnPlayer()~=tp and Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_MZONE,2,nil,TYPE_MONSTER)  and (d~=nil and d:GetControler()==e:GetHandlerPlayer() and d:IsCode(97590747)  and d:IsRelateToBattle(a)) 
end

function c33659903.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,Duel.GetAttacker())
end

function c33659903.op2(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
if tc and tc:IsRelateToEffect(e) then
local a=Duel.GetAttacker()
local d=Duel.GetAttackTarget()
if a==nil then return end
--Duel.ChangeAttackTarget(tc)
Duel.CalculateDamage(a,tc)
end
end


-------------------------------------------
function c33659903.cfilter(c)
return c:IsFaceup() and c:IsCode(97590747)
end

function c33659903.condition(e,tp,eg,ep,ev,re,r,rp)
local a=Duel.GetAttacker()
local d=Duel.GetAttackTarget()
return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_MZONE,2,nil,TYPE_MONSTER)  and (d~=nil and d:GetControler()==e:GetHandlerPlayer() and d:IsCode(97590747)  and d:IsRelateToBattle(a)) 
end

function c33659903.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
Duel.IsPlayerCanSpecialSummonMonster(tp,33659903,0,0x11,900,1400,3,RACE_SPELLCASTER,ATTRIBUTE_WIND) and Duel.IsExistingMatchingCard(c33659903.cfilter,tp,LOCATION_MZONE,0,1,nil) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c33659903.activate(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if not c:IsRelateToEffect(e) then return end
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
or not Duel.IsPlayerCanSpecialSummonMonster(tp,33659903,0,0x11,900,1400,3,RACE_SPELLCASTER,ATTRIBUTE_WIND) then return end
c:AddMonsterAttribute(TYPE_EFFECT+TYPE_TRAP)
Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP)
c:AddMonsterAttributeComplete()
Duel.SpecialSummonComplete()
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,nil,tp,0,LOCATION_MZONE,1,1,Duel.GetAttacker())
local tc=Duel.GetFirstTarget()
if tc and tc:IsRelateToEffect(e) then
local a=Duel.GetAttacker()
local d=Duel.GetAttackTarget()
if a==nil then return end
--Duel.ChangeAttackTarget(tc)
Duel.CalculateDamage(a,tc)
end
end