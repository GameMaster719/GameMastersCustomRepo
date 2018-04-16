--Droll Bird (DOR)
--scripted by GameMaster (GM)
function c33579928.initial_effect(c)
--fLIP monster of 500 of less FACEup
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_FLIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c33579928.operation)
	c:RegisterEffect(e1)
end

function c33579928.tg(e,c)
return Duel.GetMatchingGroup(c33579928.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
end

function c33579928.filter(c)
    return c:IsType(TYPE_MONSTER) and (c:IsFacedown() and c:GetAttack()<=500)
  end

function c33579928.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33579928.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP)
	end
end

