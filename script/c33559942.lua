--Mimicat Doppleganger
--scripted by GameMaster (GM)
function c33559942.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetTarget(c33559942.target)
e1:SetOperation(c33559942.activate)
c:RegisterEffect(e1)
end



function c33559942.filter(c,e,tp,eg,ep,ev,re,r,rp)
local ref=c:GetReasonEffect()
if  not c:IsCanBeEffectTarget() then return false end
if c:IsType(TYPE_MONSTER) and Card.IsFaceup then
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
else
	local te=c:GetActivateEffect()
	if not te then return false end
	local cost=te:GetCost()
	local target=te:GetTarget()
	return (not cost or cost(te,tp,eg,ep,ev,re,r,rp,0)) and (not target or target(te,tp,eg,ep,ev,re,r,rp,0))
end
end
function c33559942.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and c33559942.filter(chkc,e,tp,eg,ep,ev,re,r,rp) end
if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_GRAVE+LOCATION_ONFIELD,LOCATION_GRAVE+LOCATION_ONFIELD,1,e:GetHandler(),e,tp,eg,ep,ev,re,r,rp) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_GRAVE+LOCATION_ONFIELD,LOCATION_GRAVE+LOCATION_ONFIELD,1,1,e:GetHandler(),e,tp,eg,ep,ev,re,r,rp)
end
function c33559942.activate(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local tc=Duel.GetFirstTarget()
if not tc or not tc:IsRelateToEffect(e) or not c:IsRelateToEffect(e) then return end
if tc:IsType(TYPE_MONSTER) then
	Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
	c:SetStatus(STATUS_PROC_COMPLETE,true)
	c:SetStatus(STATUS_SPSUMMON_TURN,true)
	c:AddMonsterAttribute(tc:GetType())
	c:AddMonsterAttributeComplete()
	c:SetHint(CHINT_CARD,cardid)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(tc:GetLevel())
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(tc:GetDefense())
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_SET_BASE_ATTACK)
	e3:SetValue(tc:GetAttack())
	c:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CHANGE_RACE)
	e4:SetValue(tc:GetRace())
	c:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e5:SetValue(tc:GetAttribute())
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetRange(LOCATION_MZONE+LOCATION_SZONE)
	e6:SetCode(EFFECT_CHANGE_CODE)
	e6:SetValue(tc:GetOriginalCode())
	c:RegisterEffect(e6)
	c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
	Duel.RaiseSingleEvent(c,EVENT_SPSUMMON_SUCCESS,e,REASON_EFFECT,rp,ep,0)
else
	local te=tc:GetActivateEffect()
	c:SetHint(CHINT_CARD,cardid)
	if not te then return end
	local tpe=tc:GetType()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetValue(tpe+TYPE_TOON)
	e1:SetReset(RESET_EVENT+0x1fc0000)
	c:RegisterEffect(e1)
	if bit.band(tpe,TYPE_FIELD)~=0 then
		local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if of then Duel.Destroy(of,REASON_RULE) end
		of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
		Duel.MoveSequence(c,5)
	end
	Duel.ClearTargetCard()
	local tg=te:GetTarget()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
	if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
		c:CancelToGrave(false)
	else
		c:CancelToGrave(true)
		local code=te:GetHandler():GetOriginalCode()
		c:CopyEffect(code,RESET_EVENT+0x1fc0000,1)
	end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
end
