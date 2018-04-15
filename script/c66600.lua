--The Winged Dragon of Ra
--Scrited by GameMaster(GM)
function c66600.initial_effect(c)
c:SetUniqueOnField(1,1,66600)
--Summon with 3 Tribute
local e0=Effect.CreateEffect(c)
e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
e0:SetType(EFFECT_TYPE_SINGLE)
e0:SetCode(EFFECT_LIMIT_SUMMON_PROC)
e0:SetCondition(c66600.sumoncon)
e0:SetOperation(c66600.sumonop)
e0:SetValue(SUMMON_TYPE_ADVANCE)
c:RegisterEffect(e0)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_LIMIT_SET_PROC)
e1:SetCondition(c66600.setcon)
c:RegisterEffect(e1)
--Summon Cannot be Negated
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_CANNOT_DISABLE_SUMMON)
e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
c:RegisterEffect(e2)
--Change Battle Position in Turn that is Normal Summoned
local e3=Effect.CreateEffect(c)
e3:SetDescription(aux.Stringid(66600,0))
e3:SetCategory(CATEGORY_POSITION)
e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e3:SetType(EFFECT_TYPE_IGNITION)
e3:SetRange(LOCATION_MZONE)
e3:SetCountLimit(1)
e3:SetCost(c66600.changebattlepositioncost)
e3:SetOperation(c66600.changebattlepositionop)
c:RegisterEffect(e3)
--negate atk
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(66600,7))
e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e4:SetCode(EVENT_BE_BATTLE_TARGET)
e4:SetCondition(c66600.negcon)
e4:SetOperation(c66600.negop)
c:RegisterEffect(e4)
--Original ATK/DEF
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_MATERIAL_CHECK)
e5:SetValue(c66600.materialvalcheck)
c:RegisterEffect(e5)
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e6:SetCode(EVENT_SUMMON_SUCCESS)
e6:SetOperation(c66600.atkdefop)
c:RegisterEffect(e6)
--release limit
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_SINGLE)
e7:SetCode(EFFECT_UNRELEASABLE_SUM)
e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e7:SetRange(LOCATION_MZONE)
e7:SetValue(c66600.recon)
c:RegisterEffect(e7)
local e8=e7:Clone()
e8:SetCondition(c66600.recon2)
e8:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e8)
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetCode(EFFECT_UNRELEASABLE_EFFECT)
e9:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e9:SetRange(LOCATION_MZONE)
e9:SetValue(1)
c:RegisterEffect(e9)
--Cannot Switch Controller
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_SINGLE)
e10:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e10:SetRange(LOCATION_MZONE)
e10:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
e10:SetValue(1)
c:RegisterEffect(e10)
-- Cannot Disable effect
local e11=Effect.CreateEffect(c)
e11:SetType(EFFECT_TYPE_SINGLE)
e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
e11:SetCode(EFFECT_CANNOT_DISABLE)
e11:SetRange(LOCATION_MZONE)
e11:SetValue(1)
c:RegisterEffect(e11)
--indestructable
local e12=Effect.CreateEffect(c)
e12:SetType(EFFECT_TYPE_SINGLE)
e12:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e12:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
e12:SetRange(LOCATION_MZONE)
e12:SetValue(c66600.indes)
c:RegisterEffect(e12)
--Spell cards only last till end phase
local e13=Effect.CreateEffect(c)
e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e13:SetProperty(EFFECT_FLAG_REPEAT)
e13:SetRange(LOCATION_MZONE)
e13:SetCode(EVENT_PHASE+PHASE_END)
e13:SetCondition(c66600.con4321)
e13:SetCountLimit(1)
e13:SetOperation(c66600.atkdefresetop)
c:RegisterEffect(e13)
--
local e14=Effect.CreateEffect(c)
e14:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e14:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e14:SetCode(EVENT_SUMMON_SUCCESS)
e14:SetOperation(c66600.changebattlepositionop2)
c:RegisterEffect(e14)
--If Special Summoned from Grave: Return it
local e15=Effect.CreateEffect(c)
e15:SetCategory(CATEGORY_TOGRAVE)
e15:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e15:SetRange(LOCATION_MZONE)
e15:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
e15:SetCountLimit(1)
e15:SetCode(EVENT_PHASE+PHASE_BATTLE)
e15:SetCondition(c66600.specialsumtogravecon)
e15:SetTarget(c66600.specialsumtogravetg)
e15:SetOperation(c66600.specialsumtograveop)
c:RegisterEffect(e15)
local e16=e15:Clone()
e16:SetCode(EVENT_PHASE+PHASE_END)
c:RegisterEffect(e16)
--Point-to-Point Transfer
local e17=Effect.CreateEffect(c)
e17:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e17:SetCountLimit(1)
e17:SetCode(EVENT_SPSUMMON_SUCCESS)
e17:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
e17:SetCondition(c66600.egpcon)
e17:SetTarget(c66600.immortal)
c:RegisterEffect(e17)
--Tribute-to-Point Transfer monster absorb
local e18=Effect.CreateEffect(c)
e18:SetDescription(aux.Stringid(66600,2))
e18:SetCategory(CATEGORY_ATKCHANGE)
e18:SetType(EFFECT_TYPE_QUICK_O)
e18:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e18:SetCode(EVENT_FREE_CHAIN)
e18:SetHintTiming(TIMING_DAMAGE_STEP)
e18:SetRange(LOCATION_MZONE)
e18:SetCondition(c66600.con999)
e18:SetCost(c66600.pptcost)
e18:SetOperation(c66600.pptop)
c:RegisterEffect(e18)
--Instant Attack
local e19=Effect.CreateEffect(c)
e19:SetDescription(aux.Stringid(66600,3))
e19:SetType(EFFECT_TYPE_QUICK_O)
e19:SetCode(EVENT_FREE_CHAIN)
e19:SetHintTiming(TIMING_BATTLE_PHASE)
e19:SetRange(LOCATION_MZONE)
e19:SetCountLimit(1)
e19:SetCost(c66600.iacost)
e19:SetOperation(c66600.iaop)
c:RegisterEffect(e19)
--"De-Fusion" Point-to-Point Transfer reverse
local e20=Effect.CreateEffect(c)
e20:SetDescription(aux.Stringid(66600,4))
e20:SetCategory(CATEGORY_RECOVER+CATEGORY_ATKCHANGE)
e20:SetType(EFFECT_TYPE_QUICK_O)
e20:SetCode(EVENT_FREE_CHAIN)
e20:SetHintTiming(TIMING_DAMAGE_STEP)
e20:SetRange(LOCATION_MZONE)
e20:SetCost(c66600.defusioncost)
e20:SetOperation(c66600.defusionop)
c:RegisterEffect(e20)
--cannot be target
local e21=Effect.CreateEffect(c)
e21:SetType(EFFECT_TYPE_SINGLE)
e21:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e21:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e21:SetRange(LOCATION_MZONE)
e21:SetValue(c66600.tgfilter)
c:RegisterEffect(e21)
--immune effect
local e22=Effect.CreateEffect(c)
e22:SetType(EFFECT_TYPE_SINGLE)
e22:SetCode(EFFECT_IMMUNE_EFFECT)
e22:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e22:SetRange(LOCATION_MZONE)
e22:SetValue(c66600.efilter)
c:RegisterEffect(e22)
--Change Battle Target when Special Summoned in Defense Position
local e23=Effect.CreateEffect(c)
e23:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
e23:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e23:SetCode(EVENT_BE_BATTLE_TARGET)
e23:SetRange(LOCATION_MZONE)
e23:SetCountLimit(1)
e23:SetCondition(c66600.changebattletargetcon)
e23:SetOperation(c66600.changebattletargetop)
c:RegisterEffect(e23)
end

