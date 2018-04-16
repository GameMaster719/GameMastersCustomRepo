--Machinedramons Digital city
function c33599928.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(c33599928.val1)
	c:RegisterEffect(e2)
	--Def
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(c33599928.val2)
	c:RegisterEffect(e3)
end
function c33599928.val1(e,c)
	local r=c:GetRace()
	if bit.band(r,RACE_MACHINE)>0 then return c:GetAttack()*3/10
	else return 0 end
end

function c33599928.val2(e,c)
	local r=c:GetRace()
	if bit.band(r,RACE_MACHINE)>0 then return c:GetDefense()*3/10
	else return 0 end
end
