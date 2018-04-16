--Viser Des (Manga)
--scripted by GameMaster
function c33589960.initial_effect(c)
--Clamp to monster when summoned
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33589960,0))
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e1:SetCode(EVENT_SUMMON_SUCCESS)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetTarget(c33589960.target)
e1:SetCountLimit(1)
e1:SetOperation(c33589960.operation)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EVENT_SPSUMMON_SUCCESS)
c:RegisterEffect(e2)
--cannot be destroyed
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_INDESTRUCTABLE)
e3:SetCondition(c33589960.con333)
e3:SetValue(1)
c:RegisterEffect(e3)
--no damage
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_SINGLE)
e4:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
e4:SetCondition(c33589960.con333)
e4:SetValue(1)
c:RegisterEffect(e4)
--Rest for sure?
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
e5:SetCode(EVENT_LEAVE_FIELD)
e5:SetOperation(c33589960.restop5)
c:RegisterEffect(e5)
--if viser des leaves field reset card target
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
e6:SetRange(LOCATION_MZONE)
e6:SetCode(EVENT_LEAVE_FIELD_P)
e6:SetCondition(c33589960.descon2)
e6:SetOperation(c33589960.desop2)
c:RegisterEffect(e6)
--destroy monster after 3 turns
local e7=Effect.CreateEffect(c)
e7:SetDescription(aux.Stringid(33589960,0))
e7:SetCategory(CATEGORY_DESTROY)
e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e7:SetRange(LOCATION_MZONE)
e7:SetCode(EVENT_PHASE+PHASE_END)
e7:SetCountLimit(1)
e7:SetCondition(c33589960.con7)
e7:SetOperation(c33589960.op7)
c:RegisterEffect(e7)
--ATK down by 500 every battle phase of opponents
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e8:SetCode(EVENT_PHASE+PHASE_BATTLE)
e8:SetRange(LOCATION_MZONE)
e8:SetCountLimit(1)
e8:SetCondition(c33589960.atkcon123)
e8:SetOperation(c33589960.atkop123)
c:RegisterEffect(e8)
end

function c33589960.op7(e,tp,eg,ep,ev,re,r,rp)
local tc=e:GetHandler():GetFirstCardTarget()
if not tc then return end
if tc==nil then return end
local ct=e:GetLabel()
ct=ct+1
e:SetLabel(ct)
e:GetHandler():SetTurnCounter(ct)
if ct==3 and Duel.Destroy(tc,REASON_EFFECT) then
e:Reset()
end
end

function c33589960.con7(e,tp,eg,ep,ev,re,r,rp)
return e:GetHandler():GetFirstCardTarget()~=nil and Duel.GetTurnPlayer()~=tp
end

function c33589960.descon2(e,tp,eg,ep,ev,re,r,rp)
local tc=e:GetHandler():GetFirstCardTarget()
return tc and eg:IsContains(tc)
end
function c33589960.desop2(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():CancelCardTarget(e:GetHandler():GetFirstCardTarget())
end

function c33589960.restop5(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==33589960 and c:IsPreviousLocation(LOCATION_ONFIELD) then 
e:GetHandler():CancelCardTarget(e:GetHandler():GetFirstCardTarget())
end
end


function c33589960.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
if chk==0 then return true end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,0,0)
end

function c33589960.atkcon123(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()~=tp
end

function c33589960.atkop123(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local tc=e:GetHandler():GetFirstCardTarget()
if tc==nil then return end
if c:GetFlagEffect(33589960)==0 then
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetValue(-500)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
tc:RegisterFlagEffect(33589960,RESET_EVENT+0x1fe0000,0,0)
e:SetLabelObject(e1)
e:SetLabel(2)
else
local pe=e:GetLabelObject()
local ct=e:GetLabel()
e:SetLabel(ct+1)
pe:SetValue(ct*-500)
end
end

function c33589960.operation(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local tc=Duel.GetFirstTarget()
if c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
c:SetCardTarget(tc)
if not tc or tc:IsControler(tp) or not tc:IsRelateToEffect(e) then return end

local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_UNRELEASABLE_SUM)
e2:SetValue(1)
e2:SetReset(RESET_EVENT+0x1fe0000)
e2:SetCondition(c33589960.rcon987)
tc:RegisterEffect(e2)
local e3=e2:Clone()
e3:SetCode(EFFECT_UNRELEASABLE_NONSUM)
e3:SetCondition(c33589960.rcon987)
tc:RegisterEffect(e3)

end
end


function c33589960.rcon987(e)
return e:GetOwner():IsHasCardTarget(e:GetHandler())
end

function c33589960.con333(e)
return e:GetHandler():GetFirstCardTarget()~=nil and not e:GetHandler():IsStatus(STATUS_DISABLED)
end



