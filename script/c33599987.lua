--NEO illlusionist faceless mage (DOR)
--scripted by GameMaster (GM)
function c33599987.initial_effect(c)
	--battle
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33599987,0))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c33599987.condition)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c33599987.disop)
	c:RegisterEffect(e2)
	
end	
	
function c33599987.ccost(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x113B,1,REASON_COST)
end

function c33599987.condition(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    local pos=c:GetBattlePosition()
    return c==Duel.GetAttackTarget() and (pos==POS_FACEDOWN_DEFENSE or pos==POS_FACEDOWN_ATTACK)

end

function c33599987.condition2(e)
	return e:GetHandler():GetCounter(0x113B)>0
end


function c33599987.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc==Duel.GetAttacker() then
		bc:AddCounter(0x113B,3)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetCondition(c33599987.condition2)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		bc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		bc:RegisterEffect(e2)
		--cost
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c33599987.con4)
	e4:SetOperation(c33599987.ccost)
	bc:RegisterEffect(e4)
	end
end

function c33599987.con4(e,c,tp)
local c=e:GetHandler()
local tp=c:GetControler()
return Duel.GetTurnPlayer()~=tp
end