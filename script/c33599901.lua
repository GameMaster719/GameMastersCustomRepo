--Labyrinth Wall(DOR)
--scripted by GameMaster(GM) + edo
function c33599901.initial_effect(c)
--Activate spell zone
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetDescription(aux.Stringid(33599901,0))
e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e0:SetCode(EVENT_FREE_CHAIN)
e0:SetOperation(c33599901.op)
c:RegisterEffect(e0)
--monster zone
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetDescription(aux.Stringid(33599901,1))
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33599901.target)
e1:SetOperation(c33599901.activate)
c:RegisterEffect(e1)
--remain on field
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_REMAIN_FIELD)
c:RegisterEffect(e2)
--immune
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_IMMUNE_EFFECT)
e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e3:SetRange(LOCATION_MZONE+LOCATION_SZONE)
e3:SetValue(1)
c:RegisterEffect(e3)
--control
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_SINGLE)
e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e4:SetRange(LOCATION_MZONE)
e4:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
c:RegisterEffect(e4)
--Cannot be battle target
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
e5:SetRange(LOCATION_MZONE)
e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
e5:SetValue(1)
c:RegisterEffect(e5)
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetCode(EFFECT_UNRELEASABLE_SUM)
e6:SetRange(LOCATION_MZONE+LOCATION_SZONE)
e6:SetTargetRange(LOCATION_MZONE+LOCATION_SZONE,LOCATION_MZONE+LOCATION_SZONE)
e6:SetValue(1)
c:RegisterEffect(e6)
local e7=e6:Clone()
e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e7)
--other monster summon type protection
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetRange(LOCATION_MZONE+LOCATION_SZONE)
e8:SetTargetRange(LOCATION_MZONE+LOCATION_SZONE,LOCATION_MZONE+LOCATION_SZONE)
e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e8:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
e8:SetValue(1)
c:RegisterEffect(e8)
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e9:SetRange(LOCATION_MZONE+LOCATION_SZONE)
e9:SetTargetRange(LOCATION_MZONE+LOCATION_SZONE,LOCATION_MZONE+LOCATION_SZONE)
e9:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
e9:SetValue(1)
c:RegisterEffect(e9)
--immune
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_SINGLE)
e10:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e10:SetRange(LOCATION_ONFIELD)
e10:SetValue(1)
c:RegisterEffect(e10)
local e11=e10:Clone()
e11:SetCode(EFFECT_CANNOT_DISABLE)
c:RegisterEffect(e11)
end

-- MY SPELL ZONE
function c33599901.op(e,tp,eg,ep,ev,re,r,rp) 
local c=e:GetHandler()
if 	Duel.SelectYesNo(tp,aux.Stringid(33599901,3)) then 
if c and c:IsLocation(LOCATION_SZONE) and c:GetControler()==tp then
local seq=bit.lshift(1,e:GetHandler():GetSequence()+8)
e:SetLabel(seq) end
local seq=bit.lshift(1,e:GetHandler():GetSequence()+8)--thank you edo 
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetCode(EFFECT_DISABLE_FIELD)
e1:SetCondition(c33599901.con333)
e1:SetOperation(c33599901.disop)
e1:SetLabel(e:GetLabel())
Duel.RegisterEffect(e1,tp) 
local token=Duel.CreateToken(tp,33599901)
Duel.SendtoGrave(token,REASON_EFFECT)
else 
local c=e:GetHandler()
Duel.MoveToField(e:GetHandler(),1-tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
e:GetHandler():SetStatus(STATUS_NO_LEVEL,true)
if c and c:IsLocation(LOCATION_SZONE)  then
local seq=bit.lshift(1,e:GetHandler():GetSequence()+24)
e:SetLabel(seq)
end
local seq=bit.lshift(1,e:GetHandler():GetSequence()+24)--thank you edo local  --MY SPELL ZONE
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetCode(EFFECT_DISABLE_FIELD)
e1:SetOperation(c33599901.disop2)
e1:SetCondition(c33599901.con333)
e1:SetLabel(e:GetLabel())
Duel.RegisterEffect(e1,tp) 
local token=Duel.CreateToken(tp,33599901)
Duel.SendtoGrave(token,REASON_EFFECT)
end
end 

--sPECIAL SUMMON TO MZONE
function c33599901.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)+Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0  end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c33599901.activate(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if not c:IsRelateToEffect(e) then return end
if 	Duel.SelectYesNo(tp,aux.Stringid(33599901,2))  or Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
c:AddMonsterAttribute(TYPE_NORMAL)
Duel.SpecialSummonStep(c,0,tp,tp,true,false,POS_FACEUP_ATTACK)
c:AddMonsterAttributeComplete()
--cannot attack
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK)
e1:SetValue(1)
c:RegisterEffect(e1,true)
--cannot be effect target
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e2:SetRange(LOCATION_ONFIELD)
e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e2:SetReset(RESET_EVENT+0x1fe0000)
e2:SetValue(1)
c:RegisterEffect(e2,true)
local e3=e2:Clone()
e3:SetCode(EFFECT_CANNOT_DISABLE)
c:RegisterEffect(e3,true)
--cannot attack 
local e5=Effect.CreateEffect(e:GetHandler())
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_CANNOT_ATTACK)
e5:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e5,true)
--cannot be tributed
local e6=Effect.CreateEffect(e:GetHandler())
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetCode(EFFECT_UNRELEASABLE_SUM)
e6:SetValue(1)
e6:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e6,true)
local e7=e6:Clone()
e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e7,true)
--other monster summon type protection
local e8=Effect.CreateEffect(e:GetHandler())
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetRange(LOCATION_MZONE+LOCATION_SZONE)
e8:SetTargetRange(LOCATION_MZONE+LOCATION_SZONE,LOCATION_MZONE+LOCATION_SZONE)
e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e8:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
e8:SetValue(1)
c:RegisterEffect(e8,true)
local e9=Effect.CreateEffect(e:GetHandler())
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e9:SetRange(LOCATION_MZONE+LOCATION_SZONE)
e9:SetTargetRange(LOCATION_MZONE+LOCATION_SZONE,LOCATION_MZONE+LOCATION_SZONE)
e9:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
e9:SetValue(1)
c:RegisterEffect(e9,true)
c:SetStatus(STATUS_NO_LEVEL,true)
Duel.SpecialSummonComplete()

