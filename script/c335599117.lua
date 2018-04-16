--Toon World (Anime)
--Scripted by shahim and GameMaster(GM)
function c335599117.initial_effect(c)
c:SetUniqueOnField(1,0,335599117)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e1)
--treatead as Toon
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetRange(LOCATION_SZONE)
e2:SetTargetRange(LOCATION_MZONE,0)
e2:SetCode(EFFECT_ADD_TYPE)
e2:SetValue(TYPE_TOON)
c:RegisterEffect(e2)
--battle indestructable
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_FIELD)
e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
e4:SetRange(LOCATION_SZONE)
e4:SetTargetRange(LOCATION_MZONE,0)
e4:SetTarget(c335599117.tg4)
e4:SetValue(c335599117.value)
c:RegisterEffect(e4)
--attach monsters to card
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
e5:SetCode(EVENT_PHASE+PHASE_END)
e5:SetRange(LOCATION_SZONE)
e5:SetCountLimit(1)
e5:SetCondition(c335599117.ovcon)
e5:SetOperation(c335599117.ovop)
c:RegisterEffect(e5)
--Special Summon
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_QUICK_O)
e6:SetCode(EVENT_FREE_CHAIN)
e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e6:SetRange(LOCATION_SZONE)
e6:SetCountLimit(1)
e6:SetCondition(c335599117.sscon)
e6:SetOperation(c335599117.ssop)
c:RegisterEffect(e6)
--summon if leaves field
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
e7:SetRange(LOCATION_SZONE)
e7:SetCode(EVENT_LEAVE_FIELD)
e7:SetOperation(c335599117.desop777)
e7:SetCondition(c335599117.con777)
c:RegisterEffect(e7)
-- Cannot Disable effect
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
e8:SetCode(EFFECT_CANNOT_DISABLE)
e8:SetRange(LOCATION_SZONE)
c:RegisterEffect(e8)
--move to unoccupied zone
local e10=Effect.CreateEffect(c)
e10:SetDescription(aux.Stringid(335599117,0))
e10:SetType(EFFECT_TYPE_QUICK_O)
e10:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CANNOT_DISABLE)
e10:SetRange(LOCATION_SZONE)
e10:SetTargetRange(LOCATION_MZONE,0)
e10:SetCode(EVENT_FREE_CHAIN)
e10:SetTarget(c335599117.seqtg)
e10:SetOperation(c335599117.seqop)
e10:SetCondition(c335599117.con10)
c:RegisterEffect(e10)
end

function c335599117.tg4(e,c)
return c:IsType(TYPE_TOON) 
end

function c335599117.value(e,c)
local atk=Duel.GetAttackTarget()
return not (atk:IsStatus(STATUS_DISABLED) or  atk:IsHasEffect(EFFECT_CANNOT_ATTACK) or atk:IsHasEffect(EFFECT_CANNOT_CHANGE_POSITION))
 end
 
function c335599117.con10(e,c,tp)
local atk=Duel.GetAttackTarget()	
if  Duel.GetAttacker()==nil or Duel.GetAttackTarget()==nil then return end 
local c=e:GetHandler()
local tp=c:GetControler()
return  Duel.GetTurnPlayer()~=tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and  atk:IsFaceup() and atk:GetControler()==tp 
and not e:GetHandler():IsStatus(STATUS_CHAINING) and not atk:IsHasEffect(EFFECT_CANNOT_ATTACK) and not atk:IsHasEffect(EFFECT_CANNOT_CHANGE_POSITION) 
end

function c335599117.filter440(c)
return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsType(TYPE_TOON))
end

