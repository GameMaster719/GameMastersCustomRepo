--Arcana Force ＸＩＩ－ＴＨＥ ＨＡＮＧＥＤ ＭＡＮ
--scripted GameMaster(GM)
function c33599909.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33599909,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c33599909.cointg)
	e1:SetOperation(c33599909.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c33599909.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c33599909.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local res=0
	if c:IsHasEffect(73206827) then
		res=1-Duel.SelectOption(tp,60,61)
	else res=Duel.TossCoin(tp,1) end
	c33599909.arcanareg(c,res)
end
function c33599909.arcanareg(c,coin)
	--coin effect
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringid(33599909,2))
	e0:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e0:SetType(EFFECT_TYPE_IGNITION)
	e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_SINGLE_RANGE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCountLimit(1)
	e0:SetCondition(c33599909.descon)
	e0:SetTarget(c33599909.destg555)
	e0:SetOperation(c33599909.desop555)
	e0:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e0)
	--coin effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33599909,1))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c33599909.descon2)
	e1:SetTarget(c33599909.destg2)
	e1:SetOperation(c33599909.desop2)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(36690018,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,coin,63-coin)
end

function c33599909.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end


function c33599909.filter555(c)
	return c:IsDestructable() 
end

function c33599909.destg555(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	--use this for the ignition effect
	--self
local heads=e:GetHandler():GetFlagEffectLabel(36690018)==1
if heads then 		
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33599909.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33599909.filter555,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,0)
	Duel.RegisterFlagEffect(tp,33599909,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
else
--opponents
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c33599909.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0  end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c33599909.filter555,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	Duel.RegisterFlagEffect(tp,33599909,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
end
end


function c33599909.desop555(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Damage(p,tc:GetAttack(),REASON_EFFECT)
	end
end

function c33599909.descon2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and  Duel.GetFlagEffect(tp,33599909)==0
end

function c33599909.destg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local heads=e:GetHandler():GetFlagEffectLabel(36690018)==1
	if chkc then 
		if not chkc:IsLocation(LOCATION_MZONE) or chkc:IsFacedown() then return false end
		if heads then return chkc:IsControler(tp)
		else return chkc:IsControler(1-tp) end
	end
if heads then
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33599909.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return true end
	local gp
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	
		g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,0,1,1,nil)
		gp=tp
		Duel.RegisterFlagEffect(tp,33599909,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
	else
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c33599909.filter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0  end
		g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
		gp=1-tp
		Duel.RegisterFlagEffect(tp,33599909,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
	end
	if g:GetCount()>0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,gp,g:GetFirst():GetAttack())
		end
	Duel.SetTargetParam(e:GetHandler():GetFlagEffectLabel(36690018))
end
function c33599909.desop2(e,tp,eg,ep,ev,re,r,rp)
	local heads=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)==1
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 and (not tc:IsRelateToBattle()) then
		if heads  then
			Duel.Damage(tp,tc:GetAttack(),REASON_EFFECT)
		else
			Duel.Damage(1-tp,tc:GetAttack(),REASON_EFFECT)
		end
	end
end


