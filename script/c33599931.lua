--Quick Attack
--scripted by GameMaster (GM)
function c33599931.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33599931.target)
	e1:SetOperation(c33599931.activate)
	c:RegisterEffect(e1)
end

function c33599931.filter(c,e,tp,tid)
	return c:IsType(TYPE_FUSION) and c:GetTurnID()==tid and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_FUSION
end

function c33599931.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c33599931.filter(chkc,e,tp,tid) end
	if chk==0 then return Duel.IsExistingTarget(c33599931.filter,tp,LOCATION_MZONE,0,1,nil,e,tp,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c33599931.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp,tid)
	if g:GetCount()>0 then
		local tg=g
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			Duel.SetTargetCard(tg)
			Duel.HintSelection(g)
	end
end
end

function c33599931.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetCode(33599931)
		e3:SetRange(LOCATION_MZONE)
		tc:ResetEffect(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		tc:RegisterEffect(e3)
	end
end