-------------------------------------
function c66600.iacost(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0  and Duel.GetFlagEffect(tp,10000013)==0 
and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsPreviousLocation(LOCATION_GRAVE) end
Duel.RegisterFlagEffect(tp,10000013,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
end
function c66600.iaop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UNSTOPPABLE_ATTACK)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SINGLE_RANGE)
e1:SetRange(LOCATION_MZONE)
e1:SetReset(RESET_EVENT+0x1ff0000)
c:RegisterEffect(e1)
end
----------------------------------------
function c66600.con999(e,c)
local c=e:GetHandler()
return c:GetFlagEffect(511000237)==0
end

function c66600.imcon(e)
local c=e:GetHandler()
if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 and Duel.GetFlagEffect(tp,66600)>0 
and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsPreviousLocation(LOCATION_GRAVE) end
end

function c66600.egpcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function c66600.immortal(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c66600.payatkcost(e,tp,eg,ep,ev,re,r,rp,0) then
		local op=Duel.SelectOption(tp,aux.Stringid(66600,1),aux.Stringid(66600,5))
		if op==0 then
			c66600.payatkcost(e,tp,eg,ep,ev,re,r,rp,1)
			e:SetOperation(c66600.payatkop)
		elseif op==1 then
			e:SetOperation(c66600.egpop)
			end
	else
		local op=Duel.SelectOption(tp,aux.Stringid(4012,4),aux.Stringid(4012,5))
		if op==0 then
			e:SetOperation(c66600.egpop)
			else
			e:SetOperation(nil)
		end
	end
end

--Point to Point Transfer
function c66600.payatkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2) end
	local lp=Duel.GetLP(tp)
	e:SetLabel(lp-1)
	Duel.PayLPCost(tp,lp-1)
	Duel.RegisterFlagEffect(tp,66600,RESET_EVENT+0x1ff0000,0,1)
