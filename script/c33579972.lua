--Time Seal (DOR)
--scripted by GameMaster(GM)
function c33579972.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetTarget(c33579972.tg)
e1:SetOperation(c33579972.op)
c:RegisterEffect(e1)
end

function c33579972.filter(c)
return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end

function c33579972.tg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingTarget(c33579972.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end

function c33579972.op(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33579972.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)
if g:GetCount()>0	then
local tg=g:GetMaxGroup(Card.GetAttack)
local tc=tg:GetFirst()
Duel.HintSelection(tg)
while tc do	
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK)
e1:SetReset(RESET_EVENT+0x00040000)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
e2:SetReset(RESET_EVENT+0x00040000)
tc:RegisterEffect(e2)
tc=tg:GetNext()
end
else if g:GetCount()>1 then
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg=tg:Select(tp,1,1,nil)
	Duel.HintSelection(sg)	
local tc=tg:GetFirst()
while tc do	
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK)
e1:SetReset(RESET_EVENT+0x00040000)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
e2:SetReset(RESET_EVENT+0x00040000)
tc:RegisterEffect(e2)
tc=tg:GetNext()
	end
end
end
end


