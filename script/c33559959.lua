--Toon Medusa
--scripted by GameMaster(GM)
function c33559959.initial_effect(c)
	c:EnableReviveLimit()
	--special summon rule
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetCode(EFFECT_SPSUMMON_PROC)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e0:SetRange(LOCATION_HAND)
	e0:SetCondition(c33559959.spcon)
	c:RegisterEffect(e0)
	--pos change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_POSITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c33559959.target)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(POS_FACEUP_DEFENSE)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c33559959.deftg)
	e2:SetValue(c33559959.defval)
	c:RegisterEffect(e2)
end
	
function c33559959.cfilter(c)
	return c:IsFaceup() and c:IsCode(15259703)
end

function c33559959.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c33559959.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end

function c33559959.target(e,c)
	return c:IsPosition(POS_FACEUP_ATTACK) and not c:IsType(TYPE_TOON)
		and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
		and bit.band(c:GetSummonLocation(),LOCATION_DECK+LOCATION_EXTRA)~=0
end
function c33559959.deftg(e,c)
	return c:IsFaceup() and not c:IsType(TYPE_TOON)
		and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
		and bit.band(c:GetSummonLocation(),LOCATION_DECK+LOCATION_EXTRA)~=0
end
function c33559959.defval(e,c)
	return -c:GetBaseDefense()
end