end

function c66600.payatkop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local lp=e:GetLabel()
if c:IsFaceup() then
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_BASE_ATTACK)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetRange(LOCATION_MZONE)
e1:SetValue(c:GetBaseAttack()+lp)
e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_SET_BASE_DEFENSE)
e2:SetValue(c:GetBaseDefense()+lp)
c:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_ADD_TYPE)
e3:SetValue(TYPE_FUSION)
e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
c:RegisterEffect(e3)
local def=Effect.CreateEffect(c)
def:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
c:RegisterEffect(def)
 --gain atk/def when lp recover
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
e5:SetCode(EVENT_RECOVER)
e5:SetRange(LOCATION_MZONE)
e5:SetOperation(c66600.atkop1)
e5:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
c:RegisterEffect(e5)
--gain atk/def
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e6:SetCode(EVENT_CHAIN_END)
e6:SetRange(LOCATION_MZONE)
e6:SetOperation(c66600.atkop2)
e6:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
c:RegisterEffect(e6)

local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetCode(EFFECT_EXTRA_ATTACK)
e9:SetValue(12)
e9:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
c:RegisterEffect(e9)
end
end

function c66600.atkop1(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	Duel.SetLP(tp,1,REASON_EFFECT)
end

function c66600.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local lp=Duel.GetLP(tp)
	if lp<=1 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(lp-1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(lp-1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e:GetHandler():RegisterEffect(e1)
	Duel.SetLP(tp,1,REASON_EFFECT)
end

function c66600.indes(e,re,rp)
	return not re:GetOwner():IsCode(100000535) and not re:GetOwner():IsCode(10000020)
end

function c66600.con225599(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)>1
end

function c66600.con4321(e,tp)
if Duel.IsPlayerAffectedByEffect(tp,33579955)  then return false 
  else return true 
	end
end

function c66600.setcon(e,c)
	if not c then return true end
	return false
end

function c66600.materialvalcheck(e,c)
local g=c:GetMaterial()
Original_ATK=g:GetSum(Card.GetAttack)
Original_DEF=g:GetSum(Card.GetDefense)
end

function c66600.atkdefop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:GetMaterialCount()==0 then return end
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_BASE_ATTACK)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e1:SetCondition(c66600.con4321)
e1:SetRange(LOCATION_MZONE)
e1:SetValue(Original_ATK)
e1:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_SET_BASE_DEFENSE)
e2:SetValue(Original_DEF)
c:RegisterEffect(e2)
end

function c66600.sumoncon(e,c)
if c==nil then return true end
return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3 and Duel.GetTributeCount(c)>=3
end

function c66600.sumonop(e,tp,eg,ep,ev,re,r,rp,c)
local g=Duel.SelectTribute(tp,c,3,3)
c:SetMaterial(g)
Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end

function c66600.tgg(c,card)
	return c:GetCardTarget() and c:GetCardTarget():IsContains(card) 
end

function c66600.atkdefresetop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local eqg=c:GetEquipGroup()
if eqg:GetCount()<0 then return false end
local eqg=c:GetEquipGroup()
local tgg=Duel.GetMatchingGroup(c66600.tgg,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,c)
eqg:Merge(tgg)
if eqg:GetCount()>0 then
Duel.Destroy(eqg,REASON_EFFECT)
end
end

function c66600.changebattlepositioncost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():GetFlagEffect(66600)==1 and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_NORMAL)==SUMMON_TYPE_NORMAL 
and e:GetHandler():GetAttackAnnouncedCount()==0 end
end

