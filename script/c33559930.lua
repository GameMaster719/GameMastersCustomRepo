--Mountain Warrior (DOR)
--scripted by GameMaster (GM)
function c33559930.initial_effect(c)	
	--flip
	local e1=Effect.CreateEffect(c)
	 e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetCondition(c33559930.condition)
	e1:SetOperation(c33559930.operation)
	c:RegisterEffect(e1)
end

function c33559930.atktg(e,c)
return Duel.GetMatchingGroup(c33559930.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end

function c33559930.filter2(c)
    return c:IsType(TYPE_MONSTER) and c:IsFaceup()
  end

function c33559930.filter(c)
	return c:IsFaceup() and c:IsCode(50913601)
end
function c33559930.condition(e,tp,eg,ep,ev,re,r,rp)
return Duel.IsExistingMatchingCard(c33559930.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) 
end

function c33559930.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33559930.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetTarget(c33559930.atktg)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		tc:RegisterEffect(e1) 
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2) 
		tc=g:GetNext()
	end
end
