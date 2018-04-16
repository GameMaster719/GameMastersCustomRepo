--CHANGE OF HEART (DOR)
--scripted by GameMaster (GM)
function c33569906.initial_effect(c)
--Take Control 1 card till end-phase
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33569906,0))
e1:SetCategory(CATEGORY_CONTROL)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33569906.target1)
e1:SetOperation(c33569906.activate1)
c:RegisterEffect(e1)
end

function c33569906.filter(c)
return c:IsType(0xff)  and c:IsAbleToChangeControler() and  c:GetOriginalCode()~=33599901--Labrynth wall DOR
end

function c33569906.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsOnField() and c33569906.filter(chkc) and chkc~=e:GetHandler() end
if chk==0 then return Duel.IsExistingTarget(c33569906.filter,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) 
and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33569906,0))
local g=Duel.SelectTarget(tp,c33569906.filter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end

function c33569906.activate1(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
if tc and tc:IsRelateToEffect(e) then
if tc:IsType(TYPE_SPELL+TYPE_TRAP) then
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PHASE+PHASE_END)
e1:SetCountLimit(1)
e1:SetReset(RESET_PHASE+PHASE_END)
e1:SetLabelObject(tc)
e1:SetOperation(c33569906.retop)
Duel.RegisterEffect(e1,tp)
local pos=tc:GetPosition()	
Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,pos,true)
else  if tc:IsType(TYPE_MONSTER) then  
Duel.GetControl(tc,tp,PHASE_END,1)
end
end
end
end 

function c33569906.retop(e,tp,eg,ep,ev,re,r,rp)
local tc=e:GetLabelObject()
if tc and tc:IsLocation(LOCATION_ONFIELD) and tc:IsControler(tp) then
if tc:IsFacedown() then 
Duel.MoveToField(tc,1-tp,1-tp,LOCATION_SZONE,POS_FACEDOWN,true)
elseif tc:IsFaceup() then  
Duel.MoveToField(tc,1-tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
end
end
end

