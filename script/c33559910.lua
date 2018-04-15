--vaccination needle
--scripted by GameMaster(GM)
function c33559910.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_EQUIP)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetTarget(c33559910.target)
c:RegisterEffect(e1)
--Equip limit
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_EQUIP_LIMIT)
e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e2:SetValue(c33559910.eqlimit)
c:RegisterEffect(e2)
--Cost Change
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetCode(EFFECT_LPCOST_CHANGE)
e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e3:SetRange(LOCATION_SZONE)
e3:SetTargetRange(1,0)
e3:SetValue(c33559910.costchange)
c:RegisterEffect(e3)
--leave
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
e4:SetCode(EVENT_LEAVE_FIELD)
e4:SetOperation(c33559910.desop)
c:RegisterEffect(e4)
--cannot disable
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_CANNOT_DISABLE)
c:RegisterEffect(e5)
end

--**notes**-- 
--since uses a field effect but want to limit to just the equipped monster (thanks to MLD pointing out telek. power cell) use  re:GetHandler()==e:GetHandler():GetEquipTarget() to limit to just equipped monster and use in value.

function c33559910.costchange(e,re,rp,val)
if re and re:GetHandler():IsCode(79575620) and re:GetHandler()==e:GetHandler():GetEquipTarget() then
return 750
else return val end
end

function c33559910.eqlimit(e,c)
return c:GetOriginalCode()==79575620
end

function c33559910.filter(c)
return c:IsFaceup() and c:GetOriginalCode()==79575620
end

function c33559910.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE) and c33559910.filter(chkc) end
if chk==0 then return Duel.IsExistingTarget(c33559910.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
Duel.SelectTarget(tp,c33559910.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_CHAIN_SOLVING)
e1:SetReset(RESET_CHAIN)
e1:SetLabel(Duel.GetCurrentChain())
e1:SetLabelObject(e)
e1:SetOperation(c33559910.operation)
Duel.RegisterEffect(e1,tp)
Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
e:GetHandler():RegisterFlagEffect(33559910,RESET_EVENT+0x00040000,0,1)
end

function c33559910.operation(e,tp,eg,ep,ev,re,r,rp)
if re~=e:GetLabelObject() then return end
local c=e:GetHandler()
local tc=Duel.GetChainInfo(Duel.GetCurrentChain(),CHAININFO_TARGET_CARDS):GetFirst()
if tc and c:IsRelateToEffect(re) and tc:IsRelateToEffect(re) and tc:IsFaceup() then
Duel.Equip(tp,c,tc)
end
end

function c33559910.desop(e,tp,eg,ep,ev,re,r,rp)
local tc=e:GetHandler():GetFirstCardTarget()
if tc and tc:IsLocation(LOCATION_MZONE) then
Duel.Destroy(tc,REASON_EFFECT)
end
end
