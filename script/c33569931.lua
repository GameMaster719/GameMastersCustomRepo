--Enchanted Javelin (DOR)
--scripted by GameMaster (GM)
function c33569931.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33569931.target)
	e1:SetOperation(c33569931.activate)
	c:RegisterEffect(e1)
end

function c33569931.filter(c)
	return c:IsRace(RACE_FAIRY)
end

function c33569931.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c33569931.destg)
	e1:SetOperation(c33569931.desop)
	e1:SetCondition(c33569931.con)
	e1:SetReset(RESET_EVENT+0x00040000)
	tc:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLED)
	e2:SetOperation(c33569931.desop)
	tc:RegisterEffect(e2)
	end
end

function c33569931.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and bc:IsRace(RACE_FIEND)
end

function c33569931.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetFirstTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c33569931.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33569931.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,tc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	g=Duel.SelectTarget(tp,c33569931.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc)
	if g:GetCount()>0 then
		local tg=g
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			Duel.SetTargetCard(tg)
			Duel.HintSelection(g)
end
end
end


function c33569931.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsFaceup() and bc:IsRace(RACE_FIEND) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
	end

function c33569931.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc and bc:IsRace(RACE_FIEND) then return end
	if bc:IsRelateToBattle() and bc:IsRace(RACE_FIEND) then
		Duel.Destroy(bc,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x17a0000)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x17a0000)
		bc:RegisterEffect(e2)
	end
end
