--Elegant egotist
function c335599145.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c335599145.condition)
	e1:SetTarget(c335599145.target)
	e1:SetOperation(c335599145.activate)
	e1:SetCost(c335599145.cost)
	c:RegisterEffect(e1)
end

function c335599145.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c335599145.cfilter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c335599145.cfilter,1,1,nil)
if	Duel.Release(g,REASON_COST) then 
	local tc=g:GetFirst()
	g:RemoveCard(e:GetHandler())
	if g:GetCount()==0 then return end
    Duel.SendtoDeck(g,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
    g:KeepAlive()
    end
end
function c335599145.cfilter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function c335599145.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c335599145.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c335599145.filter(c,e,tp)
	return c:IsCode(76812113,12206212) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c335599145.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222204,0,0x4011,2000,0,3,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c335599145.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	local token1=Duel.CreateToken(tp,80316585)
			Duel.SpecialSummon(token1,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
            e1:SetType(EFFECT_TYPE_SINGLE)
            e1:SetCode(EFFECT_SET_BASE_ATTACK)
            e1:SetValue(1800)
            e1:SetReset(RESET_EVENT+0x1fe0000)
            token1:RegisterEffect(e1)
            local e2=e1:Clone()
            e2:SetCode(EFFECT_SET_BASE_DEFENSE)
            e2:SetValue(1400)
            token1:RegisterEffect(e2)
	local token2=Duel.CreateToken(tp,27927359)
			Duel.SpecialSummon(token2,0,tp,tp,false,false,POS_FACEUP)
			local e3=Effect.CreateEffect(e:GetHandler())
            e3:SetType(EFFECT_TYPE_SINGLE)
            e3:SetCode(EFFECT_SET_BASE_ATTACK)
            e3:SetValue(1800)
            e3:SetReset(RESET_EVENT+0x1fe0000)
            token2:RegisterEffect(e3)
            local e4=e3:Clone()
            e4:SetCode(EFFECT_SET_BASE_DEFENSE)
            e4:SetValue(1400)
            token2:RegisterEffect(e4)
	local token3=Duel.CreateToken(tp,54415063)
			Duel.SpecialSummon(token3,0,tp,tp,false,false,POS_FACEUP)
			local e5=Effect.CreateEffect(e:GetHandler())
            e5:SetType(EFFECT_TYPE_SINGLE)
            e5:SetCode(EFFECT_SET_BASE_ATTACK)
            e5:SetValue(1800)
            e5:SetReset(RESET_EVENT+0x1fe0000)
            token3:RegisterEffect(e5)
            local e6=e5:Clone()
            e6:SetCode(EFFECT_SET_BASE_DEFENSE)
            e6:SetValue(1400)
            token3:RegisterEffect(e6)
			Duel.SpecialSummonComplete()
			end
			