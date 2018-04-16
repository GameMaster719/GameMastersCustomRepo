--Holy Member Ayasa Tuerada
function c33579907.initial_effect(c)
c:SetUniqueOnField(1,1,33579907)
--token
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33579907,1))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_MZONE)
e1:SetCountLimit(1)
e1:SetCondition(c33579907.spcon2)
e1:SetTarget(c33579907.sptg2)
e1:SetOperation(c33579907.spop2)
c:RegisterEffect(e1)
--destroy if holy member leaves
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c33579907.desop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--resets target of card
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EVENT_LEAVE_FIELD_P)
    e3:SetCondition(c33579907.descon2)
    e3:SetOperation(c33579907.desop2)
    c:RegisterEffect(e3)
--Negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33579907,2))
	e4:SetCategory(CATEGORY_NEGATE)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c33579907.codisable)
	e4:SetTarget(c33579907.tgdisable)
	e4:SetOperation(c33579907.opdisable)
	e4:SetCountLimit(1)
	c:RegisterEffect(e4)
	--cannot be battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c33579907.econ)
	c:RegisterEffect(e5)
	--cannot attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_ATTACK)
	e6:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e6)
end

function c33579907.filter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end

function c33579907.econ(e)
	return Duel.IsExistingMatchingCard(c33579907.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end



function c33579907.codisable(e,tp,eg,ep,ev,re,r,rp)
 return (re:IsHasType(EFFECT_TYPE_ACTIVATE) or re:IsActiveType(TYPE_MONSTER))
		and not e:GetHandler():IsStatus(STATUS_CHAINING)
 end	

function c33579907.tgdisable(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(33579907)==0 end
	if c:IsHasEffect(EFFECT_REVERSE_UPDATE) then
		c:RegisterFlagEffect(33579907,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c33579907.opdisable(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsFaceup()  or c:GetDefense()<500 or c:GetAttack()< 500 or not c:IsRelateToEffect(e) or Duel.GetCurrentChain()~=ev+1 or c:IsStatus(STATUS_BATTLE_DESTROYED) then
		return
	end
	if  Duel.NegateActivation(ev) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(-500)
		c:RegisterEffect(e2)
	end
end



function c33579907.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
    return tc and eg:IsContains(tc)
end
function c33579907.desop2(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():CancelCardTarget(e:GetHandler():GetFirstCardTarget())
end

function c33579907.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then return end
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end


function comp(c,code)
return c:GetCode()==22222229
end

function c33579907.spcon2(e,tp,eg,ep,ev,re,r,rp)
return not e:GetHandler():GetCardTarget():SearchCard(comp,e:GetHandler():GetEquipTarget()) 
end

function c33579907.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222229,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function c33579907.spop2(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222229,0,0x4011,500,100,2,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
local token1=Duel.CreateToken(tp,22222229)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
local c=e:GetHandler()
c:SetCardTarget(token1)
local token2=Duel.CreateToken(tp,512000031)
Duel.SendtoHand(token2,tp,2,REASON_EFFECT)
if Duel.SendtoHand(token2,tp,2,REASON_EFFECT) then  
Duel.MoveToField(token2,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
if token2:IsRelateToEffect(e) then  
token2:CancelToGrave(false)
Duel.SpecialSummonComplete()
			end
if c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==22222229 and c:IsPreviousLocation(LOCATION_ONFIELD) then 
e:GetHandler():CancelCardTarget(token1)			
		end
	end
end
end

function c33579907.atkval(e,token1)
	local atk=Duel.GetLP(1-token1:GetControler())/2
	return atk
end

function c33579907.sfilter(c)
	
	return c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==33579907 and c:IsPreviousLocation(LOCATION_ONFIELD) 
end
function c33579907.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33579907.sfilter,1,nil)
end
function c33579907.sdesop(e,tp,eg,ep,ev,re,r,rp)
		Duel.Destroy(token1,REASON_EFFECT)
end