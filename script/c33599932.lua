--ミレニアム・アイズ・イリュージョニスト
--Millennium-Eyes Illusionist
--by Eerie + GameMaster(GM)
function c33599932.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33599932,1))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,33599932)
	e1:SetCost(c33599932.eqcost)
	e1:SetTarget(c33599932.eqtg)
	e1:SetOperation(c33599932.eqop)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33599932,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,33599932+100)
	e2:SetCondition(c33599932.thcon)
	e2:SetTarget(c33599932.thtg)
	e2:SetOperation(c33599932.thop)
	c:RegisterEffect(e2)
end
function c33599932.eqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c33599932.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_EFFECT) and c:IsAbleToChangeControler()
end

function c33599932.eqfilter(c)
	return c:IsFaceup() and  c:IsCode(64631466) or c:IsCode(63519819) or (c:IsSetCard(0x20a) and c:IsType(TYPE_FUSION))
end	
	
	
function c33599932.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c33599932.eqfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end


function c33599932.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c33599932.eqfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc2=g:GetFirst()
	if not tc2 then return end
	if tc1:IsFaceup() and tc1:IsRelateToEffect(e) and tc1:IsControler(1-tp) then
	if Duel.Equip(tp,tc1,tc2,true) then
		--Add Equip limit
		local e1=Effect.CreateEffect(tc1)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetLabelObject(tc1)
		e1:SetValue(c33599932.eqlimit)
		tc1:RegisterEffect(e1)
	local atk=tc1:GetTextAttack()
	local def=tc1:GetTextDefense()
	if atk>0 then
		local e2=Effect.CreateEffect(tc1)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(atk)
		tc1:RegisterEffect(e2)	
	if def>0 then
	local e2=Effect.CreateEffect(tc1)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(def)
		tc1:RegisterEffect(e2)	
end
end
end
end
end

function c33599932.eqlimit(e,c)
	return e:GetOwner()~=c
end

function c33599932.thfilter(c,e)
	return (c:IsSetCard(0x20a) and c:IsType(TYPE_FUSION)) or c:IsCode(64631466) or c:IsCode(63519819)
end

function c33599932.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33599932.thfilter,1,nil)
end

function c33599932.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end

function c33599932.thop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	end
end
