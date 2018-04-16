--kageinegain DOR
function c33589969.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33589969,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c33589969.sptg)
	e1:SetOperation(c33589969.spop)
	c:RegisterEffect(e1)
	--damage change
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetOperation(c33589969.damop)
	c:RegisterEffect(e2)
end


function c33589969.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(e,0)
end

function c33589969.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33589969.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,86801872,0,0x4011,1200,1200,3,RACE_REPTILE,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,33589969)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP) 
	Duel.SpecialSummonComplete()
end

