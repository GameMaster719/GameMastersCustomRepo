--Mimicat (DOR)
--scripted by GameMaster (GM)
function c33599962.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33599962.tg)
e1:SetOperation(c33599962.activate)
c:RegisterEffect(e1)
end

--monster/st zone open
function c33599962.filter(c)
return c:IsType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER) 
end

--mzone full
function c33599962.filter2(c)
return c:IsType(TYPE_SPELL+TYPE_TRAP) 
end

--stzonefull
function c33599962.filter3(c)
return c:IsType(TYPE_MONSTER) 
end


function c33599962.tg(e,tp,eg,ep,ev,re,r,rp,chk)
--check for if location is greater than 1 by MLD
local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
local ft2=Duel.GetLocationCount(tp,LOCATION_MZONE)
local c=e:GetHandler()	
if chk==0 then return  Duel.IsExistingTarget(c33599962.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) and (ft>0 or ft2>0) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
Duel.SelectTarget(tp,c33599962.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,zone)
end




function c33599962.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
if tc and tc:IsType(TYPE_SPELL+TYPE_TRAP) then
Duel.SSet(tp,tc) 
tc:SetStatus(STATUS_SET_TURN,false)--allows activation of spell card the turn its set
else 
local c=e:GetHandler()
if Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEDOWN_ATTACK)~=0 then
Duel.SpecialSummonComplete()
tc:SetStatus(STATUS_SPSUMMON_TURN,false)--allows the monster to be flipped turn its summoned	
end
end
end


