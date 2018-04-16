--Gorgon's Eye (DOR)
--scripted by GameMaster(GM)
function c33589998.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c33589998.con)
	e1:SetOperation(c33589998.op)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c33589998.con555)
	e2:SetOperation(c33589998.op555)
	e2:SetCountLimit(1)
	c:RegisterEffect(e2)
end

function c33589998.deffilter(c)
	return c:IsPreviousPosition(POS_FACEUP_ATTACK) and c:IsPosition(POS_FACEUP_DEFENSE)
end

function c33589998.con555(e,tp,eg,ep,ev,re,r,rp)
if	Duel.IsExistingMatchingCard(c33589998.deffilter,1-tp,LOCATION_MZONE,0,1,nil) then return true
else return false
end
end

function c33589998.op555(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(Card.IsDefensePos,tp,0,LOCATION_MZONE,nil)
	if tg:GetCount()>0 then
		local tc=tg:GetFirst()
		local c=e:GetHandler()
if tc then
    local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_ATTACK)
		e3:SetReset(RESET_EVENT+0x00040000)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e4:SetReset(RESET_EVENT+0x00040000)
		tc:RegisterEffect(e4)
		local e5=e4:Clone()
		e5:SetCode(EFFECT_DISABLE)
		tc:RegisterEffect(e5)
		Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
       	end
end
end
  
function c33589998.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=eg:Filter(c33589998.cfilter,nil,e)
	Duel.ChangePosition(g,POS_FACEUP_ATTACK)
local tg=Duel.GetMatchingGroup(Card.IsAttackPos,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
while tc do
    local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetReset(RESET_EVENT+0x00040000)
	tc:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetReset(RESET_EVENT+0x00040000)
	tc:RegisterEffect(e2)
	local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_ATTACK)
		e3:SetReset(RESET_EVENT+0x00040000)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e4:SetReset(RESET_EVENT+0x00040000)
		tc:RegisterEffect(e4)
		local e5=e4:Clone()
		e5:SetCode(EFFECT_DISABLE)
		tc:RegisterEffect(e5)
        tc=g:GetNext()
	end
end
end

function c33589998.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousPosition(POS_ATTACK) and c:IsPosition(POS_DEFENSE)
end

function c33589998.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33589998.cfilter,1,nil,1-tp)
end
