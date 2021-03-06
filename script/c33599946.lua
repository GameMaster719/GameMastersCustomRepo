--Berfomet DOR
--scripted by GameMaster(GM)
function c33599946.initial_effect(c)
	--Remove all RoseStar counters
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_FLIP+CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c33599946.tg4)
	e1:SetOperation(c33599946.op4)
	c:RegisterEffect(e1)
end


function c33599946.tg4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33599946.filter,tp,LOCATION_ONFIELD,0,1,nil) end
end
function c33599946.filter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x13A,1)
end

function c33599946.op4(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c33599946.filter,tp,LOCATION_ONFIELD,0,nil)
	local tc=sg:GetFirst()
	local count=tc:GetCounter(0x13A)
	while tc  do
		tc:AddCounter(0x13A,12-count)
		tc=sg:GetNext()
	end
	if count>0 then
		Duel.RaiseEvent(e:GetHandler(),EVENT_ADD_COUNTER+0x100e,e,REASON_EFFECT,tp,tp,12-count)
	end
end