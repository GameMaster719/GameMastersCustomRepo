--Hydra of appohis
--scripted by GameMaster(GM)
function c33579961.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33579961.target)
	e1:SetOperation(c33579961.activate)
	e1:SetCondition(c33579961.spcon)
	c:RegisterEffect(e1)
end


function c33579961.spfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsCode(28649820)
end

function c33579961.spcon(e,c)
	if c==nil then return true end
	local tp=e:GetHandlerPlayer()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33579961.spfilter,tp,LOCATION_GRAVE,0,3,nil)
end




function c33579961.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
		Duel.IsPlayerCanSpecialSummonMonster(tp,33579961,0,0x11,3200,0,12,RACE_REPTILE,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c33579961.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
	or not Duel.IsPlayerCanSpecialSummonMonster(tp,33579961,0,0x11,3200,0,12,RACE_REPTILE,ATTRIBUTE_EARTH) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c33579961.spfilter,tp,LOCATION_GRAVE,0,3,3,nil) 
	Duel.Remove(g,POS_FACEUP,REASON_COST)	
	c:AddMonsterAttribute(TYPE_NORMAL)
	Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP)
	c:AddMonsterAttributeComplete()
	Duel.SpecialSummonComplete()
end
