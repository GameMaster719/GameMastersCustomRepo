--Holy Member Kigetsuki
function c33579903.initial_effect(c)
 c:SetUniqueOnField(1,1,33579903)
 --tokenastu sisters
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33579903,0))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e1:SetType(EFFECT_TYPE_QUICK_O)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetRange(LOCATION_MZONE)
e1:SetCountLimit(1)
e1:SetCondition(c33579903.spcon2)
e1:SetTarget(c33579903.sptg2)
e1:SetOperation(c33579903.spop2)
c:RegisterEffect(e1)
--destroy sisters summon burning summer
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33579903,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c33579903.spcon3)
	e2:SetTarget(c33579903.destg)
	e2:SetOperation(c33579903.desop)
	c:RegisterEffect(e2)
	--cannot select battle target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c33579903.atlimit1)
	c:RegisterEffect(e3)
	--DETACH FROM CHUKA
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_CUSTOM+33579903)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c33579903.op333)
	c:RegisterEffect(e4)
	-- Cannot Disable effect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetCode(EFFECT_CANNOT_DISABLE)
	e5:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e5)
	--release limit
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetCode(EFFECT_UNRELEASABLE_SUM)
e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e6:SetRange(LOCATION_MZONE)
e6:SetValue(c33579903.recon)
c:RegisterEffect(e6)
local e7=e6:Clone()
e7:SetCondition(c33579903.recon2)
e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
c:RegisterEffect(e7)
--destroy if holy member leaves
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e8:SetCode(EVENT_LEAVE_FIELD)
	e8:SetOperation(c33579903.desop359)
	e8:SetLabelObject(e2)
	c:RegisterEffect(e8)
	--destroy if holy member leaves
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e9:SetCode(EVENT_LEAVE_FIELD)
	e9:SetOperation(c33579903.desop359)
	e9:SetLabelObject(e1)
	c:RegisterEffect(e9)
	--cannot attack
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_SINGLE)
	e10:SetCode(EFFECT_CANNOT_ATTACK)
	e10:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e10)
end

function c33579903.desop359(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then return end
	local g=Duel.GetMatchingGroup(c33579903.filter2,1-tp,0,LOCATION_MZONE,c)
	if g then
		Duel.Destroy(g,REASON_EFFECT)
	end
end

function c33579903.recon(e,c)
	return c:GetControler()~=e:GetHandler():GetControler()
end
function c33579903.recon2(e)
	return Duel.GetTurnPlayer()~=e:GetOwnerPlayer()
end


function c33579903.op333(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetOverlayGroup(tp,1,1)
	if g:GetCount()~=0  then
	local n=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if n>0 then
		if g:GetCount()~=0 then
		Duel.SpecialSummon(g,nil,1-tp,1-tp,true,false,POS_FACEUP)
		local tc=g:GetFirst()
	end
	else
	 Duel.SendtoGrave(g,REASON_RULE) 
end
end
end
function c33579903.spfilter(c)
return  c33579903.collection[c:GetCode()] 
end

function c33579903.spcon2(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33579903.spfilter,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end

function c33579903.spcon3(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33579903.spfilter3,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end


function c33579903.spfilter3(c)
return  c33579903.collection2[c:GetCode()] 
end

function c33579903.atlimit1(e,c)
	return c==e:GetHandler() and c:IsFaceup() and c:IsCode(33579903)
end


c33579903.collection2={ [22222228]=true; }

c33579903.collection={ [22222204]=true; [22222205]=true; [22222206]=true; [22222228]=true;}


function c33579903.filter2(c)
	return c:IsFaceup() and c33579903.collection[c:GetCode()] 
end

function c33579903.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33579903.filter2(chkc)  end
	if chk==0 then return Duel.IsExistingTarget(c33579903.filter2,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33579903.filter2,tp,LOCATION_MZONE,0,3,3,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,3,0,0)
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+33579903,e,0,0,tp,0)
end
function c33579903.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33579903.filter2,tp,LOCATION_MZONE,0,c)
	local tc=g:GetFirst()
	while tc do
	--do your thing to c
	Duel.Destroy(tc,REASON_EFFECT)
    tc=g:GetNext()
	end
	if tc and Duel.Destroy(tc,REASON_EFFECT)>0  then
	return  Duel.GetLocationCount(tp,LOCATION_MZONE,tp)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,22222228,0,0x4011,2500,2500,7,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP,tp) end
			local token=Duel.CreateToken(tp,22222228)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
			--damage
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetDescription(aux.Stringid(33579903,0))
			e1:SetCategory(CATEGORY_DAMAGE)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetRange(LOCATION_MZONE)
			e1:SetCountLimit(1)
			e1:SetTarget(c33579903.target)
			e1:SetOperation(c33579903.operation)
			token:RegisterEffect(e1)
			--atk UP
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetRange(LOCATION_MZONE)
			e2:SetTargetRange(LOCATION_MZONE,0)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE))
			e2:SetValue(100)
			token:RegisterEffect(e2)
			local c=e:GetHandler()
			c:SetCardTarget(token)
			local token5=Duel.CreateToken(tp,19384334)
			Duel.SendtoHand(token5,tp,2,REASON_EFFECT)
		if Duel.SendtoHand(token5,tp,2,REASON_EFFECT) then	
			Duel.MoveToField(token5,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		if token5:IsRelateToEffect(e) then	
			token5:CancelToGrave(false)
			Duel.SpecialSummonComplete()
			end
	end	
end
function c33579903.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(600)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,600)
end
function c33579903.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end



