--Graveyard Lotto
--scripted by GameMaster(GM)
function c22335504.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e1)
--Graveyard lotto
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33559994,0))
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetCategory(CATEGORY_TOHAND)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_SZONE)
e1:SetCountLimit(1)
e1:SetTarget(c22335504.thtg)
e1:SetOperation(c22335504.thop)
c:RegisterEffect(e1)

end

function c22335504.filter(c,e,tp)
return c:IsFaceup() and c:IsAbleToHand()
end	


function c22335504.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and chkc:IsAbleToHand() end
if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_GRAVE,0,2,nil) end
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end

function c22335504.thop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local g=Duel.GetMatchingGroup(c22335504.filter,tp,LOCATION_GRAVE,0,nil,e,tp)
if g:GetCount()>0 then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=g:RandomSelect(tp,1):GetFirst()
if Duel.SendtoHand(g2,nil,REASON_EFFECT)~=0 then return end
	Duel.ConfirmCards(1-tp,tc)
end
end