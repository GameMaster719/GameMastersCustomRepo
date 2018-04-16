--Dark Elf (DOR)
--scripted by GameMaster(GM)
function c33569933.initial_effect(c)
	--attack cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_COST)
	e1:SetCost(c33569933.atcost)
	e1:SetOperation(c33569933.atop)
	c:RegisterEffect(e1)
end
function c33569933.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,50)
end
function c33569933.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,50)
end
