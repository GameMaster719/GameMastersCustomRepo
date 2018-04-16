--Level fish
function c33579967.initial_effect(c)
	--change level 1-9
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33579967,1))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c33579967.tg)
	e1:SetOperation(c33579967.op)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33579967,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c33579967.con)
	e2:SetOperation(c33579967.op2)
	c:RegisterEffect(e2)
end

function c33579967.con(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end

function c33579967.op2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.DiscardDeck(tp,e:GetHandler():GetLevel()*1,REASON_EFFECT)
	Duel.Damage(tp,e:GetHandler():GetLevel()*125,REASON_EFFECT)
end
--Level change target
function c33579967.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end

function c33579967.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end

--Level change operation
function c33579967.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c33579967.filter,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
	local t={}
		local i=1
		local p=1
		local lv=tc:GetLevel()
		for i=1,9 do 
			if lv~=i then t[p]=i p=p+1 end
		end
		t[p]=nil
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33579967,0))
		local ac=Duel.AnnounceNumber(tp,table.unpack(t))
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(ac)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
