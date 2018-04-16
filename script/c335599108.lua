--Dragon Capture jar
--scripted by GameMaster(GM)
function c335599108.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c335599108.target)
	e1:SetOperation(c335599108.activate)
	c:RegisterEffect(e1)
	--attach
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(0,LOCATION_MZONE)	
	e2:SetOperation(c335599108.operation)
	c:RegisterEffect(e2)
	--detach
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHANGE_POS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetOperation(c335599108.flipop)
	c:RegisterEffect(e3)
	--DEf = to dragons attached
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c335599108.defval)
	c:RegisterEffect(e4)
	--attach
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c335599108.condition)
	e5:SetOperation(c335599108.operation)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e7)
end

function c335599108.condition(e,tp,eg,ep,ev,re,r,rp)
	return  Duel.IsExistingMatchingCard(c335599108.filter,tp,0,LOCATION_MZONE,1,nil)
	           
end



function c335599108.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup() and not c:IsCode(50045299)
end
function c335599108.defval(e,c)
	return e:GetHandler():GetOverlayGroup():GetSum(Card.GetBaseDefense)
end
function c335599108.operation(e,tp,eg,ep,ev,re,r,rp)
	local wg=Duel.GetMatchingGroup(c335599108.filter,tp,0,LOCATION_MZONE,nil)
	 local c=wg:GetFirst()
	while c do
	  local og=c:GetOverlayGroup()
    if og:GetCount()>0 then Duel.SendtoGrave(og,REASON_RULE) end
	c=wg:GetNext()
	end
	Duel.Overlay(e:GetHandler(),wg)
end


function c335599108.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local og=c:GetOverlayGroup()
	Duel.SendtoGrave(og,REASON_RULE)
end
function c335599108.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and 
		Duel.IsPlayerCanSpecialSummonMonster(tp,335599108,0,0x11,100,200,2,RACE_ROCK,ATTRIBUTE_EARTH) and Duel.IsExistingMatchingCard(c335599108.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c335599108.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,335599108,0,0x11,100,200,2,RACE_ROCK,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_NORMAL)
	Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
	c:AddMonsterAttributeComplete()
	Duel.SpecialSummonComplete()
end




