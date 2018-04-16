--Fiends Mirror DOR
--scripted by GameMaster(GM)
function c33599947.initial_effect(c)
	--Remove 1 RoseStarCounter
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c33599947.con)
	e4:SetTarget(c33599947.tg4)
	e4:SetOperation(c33599947.op4)
	c:RegisterEffect(e4)
end


function c33599947.con(e,tp)
	return Duel.GetTurnPlayer()~=tp and e:GetHandler():IsDefensePos()
end


function c33599947.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x13A,1)
end


function c33599947.tg4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33599947.filter(chkc) end
	if chk==0 then return true end
end

function c33599947.op4(e,tp,eg,ep,ev,re,r,rp)
	local sg1=Duel.GetMatchingGroup(c33599947.filter,tp,0,LOCATION_ONFIELD,nil)
	local tc1=sg1:GetFirst()
	local count1=tc1:GetCounter(0x13A)
	while tc1 do
		tc1:RemoveCounter(1-tp,0x13A,1,REASON_EFFECT)
		tc1=sg1:GetNext()
end
end