function c66600.changebattlepositionop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
Duel.ChangePosition(c,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
end

function c66600.changebattlepositionop2(e,tp,eg,ep,ev,re,r,rp)
e:GetHandler():RegisterFlagEffect(66600,RESET_EVENT+0xfc0000+RESET_PHASE+PHASE_END,0,1)
end
function c66600.specialsumtogravecon(e,tp,eg,ep,ev,re,r,rp)
return bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():GetPreviousLocation()==LOCATION_GRAVE and e:GetHandler():IsAbleToGrave()
end

function c66600.specialsumtogravetg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
end

function c66600.specialsumtograveop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and c:IsFaceup() then
Duel.SendtoGrave(c,REASON_EFFECT)
end
end

function c66600.changebattletargetcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local bt=Duel.GetAttackTarget()
return c~=bt and bt:IsControler(tp) and bit.band(e:GetHandler():GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL and e:GetHandler():IsDefensePos()
end

function c66600.changebattletargetop(e,tp,eg,ep,ev,re,r,rp)
Duel.ChangeAttackTarget(e:GetHandler())
end

function c66600.facechk(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
end

 function c66600.pptcost(e,tp,eg,ep,ev,re,r,rp,chk)
 local c=e:GetHandler()
if c:GetFlagEffect(511000237)>0 then return false end 
if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,e:GetHandler())  end
local g=Duel.SelectReleaseGroup(tp,nil,1,10,e:GetHandler())
g:KeepAlive()
e:SetLabelObject(g)
local ATK=g:GetSum(Card.GetAttack)
local DEF=g:GetSum(Card.GetDefense)
Duel.Release(g,REASON_COST)
Duel.RegisterFlagEffect(tp,66603,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
end

function c66600.pptop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local g=e:GetLabelObject()
local ATK=g:GetSum(Card.GetPreviousAttackOnField)
local DEF=g:GetSum(Card.GetPreviousDefenseOnField)
if c:IsFaceup() and c:IsRelateToEffect(e) then
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e1:SetValue(ATK)
e1:SetReset(RESET_EVENT+0x1ff0000)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
e2:SetValue(DEF)
c:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_ADD_TYPE)
e3:SetValue(TYPE_FUSION)
e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
c:RegisterEffect(e3)
end
end

function c66600.costfilter(c)
return c:IsCode(95286165) and c:IsAbleToGraveAsCost()
end

function c66600.filter2121(c)
	return c:IsFaceup() and c:IsType(TYPE_FUSION) and c:IsCode(10000010) 
end

function c66600.defusioncost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c66600.costfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,e:GetHandler()) and Duel.GetFlagEffect(tp,66600)>0
and e:GetHandler():GetAttack()>0 end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
local g=Duel.SelectTarget(tp,c66600.filter2121,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetAttack())
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
local g=Duel.SelectMatchingCard(tp,c66600.costfilter,tp,LOCATION_HAND+LOCATION_SZONE,0,1,1,nil)
if g:GetCount()>0 then
local tg=g
if tg:GetCount()>0 then
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
Duel.ConfirmCards(tp,g)
Duel.SendtoGrave(g,REASON_COST)
end
end
end

function c66600.defusionop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsFaceup() and c:IsRelateToEffect(e) then
local ATK=c:GetAttack()
local DEF=c:GetDefense()
Duel.Recover(tp,ATK,REASON_EFFECT)
c:ResetEffect(RESET_LEAVE,RESET_EVENT)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetReset(RESET_EVENT+0x1fe0000)
e1:SetCode(EFFECT_SET_BASE_ATTACK)
e1:SetValue(-ATK)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_SET_BASE_DEFENSE)
e2:SetValue(-DEF)
c:RegisterEffect(e2)
end
if Duel.GetAttacker()==e:GetHandler() then
Duel.NegateAttack()
end
end

