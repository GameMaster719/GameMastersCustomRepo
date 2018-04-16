--servant of cataboliusm DOR
--scripted by GameMaster(GM)
function c33599948.initial_effect(c)
	--ADD 1 RoseStarCounter
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c33599948.con)
	e4:SetTarget(c33599948.tg4)
	e4:SetOperation(c33599948.op4)
	c:RegisterEffect(e4)
end


function c33599948.con(e,tp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():IsDefensePos()
end


function c33599948.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x13A,1)
end


function c33599948.tg4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33599948.filter(chkc) end
	if chk==0 then return true end
end

function c33599948.op4(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c33599948.filter,tp,LOCATION_ONFIELD,0,nil)
	local tc=sg:GetFirst()
	while tc do
	local count=tc:GetCounter(0x13A)
	if count==12 then return end
	tc:AddCounter(0x13A,1)
	tc=sg:GetNext()
end
end