function c335599117.seqtg(e,tp,eg,ep,ev,re,r,rp,chk)
if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup()  end
if chk==0 then return Duel.IsExistingTarget(c335599117.filter440,tp,LOCATION_MZONE,0,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
local td=Duel.GetAttackTarget()
Duel.SetTargetCard(td)
end


function c335599117.seqop(e,tp,eg,ep,ev,re,r,rp)
local td=Duel.GetAttackTarget()
Duel.SetTargetCard(td)
local td=Duel.GetAttackTarget()
if  Duel.GetAttacker()==nil or Duel.GetAttackTarget()==nil then return end
if td and Duel.NegateAttack() and td:IsFaceup() and td:IsRelateToEffect(e) then	
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
	if s==1 then nseq=0
	elseif s==2 then nseq=1
	elseif s==4 then nseq=2
	elseif s==8 then nseq=3
	else nseq=4 end
	Duel.MoveSequence(td,nseq)
   end
end

--if card leaves field summon the cards that were attached
function c335599117.con777(e,c)
return e:GetHandler():GetOverlayCount()>0
end

function c335599117.filter777(c)
return c:IsFaceup() and c:IsType(TYPE_MONSTER+TYPE_SPELL) and c:IsPreviousLocation(LOCATION_OVERLAY) 
end



function c335599117.desop777(e,tp,eg,ep,ev,re,r,rp)
local oppmonNum = Duel.GetMatchingGroupCount(c335599117.filter777,tp,LOCATION_GRAVE,0,nil)
local s1=math.min(oppmonNum,oppmonNum)
local g=Duel.SelectTarget(tp,c335599117.filter777,tp,LOCATION_GRAVE,0,s1,s1,nil)
 local tg=Group.CreateGroup()-- creates group to refrence...
local tc=g:GetFirst()
local c=e:GetHandler()
local tp=c:GetControler()
 while g:GetCount()>0  do
if tc:GetOriginalType()~=TYPE_MONSTER then 
sg=Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
tc=g:GetNext()
g:Sub(tg)	--g1==g on top then sub=subtract tg is the card of the group that was created when called. group(first declared) SUBTRACT grop made 
end
Duel.HintSelection(g)
Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
g:Sub(g)
if g:GetCount()==0 then return end
end
end





--special summon monsters during battle phase
function c335599117.sscon(e,tp,eg,ep,ev,re,r,rp)
return tp==Duel.GetTurnPlayer() and e:GetHandler():GetOverlayCount()>0 and (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE)
end
function c335599117.ssop(e,tp,eg,ep,ev,re,r,rp)
local n=Duel.GetLocationCount(tp,LOCATION_MZONE)
if n>0 then
local g=e:GetHandler():GetOverlayGroup():Select(tp,e:GetHandler():GetOverlayCount(),e:GetHandler():GetOverlayCount(),nil)
Duel.SpecialSummon(g,nil,tp,tp,true,false,POS_FACEUP)
end
end



--Attach monster to toon world
function c335599117.ovcon(e,tp,eg,ep,ev,re,r,rp)
return tp==Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) 
end
function c335599117.ovop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,5,nil)
local tc=g:GetFirst()
while  tc  do
local seq=tc:GetSequence()
local c=e:GetHandler()
Duel.Overlay(c,tc,REASON_TEMPORARY+REASON_EFFECT) 
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetCode(EVENT_PHASE+PHASE_BATTLE_STEP)
e1:SetReset(RESET_PHASE+PHASE_BATTLE_STEP,2)
e1:SetLabelObject(tc)
e1:SetCountLimit(1)
e1:SetCondition(c335599117.rtcon)
e1:SetOperation(c335599117.retop)
Duel.RegisterEffect(e1,tp)
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(EFFECT_DISABLE_FIELD)
e2:SetReset(RESET_PHASE+PHASE_BATTLE_START+RESET_SELF_TURN,1)
e2:SetLabel(seq)
e2:SetLabelObject(tc)
e2:SetCondition(c335599117.discon)
e2:SetOperation(c335599117.disop)
Duel.RegisterEffect(e2,tp)
tc=g:GetNext()
end
end

--returns monsters to the field
function c335599117.rtcon(e,tp,eg,ep,ev,re,r,rp)
return tp==Duel.GetTurnPlayer()
end

function c335599117.retop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
Duel.ReturnToField(c,c:GetBattlePosition())
Debug.Message"retop true"
end

--disables the object(in this case monster)
function c335599117.discon(e,c)
if e:GetLabelObject():IsLocation(LOCATION_OVERLAY) then return true end
return false
end

function c335599117.disop(e,tp)
local dis1=bit.lshift(0x1,e:GetLabel())
return dis1
end



