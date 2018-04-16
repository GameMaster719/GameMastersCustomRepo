--Defend Slime
--by MLD (revived by GAMEMASTER)
function c33599995.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetDescription(aux.Stringid(33599995,0))
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetHintTiming(0,TIMING_BATTLE_START)
e1:SetTarget(c33599995.atktg1)
e1:SetOperation(c33599995.atkop)
c:RegisterEffect(e1)
--Activate Damage Protection
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33599995,1))
e2:SetType(EFFECT_TYPE_ACTIVATE)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
e2:SetCode(EVENT_CHAINING)
e2:SetCondition(c33599995.dmgcon)
e2:SetCost(c33599995.dmgcost)
e2:SetOperation(c33599995.dmgop)
c:RegisterEffect(e2)
--Activate Battle Damage Protection
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_ACTIVATE)
e3:SetDescription(aux.Stringid(33599995,2))
e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e3:SetCode(EVENT_BATTLE_CONFIRM)
e3:SetCondition(c33599995.battledmgcon)
e3:SetCost(c33599995.battledmgcost)
e3:SetOperation(c33599995.battledmgop)
c:RegisterEffect(e3)
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(33599995,2))
e4:SetType(EFFECT_TYPE_ACTIVATE)
e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
e4:SetCode(EVENT_ATTACK_ANNOUNCE)
e4:SetRange(LOCATION_SZONE)
e4:SetCondition(c33599995.battledmgcon2)
e4:SetCost(c33599995.battledmgcost)
e4:SetOperation(c33599995.battledmgop)
c:RegisterEffect(e4)
--Slime's Defense
local e5=Effect.CreateEffect(c)
e5:SetDescription(aux.Stringid(33599995,0))
e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e5:SetCode(EVENT_BE_BATTLE_TARGET)
e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
e5:SetRange(LOCATION_SZONE)
e5:SetCondition(c33599995.atkcon)
e5:SetTarget(c33599995.atktg2)
e5:SetOperation(c33599995.atkop)
c:RegisterEffect(e5)
--Slime's Damage Protection
local e6=Effect.CreateEffect(c)
e6:SetDescription(aux.Stringid(33599995,1))
e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
e6:SetCode(EVENT_CHAINING)
e6:SetRange(LOCATION_SZONE)
e6:SetCondition(c33599995.dmgcon)
e6:SetCost(c33599995.dmgcost)
e6:SetOperation(c33599995.dmgop)
c:RegisterEffect(e6)
--Slime's Battle Damage Protection
local e7=Effect.CreateEffect(c)
e7:SetDescription(aux.Stringid(33599995,2))
e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
e7:SetCode(EVENT_BATTLE_CONFIRM)
e7:SetRange(LOCATION_SZONE)
e7:SetCondition(c33599995.battledmgcon)
e7:SetCost(c33599995.battledmgcost)
e7:SetOperation(c33599995.battledmgop)
c:RegisterEffect(e7)
local e8=Effect.CreateEffect(c)
e8:SetDescription(aux.Stringid(33599995,2))
e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
e8:SetCode(EVENT_ATTACK_ANNOUNCE)
e8:SetRange(LOCATION_SZONE)
e8:SetCondition(c33599995.battledmgcon2)
e8:SetCost(c33599995.battledmgcost)
e8:SetOperation(c33599995.battledmgop)
c:RegisterEffect(e8)
--[[--destroy replace
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e9:SetCode(EFFECT_DESTROY_REPLACE)
e9:SetRange(LOCATION_SZONE)
e9:SetTarget(c33599995.reptg)
e9:SetValue(c33599995.repval)
e9:SetOperation(c33599995.repop)
c:RegisterEffect(e9)
local g=Group.CreateGroup()
g:KeepAlive()
e9:SetLabelObject(g)]]--
end
-------------



function c33599995.repfilter(c,tp,e)
return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_MZONE)
and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c33599995.desfilter(c,tp)
return c:IsCode(31709826) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c33599995.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
local ct=eg:FilterCount(c33599995.repfilter,nil,tp,e)
if chk==0 then return ct>0 and Duel.IsExistingMatchingCard(c33599995.desfilter,tp,LOCATION_MZONE,0,ct,nil,tp) end
if ct>0  and Duel.SelectYesNo(tp,aux.Stringid(33599995,4)) then 
local g=eg:Filter(c33599995.repfilter,nil,tp,e)
Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33599995,3))
local tg=Duel.SelectMatchingCard(tp,c33599995.desfilter,tp,LOCATION_MZONE,0,g:GetCount(),g:GetCount(),nil,tp)
Duel.SetTargetCard(tg)
local tc=tg:GetFirst()
while tc do
tc:RegisterFlagEffect(33599995,RESET_EVENT+0x1fc0000+RESET_CHAIN,0,1)
tc:SetStatus(STATUS_DESTROY_CONFIRMED,true)
tc=tg:GetNext()
end
e:GetLabelObject():Clear()
e:GetLabelObject():Merge(g)

