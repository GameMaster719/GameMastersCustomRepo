--Lava Golem (Anime)
--Scripted by GameMaster (GM)
function c33579925.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33579925,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP,1)
	e1:SetCondition(c33579925.spcon)
	e1:SetOperation(c33579925.spop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetDescription(aux.Stringid(33579925,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c33579925.damcon)
	e2:SetTarget(c33579925.damtg)
	e2:SetOperation(c33579925.damop)
	c:RegisterEffect(e2)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetDescription(aux.Stringid(33579925,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c33579925.con2)
	e2:SetTarget(c33579925.damtg)
	e2:SetOperation(c33579925.damop)
	c:RegisterEffect(e2)
end
function c33579925.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(Card.IsReleasable,c:GetControler(),0,LOCATION_MZONE,2,nil)
end

function c33579925.con2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and  Duel.GetFlagEffect(tp,33579925)==0
end

function c33579925.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasable,tp,0,LOCATION_MZONE,2,2,nil)
	Duel.Release(g,REASON_COST)
end
function c33579925.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c33579925.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(700)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,700)
	Duel.RegisterFlagEffect(tp,33579925,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
end
function c33579925.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end

