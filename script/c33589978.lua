--DARK MAGIC Ritual (DOR)
function c33589978.initial_effect(c)
  --Activate 
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c33589978.cost1)
    e1:SetTarget(c33589978.target1)
    e1:SetOperation(c33589978.activate1)
    c:RegisterEffect(e1)
  end  
  
function c33589978.filter1(c)
	return  c:IsType(TYPE_MONSTER) and c:GetAttack()<=1500
end

 function c33589978.filter2(c)
	return  c:IsCode(46986414)
end
 
 
function c33589978.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c33589978.filter1,2,nil) and Duel.CheckReleaseGroup(tp,c33589978.filter2,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=Duel.SelectReleaseGroup(tp,c33589978.filter2,1,1,nil)
	local g=Duel.SelectReleaseGroup(tp,c33589978.filter1,2,2,nil)
	g:Merge(g1)
	Duel.Release(g,REASON_COST)
end


function c33589978.target1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
        and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsPlayerCanSpecialSummonMonster(tp,30208479,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) end
    Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33589978.activate1(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
    if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
        and Duel.IsPlayerCanSpecialSummonMonster(tp,30208479,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) then
        for i=1,1 do
            local token=Duel.CreateToken(tp,30208479)
            Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
			--SUMMON CHANGE TO FACEDOWN
local e1=Effect.CreateEffect(token)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_SPSUMMON_SUCCESS)
e1:SetOperation(c33589978.op)
token:RegisterEffect(e1)
	Duel.SpecialSummonComplete()
    end
end
end
	
function c33589978.op(e,tp,eg,ep,ev,re,r,rp)
local token=e:GetHandler()
if bit.band(token:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL then
Duel.ChangePosition(token,POS_FACEDOWN_DEFENSE)
end
local e1=Effect.CreateEffect(token)
e1:SetCategory(CATEGORY_POSITION)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_MZONE)
e1:SetCondition(c33589978.con)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetReset(RESET_PHASE+PHASE_END)
e1:SetOperation(c33589978.flipop)
token:RegisterEffect(e1)
end 

function c33589978.con(e)
	return e:GetHandler():IsFacedown()
end

function c33589978.flipop(e)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and c:IsFacedown() then
Duel.ChangePosition(c,POS_FACEUP_ATTACK)
end
end	
	
	
