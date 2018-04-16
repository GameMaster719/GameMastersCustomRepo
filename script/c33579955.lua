--Joyful Doom
--scripted by GameMaster (GM)
function c33579955.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c33579955.condition)
	e1:SetTarget(c33579955.target)
	e1:SetOperation(c33579955.activate)
	c:RegisterEffect(e1)
end

c33579955.collection={ [88071625]=true; [6614221]=true; [8794435]=true; [47942531]=true; [10000010]=true; [23770284]=true;   }

function c33579955.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and bit.band(tc:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE 
		and tc:GetSummonPlayer()~=tp
end
function c33579955.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	local g=tc:GetMaterial()
	if chk==0 then return g:GetCount()>0 end
	local lp=g:GetSum(Card.GetPreviousAttackOnField)
	Duel.SetTargetCard(tc)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(lp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,lp)
end
function c33579955.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c33579955.filter,tp,0,LOCATION_MZONE,nil)
	local tc=Duel.GetFirstTarget()
	if tc then
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
	if  tc:IsCode(23770284)  then
	local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-d/2)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
elseif (tc:IsCode(8794435)or tc:IsCode(10000010)or tc:IsCode(47942531) or tc:IsCode(6614221)) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_NO_TURN_RESET)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		tc:RegisterEffect(e1)
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_BASE_ATTACK)
e1:SetValue(0)
e1:SetReset(RESET_EVENT+0x1ff0000)
tc:RegisterEffect(e1)
elseif tc:GetOriginalCode()==88071625 then
local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(0)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_NO_TURN_RESET)
			tc:RegisterEffect(e1)
			end
	end
end