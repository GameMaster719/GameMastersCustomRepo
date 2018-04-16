--Magic Drain DOR
--scripted by GameMaster(GM))
function c33599945.initial_effect(c)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCondition(c33599945.condition)
	e2:SetTarget(c33599945.target2)
	e2:SetOperation(c33599945.operation)
	c:RegisterEffect(e2)
	end

function c33599945.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end	
	
--opponents card with rosestars
function c33599945.filter1(c)

	return  c:GetCounter(0x13A)~=0
end	
	
	--my card
function c33599945.filter2(c)
	return c:IsFaceup() and c:IsCode(33599941) 
end		
	
function c33599945.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	
end	


function c33599945.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg1=Duel.GetMatchingGroup(c33599945.filter,tp,0,LOCATION_ONFIELD,nil)
	local tc1=sg1:GetFirst()
	local count1=0
	while tc1 do
		count1=tc1:GetCounter(0x13A)
		tc1:RemoveCounter(tp,0,0,0)
		tc1=sg1:GetNext()
	local sg2=Duel.GetMatchingGroup(c33599944.filter2,tp,LOCATION_ONFIELD,0,nil)
	local tc2=sg2:GetFirst()
	count2=tc2:GetCounter(0x13A)
	while tc2 and count2<12 do
		tc2:AddCounter(0x13A,count1)
		tc2=sg2:GetNext()
	end	
	end
end