function c66600.egpcon(e,tp,eg,ep,ev,re,r,rp)
return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end

function c66600.egpop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsFaceup() then
c:RegisterFlagEffect(511000237,RESET_PHASE+PHASE_END,0,1)
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_SINGLE)
e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
e0:SetReset(RESET_EVENT+0x1fe0000)
e0:SetCode(EFFECT_CHANGE_CODE)
e0:SetValue(511000237)
c:RegisterEffect(e0)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetValue(1)
e1:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e1)
--destroy effect 
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(66600,6))
e2:SetCategory(CATEGORY_DESTROY)
e2:SetType(EFFECT_TYPE_QUICK_O)
e2:SetCode(EVENT_FREE_CHAIN)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
e2:SetRange(LOCATION_MZONE)
e2:SetCost(c66600.descost)
e2:SetTarget(c66600.destg)
e2:SetOperation(c66600.desop)
e2:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e3:SetValue(1)
e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
c:RegisterEffect(e3)
local e4=e3:Clone()
e4:SetCode(EFFECT_INDESTRUCTABLE)
c:RegisterEffect(e4)
local e5=e3:Clone()
e5:SetCode(EFFECT_UNRELEASABLE_EFFECT)
c:RegisterEffect(e5)
local e6=e3:Clone()
e6:SetCode(EFFECT_CANNOT_REMOVE)
c:RegisterEffect(e6)
local e7=e3:Clone()
e7:SetCode(EFFECT_CANNOT_TO_HAND)
c:RegisterEffect(e7)
local e8=e3:Clone()
e8:SetCode(EFFECT_CANNOT_TO_DECK)
c:RegisterEffect(e8)
local e9=e3:Clone()
e9:SetCode(EFFECT_CANNOT_TO_GRAVE)
e9:SetCondition(c66600.con555)
c:RegisterEffect(e9)
end
end

function c66600.con555(e,tp,eg,ep,ev,re,r,rp)
return not re==e:GetHandler()
end

function c66600.descost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckLPCost(tp,1000) end
Duel.PayLPCost(tp,1000)
end

function c66600.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end

function c66600.desop(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
local dg=Group.CreateGroup()
local c=e:GetHandler()
local tc=g:GetFirst()
while tc do
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_DISABLE)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IMMEDIATELY_APPLY)
e1:SetReset(RESET_EVENT+0x17a0000)
tc:RegisterEffect(e1)
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE)
e2:SetCode(EFFECT_DISABLE_EFFECT)
e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_IMMEDIATELY_APPLY)
e2:SetReset(RESET_EVENT+0x17a0000)
tc:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetRange(LOCATION_MZONE)
e3:SetCode(EFFECT_IMMUNE_EFFECT)
e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e3:SetValue(c66600.desfil)
e3:SetReset(RESET_EVENT+0x17a0000)
tc:RegisterEffect(e3)
tc:SetStatus(STATUS_DISABLED,true)
dg:AddCard(tc)

tc=g:GetNext()
end

Duel.Destroy(dg,REASON_EFFECT)
end

function c66600.desfil(e,te)
	return te:GetOwner()~=e:GetOwner()
end

function c66600.efilter(e,te)
return te:IsActiveType(TYPE_EFFECT) and te:GetOwner()~=e:GetOwner()
end

function c66600.tgfilter(e,re)
if not re or not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
return re:IsHasCategory(CATEGORY_TOHAND+CATEGORY_DESTROY+CATEGORY_REMOVE+CATEGORY_TODECK+CATEGORY_RELEASE+CATEGORY_TOGRAVE)
end

function c66600.recon(e,c)
return c:GetControler()~=e:GetHandler():GetControler()
end

function c66600.recon2(e)
return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end

function c66600.negcon(e,tp,eg,ep,ev,re,r,rp)
local a=Duel.GetAttacker()
return a:IsControler(1-tp) and a:IsFaceup() and a:IsAttribute(ATTRIBUTE_DEVINE) and a:IsRace(RACE_DEVINE) 
and not a:IsCode(10000011) and not a:IsCode(21208154)
end

function c66600.negop(e,tp,eg,ep,ev,re,r,rp)
Duel.NegateAttack()
end