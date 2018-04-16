--Mystical Moon (Manga)
--scripted by GameMaster(GM)
function c33579926.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(c33579926.val1)
	c:RegisterEffect(e2)
	--Def
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetValue(c33579926.val2)
	c:RegisterEffect(e3)
end
function c33579926.val1(e,c)
	local r=c:GetRace()
	if bit.band(r,RACE_BEAST)>0 then return c:GetAttack()*3/10
	else return 0 end
end
function c33579926.val2(e,c)
	local r=c:GetRace()
	if bit.band(r,RACE_BEAST)>0 then return c:GetDefense()*3/10
	else return 0 end
end
