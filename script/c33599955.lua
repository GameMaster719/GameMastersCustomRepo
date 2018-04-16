--Thunder Nyan Nyan (DOR)
--Scripted by GameMaster(GM) 
function c33599955.initial_effect(c)
--Thunder monsters can attack twice
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetRange(LOCATION_MZONE)
e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
e1:SetCode(EFFECT_EXTRA_ATTACK)
e1:SetCondition(c33599955.con)
e1:SetValue(1)
e1:SetTarget(c33599955.tg)
c:RegisterEffect(e1)
end

function c33599955.tg(e,c)
return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_THUNDER)
end

function c33599955.con(e)	
return e:GetHandler():IsDefensePos()
end