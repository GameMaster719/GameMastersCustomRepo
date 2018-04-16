--Dark NecroFear
--scripted by GameMaster(GM)
function c335599127.initial_effect(c)
	c:EnableReviveLimit()
	--special summon by removing 3 cards 
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c335599127.spcon1)
	e1:SetOperation(c335599127.spop1)
	c:RegisterEffect(e1)
	--Darknecrofear goes to grave activate ghost
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c335599127.con2)
	e2:SetOperation(c335599127.op2)
	c:RegisterEffect(e2)
	--Ghost of Dark Sanctuary
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetOperation(c335599127.op3)
	e3:SetCondition(c335599127.con333)
	e3:SetCountLimit(1)
	c:RegisterEffect(e3)
	--Gain and Damage from ghost
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c335599127.dmcon4)
	--e4:SetTarget(c335599127.dmtg4)
	e4:SetOperation(c335599127.dmop4)
	c:RegisterEffect(e4)
	--activate Dark Sanctuary 
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetTarget(c335599127.tg5)
	e5:SetOperation(c335599127.op5)
	e5:SetCondition(c335599127.con5)
	c:RegisterEffect(e5)
	end

function c335599127.con333(e)
	return  Duel.IsEnvironment(33579951) or Duel.IsEnvironment(16625614)
end	
	
	
	
	
	
--special summon from hand

function c335599127.filter6(c)
	return c:IsCode(22222234) and c:GetControler()~=tp
end
	
	
function c335599127.spfilter(c)
	return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER) 
end
function c335599127.spcon1(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c335599127.spfilter,tp,LOCATION_GRAVE,0,3,nil) and not  Duel.IsExistingMatchingCard(c335599127.filter6,tp,LOCATION_MZONE,0,1,nil) 
end
function c335599127.spop1(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c335599127.spfilter,tp,LOCATION_GRAVE,0,3,3,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end





--take control of opponents monster

function c335599127.con2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	return e:GetHandler():GetLocation()==LOCATION_GRAVE
end


function c335599127.filterghost(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end

function c335599127.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(335599127+2,0,0,1)
	if not Duel.IsEnvironment(33579951) then return false end
	if Duel.GetTurnPlayer()~=tp then
	local tc=Duel.SelectMatchingCard(c:GetOwner(),c335599127.filterghost,c:GetOwner(),0,LOCATION_MZONE,1,1,nil):GetFirst()
		if tc then
			tc:RegisterFlagEffect(335599127,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		end
	end
end



--??



function c335599127.op3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(335599127+2)>0 and Duel.GetTurnPlayer()~=tp then
		local tc=Duel.SelectMatchingCard(c:GetOwner(),c335599127.filterghost,c:GetOwner(),0,LOCATION_MZONE,1,1,nil):GetFirst()
		if tc then
			tc:RegisterFlagEffect(335599127,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		end
	end
end
function c335599127.dmcon4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	return Duel.GetAttacker():GetFlagEffect(335599127)>0 and Duel.GetAttacker():GetControler()~=tp
end
--[[function c335599127.dmtg4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local c=Duel.GetAttacker()
	local dam=c:GetAttack()/2
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end]]--
function c335599127.dmop4(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=Duel.GetAttacker()
	local dam=c:GetAttack()/2
	if Duel.NegateAttack() then
		Duel.Recover(tp,dam,REASON_EFFECT)
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end




--dark sanctuary when Darknecrofear goes to grave
function c335599127.tg5(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(c335599127.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil) 
	and Duel.CheckLocation(e:GetHandlerPlayer(),LOCATION_SZONE,5) end
end

function c335599127.con5(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	return e:GetHandler():GetLocation()==LOCATION_GRAVE
end

function c335599127.filter2(c)
	return c:GetOriginalCode()==33579951
end

function c335599127.op5(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.CheckLocation(e:GetHandlerPlayer(),LOCATION_SZONE,5) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c335599127.filter2,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tp=tc:GetControler()
		local cost=te:GetCost()
		if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
		end
	end