local token=Duel.CreateToken(tp,33599901)
Duel.SendtoGrave(token,REASON_EFFECT)
if c and c:IsLocation(LOCATION_MZONE)  then
local seq=bit.lshift(1,e:GetHandler():GetSequence())--OPPONENTS MONSTERS ZONE
e:SetLabel(seq)
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(EFFECT_DISABLE_FIELD)
e2:SetOperation(c33599901.disop2)
e2:SetCondition(c33599901.con222)
e2:SetLabel(e:GetLabel())
Duel.RegisterEffect(e2,tp) 
end
else 
if not c:IsRelateToEffect(e) then return end
if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then return end
c:AddMonsterAttribute(TYPE_NORMAL)
Duel.SpecialSummonStep(c,0,tp,1-tp,true,false,POS_FACEUP_ATTACK)
c:AddMonsterAttributeComplete()
--cannot attack
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK)
e1:SetValue(1)
c:RegisterEffect(e1,true)
c:SetStatus(STATUS_NO_LEVEL,true)
--cannot be effect target
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e2:SetRange(LOCATION_ONFIELD)
e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e2:SetReset(RESET_EVENT+0x1fe0000)
e2:SetValue(1)
c:RegisterEffect(e2,true)
local e3=e2:Clone()
e3:SetCode(EFFECT_CANNOT_DISABLE)
c:RegisterEffect(e3,true)
local e5=Effect.CreateEffect(e:GetHandler())
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_CANNOT_ATTACK)
e5:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e5,true)
local e6=Effect.CreateEffect(e:GetHandler())
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetCode(EFFECT_UNRELEASABLE_SUM)
e6:SetValue(1)
e6:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e6,true)
local e7=e6:Clone()
e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e7,true)
--other monster summon type protection
local e8=Effect.CreateEffect(e:GetHandler())
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetRange(LOCATION_MZONE+LOCATION_SZONE)
e8:SetTargetRange(LOCATION_MZONE+LOCATION_SZONE,LOCATION_MZONE+LOCATION_SZONE)
e8:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e8:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
e8:SetValue(1)
c:RegisterEffect(e8)
local e9=Effect.CreateEffect(e:GetHandler())
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e9:SetRange(LOCATION_MZONE+LOCATION_SZONE)
e9:SetTargetRange(LOCATION_MZONE+LOCATION_SZONE,LOCATION_MZONE+LOCATION_SZONE)
e9:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
e9:SetValue(1)
c:RegisterEffect(e9)
c:SetStatus(STATUS_NO_LEVEL,true)
Duel.SpecialSummonComplete()
local token=Duel.CreateToken(tp,33599901)
Duel.SendtoGrave(token,REASON_EFFECT)
local c=e:GetHandler()
if c and c:IsLocation(LOCATION_MZONE)  then
local seq=bit.lshift(1,e:GetHandler():GetSequence()+16)--OPPONENTS MONSTERS ZONE
e:SetLabel(seq)
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(EFFECT_DISABLE_FIELD)
e2:SetOperation(c33599901.disop2)
e2:SetCondition(c33599901.con222)
e2:SetLabel(e:GetLabel())
Duel.RegisterEffect(e2,tp)  

end
end
end

function c33599901.con222(e,c)
local c=e:GetHandler()
if c:IsLocation(LOCATION_MZONE) then return true
else 
return false
end
end

function c33599901.con333(e,c)
local c=e:GetHandler()
if c:IsLocation(LOCATION_SZONE) then return true
else 
return false
end
end

-- **NOTE e:SetLabel(e:GetHandler():GetSequence()+e:GetHandler():GetSequence()) == e:GetHandler():GetSequence()+e:GetHandler():GetSequence() seemed to only block off the zone its in
--if i did +4 it did 2 zones  [0xx00] +5 did 3 zones
-- Duel.RegisterEffect(e2,tp) then use :GetSequence()+16) if you do Duel.RegisterEffect(e2,1-tp) local seq=bit.lshift(1,e:GetHandler():GetSequence()-16) 

--Every 8 it "changes" the zone +8 p szone, +16 opp mzone, +24 oppo szone

function c33599901.disop(e,tp)
return e:GetLabel()
end

function c33599901.disop2(e,tp)
return e:GetLabel()
end