function c33579903.spfilter(c)
return  c33579903.collection[c:GetCode()] 
end

function c33579903.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222204,0,0x4011,2000,0,3,RACE_SPELLCASTER,ATTRIBUTE_DARK) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c33579903.spop2(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222204,0,0x4011,2000,0,3,RACE_SPELLCASTER,ATTRIBUTE_DARK) then
local token1=Duel.CreateToken(tp,22222204)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP)
	--pierce
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	token1:RegisterEffect(e1)
	--increase atk of banka
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c33579903.condtion)
	e2:SetValue(c33579903.val)
	token1:RegisterEffect(e2)
	local c=e:GetHandler()
	c:SetCardTarget(token1)
local token2=Duel.CreateToken(tp,22222205)
Duel.SpecialSummonStep(token2,0,tp,tp,false,false,POS_FACEUP)
	--attach opponents monster
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetDescription(aux.Stringid(19310321,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetTarget(c33579903.mttarget)
	e3:SetOperation(c33579903.mtoperation)
	e3:SetCondition(c33579903.con123123)
	token2:RegisterEffect(e3)
	local c=e:GetHandler()
	c:SetCardTarget(token2)
local token3=Duel.CreateToken(tp,22222206)
Duel.SpecialSummonStep(token3,0,tp,tp,false,false,POS_FACEUP)
	--recover with shoka
	local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetDescription(aux.Stringid(33579903,0))
	e5:SetCategory(CATEGORY_RECOVER)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c33579903.target3)
	e5:SetOperation(c33579903.operation3)
	token3:RegisterEffect(e5)
	--destroy card on field with shoka
	local e6=Effect.CreateEffect(e:GetHandler())
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetTarget(c33579903.destg2)
	e6:SetOperation(c33579903.desop2)
	token3:RegisterEffect(e6)
	local c=e:GetHandler()
	c:SetCardTarget(token3)
Duel.SpecialSummonComplete()
end
end


function c33579903.con123123(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	return not c:GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_MONSTER)
end



function c33579903.filter3(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end


function c33579903.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c33579903.filter3(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c33579903.filter3,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33579903.filter3,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c33579903.desop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
		Duel.Damage(1-tp,300,REASON_EFFECT)
	end
end


function c33579903.mttarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler()
		and Duel.IsExistingTarget(Card.IsType,tp,0,LOCATION_MZONE,1,nil,TYPE_MONSTER) end
	if e:GetHandler():GetOverlayCount(c)>0 then return false end	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsType,tp,0,LOCATION_MZONE,1,1,nil,TYPE_MONSTER)
end
function c33579903.mtoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetHandler():GetOverlayCount(c)>0 then return  false  end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		Duel.Overlay(c,tc)
		end
	end

function c33579903.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(700)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,700)
end
function c33579903.operation3(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Recover(p,d,REASON_EFFECT)
	end
end	

function c33579903.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL
end
function c33579903.val(e,c)
	if Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil then return 350
	elseif e:GetHandler()==Duel.GetAttackTarget() then return -0
	else return 0 end
end

