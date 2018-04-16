--Sinister serpent
--scripted by GameMaster(GM)
function c33599943.initial_effect(c)
	--Remove all RoseStar counters
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511005635,0))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_DESTROYED)
	e4:SetCondition(c33599943.con4)
	e4:SetTarget(c33599943.tg4)
	e4:SetOperation(c33599943.op4)
	c:RegisterEffect(e4)
end

function c33599943.con4(e,tp,eg,ep,ev,re,r,rp)
	return  e:GetHandler():IsReason(REASON_BATTLE)
end
function c33599943.tg4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33599943.filter,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c33599943.filter(c)
	return c:GetCounter(0x13A)~=0
end

function c33599943.op4(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c33599943.filter,tp,0,LOCATION_ONFIELD,nil)
	local tc=sg:GetFirst()
	local count=0
	while tc do
		count=count+tc:GetCounter(0x13A)
		tc:RemoveCounter(tp,0,0,0)
		tc=sg:GetNext()
	end
	if count>0 then
		Duel.RaiseEvent(e:GetHandler(),EVENT_REMOVE_COUNTER+0x100e,e,REASON_EFFECT,tp,tp,count)
	end
end