--Starfish (Anime)
--scripted by GameMaster(GM)
function c33599918.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33599918,2))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c33599918.target)
	e1:SetOperation(c33599918.operation)
	c:RegisterEffect(e1)
	--lv change 2 starfish
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33599918,3))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c33599918.con2)
	e2:SetTarget(c33599918.target)
	e2:SetOperation(c33599918.operation)
	c:RegisterEffect(e2)
	--lv change 3 starfish
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33599918,4))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c33599918.con3)
	e3:SetTarget(c33599918.target)
	e3:SetOperation(c33599918.operation)
	c:RegisterEffect(e3)
	--lv change 4 starfish
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33599918,5))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c33599918.con4)
	e4:SetTarget(c33599918.target)
	e4:SetOperation(c33599918.operation)
	c:RegisterEffect(e4)
	--lv change 5 starfish
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(33599918,6))
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(c33599918.con5)
	e5:SetTarget(c33599918.target)
	e5:SetOperation(c33599918.operation)
	c:RegisterEffect(e5)
end




function c33599918.filter(c)
	return c:IsCode(44717069)
end


function c33599918.con2(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33599918.filter,tp,LOCATION_MZONE,0,2,nil) then return true
else return false end
end




function c33599918.con3(e,tp,eg,ep,ev,re,r,rp)
   if Duel.IsExistingMatchingCard(c33599918.filter,tp,LOCATION_MZONE,0,3,nil) then return true
else return false end
end


function c33599918.con4(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsExistingMatchingCard(c33599918.filter,tp,LOCATION_MZONE,0,4,nil) then return true
else return false end
end

function c33599918.con5(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsExistingMatchingCard(c33599918.filter,tp,LOCATION_MZONE,0,5,nil) then return true
else return false end
end


 


function c33599918.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33599918.filter(chkc,e,tp) end
	if chk==0 then return e:GetHandler() end
	local c=e:GetHandler()
	local op=0
	if c:GetLevel()==1 then op=Duel.SelectOption(tp,aux.Stringid(33599918,0))
	else op=Duel.SelectOption(tp,aux.Stringid(33599918,0),aux.Stringid(33599918,1)) end
	e:SetLabel(op)
	Duel.RegisterFlagEffect(tp,33599918,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
end



function c33599918.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		if e:GetLabel()==0 then
			e1:SetValue(1)
		else e1:SetValue(-1) end
		c:RegisterEffect(e1)
	end
end
