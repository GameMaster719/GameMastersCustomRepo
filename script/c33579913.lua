--ATTRIBUTE GRAVITY ANIME
--SCRIPTED BY GAMEMASTER
function c33579913.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e1)
--change attack target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetTarget(c33579913.target)
	e2:SetOperation(c33579913.operation)
	e2:SetCondition(c33579913.condition)
	c:RegisterEffect(e2)
	--must attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_MUST_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c33579913.condition)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_EP)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c33579913.condition)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(0,1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_M2)
	c:RegisterEffect(e5)
end

function c33579913.filter(c,att)
	return c:IsFaceup() and c:IsAttribute(att)
end

function c33579913.condition(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()~=tp and (Duel.IsExistingMatchingCard(c33579913.filter,tp,0,LOCATION_MZONE,2,nil,ATTRIBUTE_EARTH) or
Duel.IsExistingMatchingCard(c33579913.filter,tp,0,LOCATION_MZONE,2,nil,ATTRIBUTE_LIGHT) or
Duel.IsExistingMatchingCard(c33579913.filter,tp,0,LOCATION_MZONE,2,nil,ATTRIBUTE_DARK) or
Duel.IsExistingMatchingCard(c33579913.filter,tp,0,LOCATION_MZONE,2,nil,ATTRIBUTE_WATER) or
Duel.IsExistingMatchingCard(c33579913.filter,tp,0,LOCATION_MZONE,2,nil,ATTRIBUTE_FIRE) or
Duel.IsExistingMatchingCard(c33579913.filter,tp,0,LOCATION_MZONE,2,nil,ATTRIBUTE_WIND) or
Duel.IsExistingMatchingCard(c33579913.filter,tp,0,LOCATION_MZONE,2,nil,ATTRIBUTE_DEVINE))
 end
 
function c33579913.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
    end
function c33579913.operation(e,tp,eg,ep,ev,re,r,rp)
    local ac=Duel.GetAttacker()
    local tc=Duel.SelectMatchingCard(tp,c33579913.filter,tp,0,LOCATION_MZONE,1,1,ac,ac:GetAttribute()):GetFirst()
    if ac and ac:IsAttackable() and not ac:IsImmuneToEffect(e) then
        Duel.CalculateDamage(ac,tc)
    end
end