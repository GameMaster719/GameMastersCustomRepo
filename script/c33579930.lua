--Spirit of the Books
function c33579930.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33579930,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c33579930.sptg)
	e1:SetOperation(c33579930.spop)
	c:RegisterEffect(e1)
end
function c33579930.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33579930.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,33579931,0,0x4011,1200,1200,3,RACE_REPTILE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,33579931)
	 Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEDOWN) 
	 local e1=Effect.CreateEffect(e:GetHandler())
e1:SetCategory(CATEGORY_POSITION)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_MZONE)
e1:SetCondition(c33579930.con)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetReset(RESET_PHASE+PHASE_END)
e1:SetOperation(c33579930.flipop)
token:RegisterEffect(e1)
--to defense
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetDescription(aux.Stringid(33579930,0))
e2:SetCategory(CATEGORY_POSITION)
e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e2:SetCode(EVENT_FLIP)
e2:SetTarget(c33579930.potg)
e2:SetOperation(c33579930.poop)
e2:SetReset(RESET_PHASE+PHASE_END)
token:RegisterEffect(e2)
	Duel.SpecialSummonComplete()
 Duel.ChangePosition(token,POS_FACEDOWN_DEFENSE)
end

function c33579930.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c33579930.poop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
	c:SetTurnCounter(0)
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end

function c33579930.con(e)
	return e:GetHandler():IsDefensePos()
end

function c33579930.flipop(e)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and c:IsFacedown() then
Duel.ChangePosition(c,POS_FACEUP_ATTACK)
end
end