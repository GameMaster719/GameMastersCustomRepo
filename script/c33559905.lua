--Orichalcos Matia
--scripted by GameMaster(GM)
function c33559905.initial_effect(c)
	--add one card to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetTarget(c33559905.target)
	e1:SetOperation(c33559905.activate)
	e1:SetCost(c33559905.cost)
	e1:SetCountLimit(1,33559905+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
end


function c33559905.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800)
	else Duel.PayLPCost(tp,800)	end
end


function c33559905.afilter(c)
	return c:IsType(TYPE_TRAP+TYPE_SPELL+TYPE_MONSTER) and (c:IsSetCard(0x5d) and c:IsAbleToHand())
end
function c33559905.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33559905.afilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c33559905.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c33559905.afilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		end
end
