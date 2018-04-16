--Holy Member Emergy Maxfell
function c33579904.initial_effect(c)
  --token
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33579904,1))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetType(EFFECT_TYPE_QUICK_O)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetRange(LOCATION_MZONE)
e1:SetCountLimit(1)
e1:SetCondition(c33579904.spcon2)
e1:SetTarget(c33579904.sptg2)
e1:SetOperation(c33579904.spop2)
c:RegisterEffect(e1)
	--destroy if holy member leaves
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c33579904.desop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--resets target of card
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetCode(EVENT_LEAVE_FIELD_P)
    e3:SetCondition(c33579904.descon2)
    e3:SetOperation(c33579904.desop2)
    c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33579904,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_BATTLE_CONFIRM)
	e4:SetOperation(c33579904.op)
	e4:SetCountLimit(3)
	c:RegisterEffect(e4)
	--battle indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e5:SetCountLimit(3)
	e5:SetValue(c33579904.valcon)
	c:RegisterEffect(e5)
	--cannot attack
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_ATTACK)
	e6:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e6)
	--cannot be battle target
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCondition(c33579904.econ)
	c:RegisterEffect(e7)
end


function c33579904.filter(c)
	return c:IsFaceup() and c:IsCode(22222230)
end

function c33579904.econ(e)
	return Duel.IsExistingMatchingCard(c33579904.filter,tp,LOCATION_MZONE,0,1,nil)
		
end





function c33579904.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
    return tc and eg:IsContains(tc)
end
function c33579904.desop2(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():CancelCardTarget(e:GetHandler():GetFirstCardTarget())
end

function c33579904.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then return end
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end



function comp(c,code)
return c:GetCode()==22222230
end

function c33579904.spcon2(e,tp,eg,ep,ev,re,r,rp)
return not e:GetHandler():GetCardTarget():SearchCard(comp,e:GetHandler():GetEquipTarget()) 
end


function c33579904.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222230,0,0x4011,500,100,9,RACE_MACHINE,ATTRIBUTE_LIGHT) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function c33579904.spop2(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222230,0,0x4011,500,100,9,RACE_MACHINE,ATTRIBUTE_LIGHT) then
local token1=Duel.CreateToken(tp,22222230)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP_ATTACK)
--Cannot Attack Directly
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	token1:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCondition(c33579904.damcon22)
	e2:SetOperation(c33579904.damop22)
	e2:SetRange(LOCATION_MZONE)
	token1:RegisterEffect(e2)
local c=e:GetHandler()
c:SetCardTarget(token1)
Duel.SpecialSummonComplete()
if c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==22222230 and c:IsPreviousLocation(LOCATION_ONFIELD) then 
e:GetHandler():CancelCardTarget(token1)			
		end
end
end


function c33579904.damcon22(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if e:GetHandler():GetAttack()>d:GetAttack() then return end
	if not d then return false end
	local g=Group.FromCards(a,d)
	return g:IsExists(c33579904.filter,1,nil,1)
end
function c33579904.damop22(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return end
	local g=Group.FromCards(a,d)
	g=g:Filter(c33579904.filter,nil,1)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		if tc==a then
			e1:SetValue(d:GetAttack())
		else
			e1:SetValue(a:GetAttack())
		end
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end


function c33579904.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end

c33579904[0]=0
c33579904[1]=0

function c33579904.op(e,tp,eg,ep,ev,re,r,rp)
	c33579904[tp]=1
	if not e:GetHandler():GetCode()==33579904 then return end
	if Duel.GetFlagEffect(tp,33579904)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(3)
	e1:SetTargetRange(1,0)
	e1:SetValue(c33579904.val)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE,1)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,33579904,RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c33579904.val(e,re,dam,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 and re and re:IsActiveType(TYPE_MONSTER) and re:GetHandlerPlayer()~=tp then
		e:Reset()
		return dam/2 end
	if bit.band(r,REASON_BATTLE)~=0 then
		e:Reset()
		return dam/2 end
	return dam
end