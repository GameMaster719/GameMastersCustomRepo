--Catapult Turtle (DOR)
--scripted by GameMaster(GM) 
function c33599990.initial_effect(c)
--Destroy Labrynith wall and move cannon
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetDescription(aux.Stringid(33599988,0))
e1:SetRange(LOCATION_ONFIELD)
e1:SetCountLimit(1)
e1:SetCost(c33599990.Pcost)
e1:SetOperation(c33599990.op)
c:RegisterEffect(e1)
--Destroy Labrynith wall and move cannon
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_IGNITION)
e2:SetDescription(aux.Stringid(33599988,1))
e2:SetRange(LOCATION_ONFIELD)
e2:SetCountLimit(1)
e2:SetCost(c33599990.Pcost2)
c:RegisterEffect(e2)
end

function c33599990.filter(c)
return c:GetOriginalCode()==33599901 
end

function c33599990.Pcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33599990.filter,tp,LOCATION_MZONE,0,1,nil,c) end
local c = Duel.SelectMatchingCard(tp,c33599990.filter,tp,LOCATION_MZONE,0,1,1,nil,c)
e:SetLabel(c:GetFirst():GetSequence())--thanks to MLD  (get seq before you blow it up)- call it in cost then use label in operation
Duel.Destroy(c,REASON_COST) 
end

function c33599990.op(e,tp,eg,ep,ev,re,r,rp,chk)
Duel.MoveSequence(e:GetHandler(),e:GetLabel())
end

function c33599990.Pcost2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33599990.filter,tp,LOCATION_SZONE,0,1,nil,c) end
local c = Duel.SelectMatchingCard(tp,c33599990.filter,tp,LOCATION_SZONE,0,1,1,nil,c)
Duel.Destroy(c,REASON_COST) 
end

