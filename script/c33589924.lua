--Contruct of Mask (DOR)
function c33589924.initial_effect(c)
  --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c33589924.cost1)
    e1:SetTarget(c33589924.target1)
    e1:SetOperation(c33589924.activate1)
    c:RegisterEffect(e1)
  end  
    
 
c33589924.collection={ [28933734]=true;  }


function c33589924.filter1(c)
	return  c33589924.collection[c:GetCode()] 
end


function c33589924.filter2(c)
	return c:IsRace(RACE_SPELLCASTER) 
end


 
function c33589924.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c33589924.filter1,1,nil) and Duel.CheckReleaseGroup(tp,c33589924.filter2,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,c33589924.filter1,1,1,nil)
	local g1=Duel.SelectReleaseGroup(tp,c33589924.filter2,2,2,nil)
	g:Merge(g1)
	Duel.Release(g,REASON_COST)
end


function c33589924.target1(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
        and Duel.IsPlayerCanSpecialSummonMonster(tp,511005606,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) end
    Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c33589924.activate1(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
    if Duel.IsPlayerCanSpecialSummonMonster(tp,511005606,0,0x4011,500,1200,4,RACE_INSECT,ATTRIBUTE_EARTH) then
        for i=1,1 do
            local token=Duel.CreateToken(tp,511005606)
            Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
			--SUMMON CHANGE TO FACEDOWN
local e1=Effect.CreateEffect(token)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_SPSUMMON_SUCCESS)
e1:SetOperation(c33589924.op)
token:RegisterEffect(e1)
	Duel.SpecialSummonComplete()
    end
end
end
	
function c33589924.op(e,tp,eg,ep,ev,re,r,rp)
local token=e:GetHandler()
if bit.band(token:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL then
Duel.ChangePosition(token,POS_FACEDOWN_DEFENSE)
end
local e1=Effect.CreateEffect(token)
e1:SetCategory(CATEGORY_POSITION)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_MZONE)
e1:SetCondition(c33589924.con)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetReset(RESET_PHASE+PHASE_END)
e1:SetOperation(c33589924.flipop)
token:RegisterEffect(e1)
end 

function c33589924.con(e)
	return e:GetHandler():IsFacedown()
end

function c33589924.flipop(e)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and c:IsFacedown() then
Duel.ChangePosition(c,POS_FACEUP_ATTACK)
end
end	
	
	
