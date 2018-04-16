--Creature Swap DOR
--scrited by GameMaster(GM)
function c33599958.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_CONTROL)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33599958.target)
e1:SetOperation(c33599958.activate)
c:RegisterEffect(e1)
end

function c33599958.filter(c,pos)
return c:IsType(TYPE_MONSTER) and c:IsAbleToChangeControler() and c:GetPosition(pos)
end

function c33599958.filter1(c,e,tp)
return  c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_REMOVED) and not (c:IsType(TYPE_EQUIP) or c:IsType(TYPE_FIELD))
end


function c33599958.filter2(c,e,tp)
return  c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c33599958.filter3(c)
return  c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove() 
end

function c33599958.filter4(c)
return c:IsType(TYPE_TRAP+TYPE_SPELL) and c:IsSSetable()
end

function c33599958.tfilter(c)
return not c:IsAbleToChangeControler()
end

function c33599958.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local g1=Duel.GetMatchingGroup(c33599958.filter,tp,0,LOCATION_MZONE,nil)
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,g1:GetCount(),0,0)
local g12=Duel.GetMatchingGroup(c33599958.filter3,tp,0,LOCATION_SZONE,nil)
local g12=Duel.GetMatchingGroup(c33599958.filter3,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g12,g12:GetCount(),0,0)
local g2=Duel.GetMatchingGroup(c33599958.filter,tp,LOCATION_MZONE,0,nil)
local g2=Duel.GetMatchingGroup(c33599958.filter,tp,LOCATION_MZONE,0,nil)
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g2,g2:GetCount(),0,0)
local g21=Duel.GetMatchingGroup(c33599958.filter3,tp,0,LOCATION_SZONE,nil) 
local g21=Duel.GetMatchingGroup(c33599958.filter3,tp,0,LOCATION_SZONE,e:GetHandler())
Duel.SetOperationInfo(0,CATEGORY_REMOVE,g21,g21:GetCount(),0,0)
Duel.SetChainLimit(aux.FALSE)
end




function c33599958.activate(e,tp,eg,ep,ev,re,r,rp)


local c=e:GetHandler()
if  c:GetCode()==28297833  and c:GetLocation()==LOCATION_MZONE then
c:SetStatus( STATUS_TO_DISABLE,true) 
end

--remove opponents spells/traps

--faceups
local g120=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_SZONE,e:GetHandler())
local sp120=Duel.Remove(g120,POS_FACEUP,REASON_EFFECT)
--facedowns
local g12=Duel.GetMatchingGroup(c33599958.filter3,tp,0,LOCATION_SZONE,e:GetHandler())
local sp12=Duel.Remove(g12,POS_FACEDOWN,REASON_EFFECT)

--remove my spells/traps

--faceups
local g210=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_SZONE,0,e:GetHandler())
local sp210=Duel.Remove(g210,POS_FACEUP,REASON_EFFECT)
--facedowns
local g21=Duel.GetMatchingGroup(c33599958.filter3,tp,LOCATION_SZONE,0,e:GetHandler())
local sp21=Duel.Remove(g21,POS_FACEDOWN,REASON_EFFECT)
--remove opponents monsters
local g1=Duel.GetMatchingGroup(c33599958.filter,tp,0,LOCATION_MZONE,nil)
local sp1=Duel.Remove(g1,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)


--remove my monsters
local g2=Duel.GetMatchingGroup(c33599958.filter,tp,LOCATION_MZONE,0,nil)
local sp2=Duel.Remove(g2,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)
local c=e:GetHandler()

--send this card card to grave 
Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)	

if sp12 and sp12>0  then 
Duel.SSet(tp,g12)	
end
if sp120 and sp120>0 then 
Duel.SSet(tp,g120)
end
if sp21 and sp21>0 then 
Duel.SSet(1-tp,g21)	
end	
if  sp210 and sp210>0 then 
Duel.SSet(1-tp,g210)
end 
--faceup/down pos work around after field resets
local g13=Duel.GetMatchingGroup(c33599958.filter1,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
if g13:GetCount()>0  then
Duel.ChangePosition(g13,POS_FACEUP)
end
Duel.BreakEffect()	


local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
local ft2=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
if Duel.IsPlayerAffectedByEffect(1-tp,59822133) then ft=1 end
--summon 
if sp1 and sp1>0 then
local fid=e:GetHandler():GetFieldID()
local tc=g1:GetFirst()
while tc do
local pos=tc:GetPreviousPosition()
if pos==POS_FACEDOWN_DEFENSE then pos=POS_FACEDOWN_DEFENSE end
if pos==POS_FACEDOWN_ATTACK then pos=POS_FACEDOWN_ATTACK end
if pos==POS_FACEUP_DEFENSE then pos=POS_FACEUP_DEFENSE end
if pos==POS_FACEUP_ATTACK then pos=POS_FACEUP_ATTACK end
Duel.MoveToField(tc,e:GetHandlerPlayer(),e:GetHandlerPlayer(),LOCATION_MZONE,pos,true)
--control
local e1=Effect.CreateEffect(tc)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetRange(LOCATION_MZONE)
e1:SetCode(EFFECT_SET_CONTROL)
e1:SetValue(1)
tc:RegisterEffect(e1)
--Duel.SpecialSummonStep(tc,0,tp,tp,false,false,tc:GetPreviousPosition(),true)--
tc:RegisterFlagEffect(33599958,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
tc=g1:GetNext()
end

g1:KeepAlive()
end
--summon to opponents field
if sp2 and sp2>0 then
local fid=e:GetHandler():GetFieldID()
local tc=g2:GetFirst()
while tc do
local pos=tc:GetPreviousPosition()
if pos==POS_FACEDOWN_DEFENSE then pos=POS_FACEDOWN_DEFENSE end
if pos==POS_FACEDOWN_ATTACK then pos=POS_FACEDOWN_ATTACK end
if pos==POS_FACEUP_DEFENSE then pos=POS_FACEUP_DEFENSE end
if pos==POS_FACEUP_ATTACK then pos=POS_FACEUP_ATTACK end
Duel.MoveToField(tc,1-e:GetHandlerPlayer(),1-e:GetHandlerPlayer(),LOCATION_MZONE,pos,true)
--control-- used after move to field set control of monsters to prevent dancing move-
local e1=Effect.CreateEffect(tc)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetRange(LOCATION_MZONE)
e1:SetCode(EFFECT_SET_CONTROL)
e1:SetValue(0)
tc:RegisterEffect(e1)
--Duel.SpecialSummonStep(tc,0,1-tp,1-tp,false,false,tc:GetPreviousPosition(),true)--
tc:RegisterFlagEffect(33599958,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
tc=g2:GetNext()
end

g2:KeepAlive()

end

end

