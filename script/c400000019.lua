--Number 45: Neo Googly-Eyes Drum Dragon
function c400000019.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,3,c400000019.ovfilter,nil)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c400000019.atkval)
	c:RegisterEffect(e1)
	--3 attacks
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c400000019.discost)
	e2:SetOperation(c400000019.operation)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c400000019.spcon)
	e3:SetTarget(c400000019.sptg)
	e3:SetOperation(c400000019.spop)
	c:RegisterEffect(e3)
end
function c400000019.ovfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:IsType(TYPE_XYZ) and c:GetRank()==8
end

function c400000019.atkval(e,c)
	return c:GetOverlayCount()*500
end

function c400000019.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c400000019.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetReset(RESET_EVENT+0x1ff0000+EVENT_PHASE+PHASE_END)
	e1:SetValue(2)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetCondition(c400000019.dircon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetCondition(c400000019.atkcon)
	c:RegisterEffect(e3)
end
function c400000019.dircon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end
function c400000019.atkcon(e)
	return e:GetHandler():IsDirectAttacked()
end

function c400000019.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetOverlayCount()>0
end
function c400000019.rfilter(c,e,tp)
	return c:IsCode(77799846) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c400000019.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c400000019.rfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c400000019.mfilter(c)
	return c:IsSetCard(0x85) and c:IsType(TYPE_MONSTER)
end
function c400000019.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=Duel.SelectMatchingCard(tp,c400000019.rfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp):GetFirst()
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local g=Duel.GetMatchingGroup(c400000019.mfilter,tp,LOCATION_GRAVE,0,nil)
		if g:GetCount()>1 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local mg=g:Select(tp,2,2,nil)
			Duel.Overlay(c,mg)
		end
	end
end


