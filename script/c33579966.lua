--A Deal with Dark Ruler (Anime)
--scripted by GameMaster (GM)
function c33579966.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c33579966.condition)
	e1:SetCost(c33579966.cost)
	e1:SetTarget(c33579966.target)
	e1:SetOperation(c33579966.activate)
	c:RegisterEffect(e1)
	
end

function c33579966.filter(c,e,tp)
	return c:IsCode(85605684) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end

function c33579966.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))	
	end

function c33579966.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttackTarget()
	if not c then return false end
	return  c:IsLevelAbove(8) and c:GetControler()==tp
	end
	
function c33579966.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and
	Duel.IsExistingMatchingCard(c33579966.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c33579966.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.GetAttackTarget()
	--battle dam 0
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	c:SetStatus(STATUS_BATTLE_DESTROYED,true)
	Duel.SendtoGrave(c,REASON_BATTLE+REASON_DESTROY)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c33579966.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
	Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
end
end

