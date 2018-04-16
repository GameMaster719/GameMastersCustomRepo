--Royal Decree(DOR)
--scripted by GameMaster (GM)
function c33589933.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_CHAINING)
e1:SetOperation(c33589933.activate)
e1:SetTarget(c33589933.target)
e1:SetCondition(c33589933.condition)
c:RegisterEffect(e1)
--negate destroy ritual
local e2=Effect.CreateEffect(c)
e2:SetCategory(CATEGORY_NEGATE)
e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_QUICK_F)
e2:SetCode(EVENT_CHAINING)
e2:SetRange(LOCATION_SZONE)
e2:SetCondition(c33589933.condition)
e2:SetTarget(c33589933.target)
e2:SetOperation(c33589933.activate)
c:RegisterEffect(e2)
--activate turn set
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e3:SetCode(EVENT_SSET)
e3:SetOperation(c33589933.op) 
Duel.RegisterEffect(e3,0)
end

function c33589933.op(e,tp,eg,ep,ev,re,r,rp)
local c=eg:GetFirst()
while c do
if c:GetOriginalCode()==33589933 then c:SetStatus(STATUS_SET_TURN,false) end
c=eg:GetNext()
end
end


function c33589933.condition(e,tp,eg,ep,ev,re,r,rp)
return re:GetHandler()~=e:GetHandler() and re:IsActiveType(TYPE_TRAP)  and Duel.IsChainNegatable(ev) 
end

function c33589933.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end


function c33589933.activate(e,tp,eg,ep,ev,re,r,rp)
local ec=re:GetHandler()
Duel.NegateEffect(ev)
if re:GetHandler():IsRelateToEffect(re) and re:IsActiveType(TYPE_CONTINUOUS) then
	ec:CancelToGrave()
	
end
end
