--Dragon Capture Jar (DOR)
--scripted by GameMaster (GM)
function c33589905.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33589905.target)
	e1:SetOperation(c33589905.activate)
	c:RegisterEffect(e1)
end


function c33589905.filter(c)
	return c:IsRace(RACE_DRAGON)
end



function c33589905.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33589905.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(c33589905.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,sg:GetCount(),0,0)
end
function c33589905.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c33589905.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=sg:GetFirst()
	while tc do
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetCondition(c33589905.con)
		e1:SetReset(RESET_EVENT+0x00040000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e2:SetCondition(c33589905.con)
		e2:SetReset(RESET_EVENT+0x00040000)
		tc:RegisterEffect(e2)
	tc=sg:GetNext()
end
end

function c33589905.con(e,c)
local c=e:GetHandler()
	return not c:IsHasEffect(33589953)
end