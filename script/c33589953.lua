--CurseBreaker (DOR)
--scripted by GameMaster (GM)
function c33589953.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33589953.target)
	e1:SetOperation(c33589953.activate)
	c:RegisterEffect(e1)
end
function c33589953.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c33589953.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(tc:GetTextAttack())
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e2:SetValue(tc:GetTextDefense())
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetCode(33589953)
		e3:SetRange(LOCATION_MZONE)
		tc:ResetEffect(RESET_DISABLE,RESET_EVENT)
		tc:RegisterEffect(e3)
		
end
end



function c33589953.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=Duel.GetFirstTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE)  and c33589953.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c33589953.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,tc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c33589953.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc)
	if g:GetCount()>0 then
		local tg=g
		if tg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			Duel.SetTargetCard(tg)
			Duel.HintSelection(g)
	end
end
end
