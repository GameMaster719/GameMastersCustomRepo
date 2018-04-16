--Gravity Bind(DOR)
--scripted by GameMaster(GM)
function c33599959.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_ATTACK_ANNOUNCE)
e1:SetCondition(c33599959.condition)
e1:SetTarget(c33599959.target)
e1:SetOperation(c33599959.activate)
c:RegisterEffect(e1)
end

function c33599959.condition(e,tp,eg,ep,ev,re,r,rp)
return tp~=Duel.GetTurnPlayer()
end

function c33599959.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
local tg=Duel.GetAttacker()
if chkc then return chkc==tg end
if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
Duel.SetTargetCard(tg)
end

function c33599959.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetAttacker()
if tc:IsRelateToEffect(e) and Duel.NegateAttack() then
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_ATTACK)
e1:SetProperty(EFFECT_CANNOT_DISABLE)
if tc:GetAttack()>1000 then
	e1:SetValue(tc:GetAttack()-1000)
elseif tc:GetAttack()<=1000 then
	e1:SetValue(0)
end
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_SET_DEFENSE)
e2:SetProperty(EFFECT_CANNOT_DISABLE)
if tc:GetDefense()>1000 then
	e2:SetValue(tc:GetDefense()-1000)
elseif tc:GetDefense()<=1000 then
	e2:SetValue(0)
end
e2:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e2)
local e3=Effect.CreateEffect(e:GetHandler())
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_CANNOT_ATTACK)
e3:SetCondition(c33599959.con)
e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
tc:RegisterEffect(e3)
local e4=Effect.CreateEffect(e:GetHandler())
e4:SetType(EFFECT_TYPE_SINGLE)
e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
e4:SetCondition(c33599959.con)
e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
tc:RegisterEffect(e4)
end
end

function c33599959.con(e,c)
local c=e:GetHandler()
return not c:IsHasEffect(33589953)--cursebreaker effect
end
