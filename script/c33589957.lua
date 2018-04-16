--Charmers Possessed
--scripted by GameMaster(GM)
function c33589957.initial_effect(c)
--Activate
	local e0=Effect.CreateEffect(c)
	e0:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	e0:SetTarget(c33589957.target)
	e0:SetOperation(c33589957.activate)
	c:RegisterEffect(e0)
--atk/def Up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xc0))
	e1:SetValue(400)
	c:RegisterEffect(e1)
	--change attribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c33589957.con)
	e2:SetTarget(c33589957.attg2)
	e2:SetOperation(c33589957.atop2)
	c:RegisterEffect(e2)	
end
	
function c33589957.cfilter2(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
	
function c33589957.filter89(c)
	return c:IsFacedown() and (c:IsDefensePos() and c:IsType(TYPE_MONSTER))
end	
	
function c33589957.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c33589957.cfilter2,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c33589957.cfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
		
function c33589957.attg2(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) and Duel.IsExistingTarget(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and e:GetHandler():GetFlagEffect(33589957)==0 end
	e:GetHandler():RegisterFlagEffect(33589957,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)	
end
function c33589957.atop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,562)
		local rc=Duel.AnnounceAttribute(tp,1,0xffff-tc:GetAttribute())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(rc)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		end
Duel.BreakEffect()		
local g=Duel.SelectTarget(tp,c33589957.filter89,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)	
	local tc=g:GetFirst()
if tc then 
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
		end
end


function c33589957.afilter(c)
	return c:IsType(TYPE_TRAP) and (c:IsAbleToHand() and c:IsCode(25704359))
end	
	
function c33589957.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function c33589957.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c33589957.afilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		end
end