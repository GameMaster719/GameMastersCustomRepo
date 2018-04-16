--DOR field
--Scripted by GameMaster(GM) + MLD 
function c33599949.initial_effect(c)
--Activate
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e0)
--monsters can only attack monsters in the same column --credit to MLD 
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetRange(LOCATION_FZONE)
e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
e1:SetTarget(c33599949.tg)
e1:SetValue(c33599949.val)
e1:SetLabel(0)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetLabel(1)
c:RegisterEffect(e2)
local e3=e1:Clone()
e3:SetLabel(2)
c:RegisterEffect(e3)
local e4=e1:Clone()
e4:SetLabel(3)
c:RegisterEffect(e4)
local e5=e1:Clone()
e5:SetLabel(4)
c:RegisterEffect(e5)
--[[ --cannot be target    --credit to larry  -- works on edo pro will need think of other way on percy 
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetRange(LOCATION_FZONE)
e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
e1:SetTarget(c33599949.tg)
e1:SetValue(c33599949.target)
c:RegisterEffect(e1) ]] --
--cannot be destroyed
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
e6:SetRange(LOCATION_PZONE)
e6:SetValue(1)
c:RegisterEffect(e6)
--immune
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_SINGLE)
e7:SetCode(EFFECT_IMMUNE_EFFECT)
e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e7:SetRange(LOCATION_FZONE)
e7:SetValue(1)
c:RegisterEffect(e7)
--move to unoccupied zone
local e8=Effect.CreateEffect(c)
e8:SetDescription(aux.Stringid(33599949,0))
e8:SetProperty(EFFECT_FLAG_BOTH_SIDE)
e8:SetType(EFFECT_TYPE_IGNITION)
e8:SetRange(LOCATION_FZONE)
e8:SetTarget(c33599949.seqtg)
e8:SetOperation(c33599949.seqop)
e8:SetTargetRange(1,1)
c:RegisterEffect(e8)
end



function c33599949.filter(c)
return c:IsType(TYPE_MONSTER) and c:GetFlagEffect(33599949)==0 
end



function c33599949.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return Duel.IsExistingTarget(c33599949.filter,tp,LOCATION_MZONE,0,1,nil,e:GetHandler()) 
	and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
local g=Duel.SelectTarget(tp,c33599949.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
end

function c33599949.seqop(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
if tc and tc:IsRelateToEffect(e) then
local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
local nseq=0
if s==1 then nseq=0
elseif s==2 then nseq=1
elseif s==4 then nseq=2
elseif s==8 then nseq=3
else nseq=4 end
local pos=tc:GetPosition()
if pos==POS_FACEUP_DEFENSE then pos=POS_FACEUP_ATTACK end
if pos==POS_FACEUP_ATTACK then pos=POS_FACEUP_ATTACK end
if pos==POS_FACEDOWN_DEFENSE then pos=POS_FACEDOWN_ATTACK end
if pos==POS_FACEDOWN_ATTACK then pos=POS_FACEDOWN_ATTACK end
 Duel.MoveSequence(tc,nseq)  
 Duel.ChangePosition(tc,pos)
tc:RegisterFlagEffect(33599949,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
 end
end


function c33599949.tg(e,c)
    return c:GetSequence()==e:GetLabel()
end

function c33599949.val(e,c)
    return  c:GetSequence()~=4-e:GetLabel()
end

--NOTES MLD had it ^^ == which was letting me attack any other monster but the same column ...  i added/ tried ~= worked for : monsters can only attack monsters in the same column.


--[[function c33599949.tg(e,c)
e:SetLabelObject(c)
return true
end
function c33599949.target(e,c)
return not e:GetLabelObject():GetColumnGroup():IsContains(c)
end ]] --