return true
else
return false end
end


function c33599995.repval(e,c)
local g=e:GetLabelObject()
return g:IsContains(c)
end
function c33599995.repop(e,tp,eg,ep,ev,re,r,rp)
local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
local tc=tg:GetFirst()
while tc do
tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
tc=tg:GetNext()
end
Duel.Destroy(tg,REASON_EFFECT+REASON_REPLACE)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetTargetRange(1,0)
e1:SetValue(1)
e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
Duel.RegisterEffect(e1,tp)
end




--------------
function c33599995.atkcon(e,tp,eg,ep,ev,re,r,rp)
return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()~=nil
end
function c33599995.filter(c)
return c:IsFaceup() and c:IsCode(31709826)
end
function c33599995.atktg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33599995.filter(chkc) end
if chk==0 then return true end
e:SetProperty(0)
if Duel.CheckEvent(EVENT_BE_BATTLE_TARGET) and tp~=Duel.GetTurnPlayer() then
local at=Duel.GetAttackTarget()
if at and Duel.IsExistingTarget(c33599995.filter,tp,LOCATION_MZONE,0,1,at) then
e:SetProperty(EFFECT_FLAG_CARD_TARGET)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,c33599995.filter,tp,LOCATION_MZONE,0,1,1,at)
end
end
end
function c33599995.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33599995.filter(chkc) end
local at=Duel.GetAttackTarget()
if chk==0 then return Duel.IsExistingTarget(c33599995.filter,tp,LOCATION_MZONE,0,1,at) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,c33599995.filter,tp,LOCATION_MZONE,0,1,1,at)
end
function c33599995.atkop(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local tc=Duel.GetFirstTarget()
if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
Duel.ChangeAttackTarget(tc)
end
end
function c33599995.dmgcon(e,tp,eg,ep,ev,re,r,rp)
if re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
if ex and (cp==tp or cp==PLAYER_ALL) then return true end
return ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>0
end
function c33599995.dmgcost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckReleaseGroup(tp,c33599995.filter,1,nil) end
end
function c33599995.dmgop(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.SelectReleaseGroup(tp,c33599995.filter,1,1,nil)
Duel.Destroy(g,REASON_COST)
Duel.NegateActivation(ev)
end

function c33599995.battledmgcon(e,tp,eg,ep,ev,re,r,rp,chk)
local a=Duel.GetAttacker()
local d=Duel.GetAttackTarget()
if not d then return false end
return (a:GetControler()==tp and a:GetAttack()<d:GetAttack() and d:IsAttackPos() or a:GetControler()==tp and a:GetAttack()<d:GetDefense() 
and d:IsDefensePos() or d:GetControler()==tp and d:GetAttack()<a:GetAttack())
end

function c33599995.battledmgcon2(e,tp,eg,ep,ev,re,r,rp,chk)
return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c33599995.battledmgcost(e,tp,eg,ep,ev,re,r,rp,chk)
if tp==Duel.GetTurnPlayer() and chk==0 then return Duel.CheckReleaseGroup(tp,c33599995.filter,1,Duel.GetAttacker()) and Duel.GetFlagEffect(tp,33599995)==0 end
if tp~=Duel.GetTurnPlayer() and chk==0 then return Duel.CheckReleaseGroup(tp,c33599995.filter,1,Duel.GetAttackTarget()) and Duel.GetFlagEffect(tp,33599995)==0 end
Duel.RegisterFlagEffect(tp,33599995,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c33599995.battledmgop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if tp==Duel.GetTurnPlayer() then
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetTargetRange(1,0)
e1:SetValue(1)
e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
Duel.RegisterEffect(e1,tp)
--destroy replace
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e9:SetCode(EFFECT_DESTROY_REPLACE)
e9:SetRange(LOCATION_SZONE)
e9:SetTarget(c33599995.reptg)
e9:SetValue(c33599995.repval)
e9:SetOperation(c33599995.repop)
c:RegisterEffect(e9)
local g=Group.CreateGroup()
g:KeepAlive()
e9:SetLabelObject(g)
end
if tp~=Duel.GetTurnPlayer() then
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetTargetRange(1,0)
e1:SetValue(1)
e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
Duel.RegisterEffect(e1,tp)
--destroy replace
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e9:SetCode(EFFECT_DESTROY_REPLACE)
e9:SetRange(LOCATION_SZONE)
e9:SetTarget(c33599995.reptg)
e9:SetValue(c33599995.repval)
e9:SetOperation(c33599995.repop)
c:RegisterEffect(e9)
local g=Group.CreateGroup()
g:KeepAlive()
e9:SetLabelObject(g)
end
end

