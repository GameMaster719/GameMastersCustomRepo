--Smog of Ferngully
--scripted by GameMaster(GM)
function c33579940.initial_effect(c)
      --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCost(c33579940.cost)
    e1:SetTarget(c33579940.target)
    e1:SetOperation(c33579940.activate)
    c:RegisterEffect(e1)
end

function c33579940.regop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c33579940.filter,1,nil,1-tp) then
		c33579940[1-tp]=true
	end
end

function c33579940.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckLPCost(tp,1000) end
    Duel.PayLPCost(tp,1000)
end
function c33579940.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_HAND) and c33579940.filter(chkc,e) end
	if chk==0 then 
		local g=Duel.GetMatchingGroup(c33579940.filter,tp,0,LOCATION_HAND,nil,e)
		return g:IsExists(c33579940.filter1,1,nil,g) 
		end
	local g=Duel.GetMatchingGroup(c33579940.filter,tp,0,LOCATION_HAND,nil,e)	
	local rg=g:Filter(c33579940.filter1,nil,g)
	local tc=rg:GetFirst()
	local att=0
	while tc do
		att=bit.bor(att,tc:GetAttribute())
		tc=rg:GetNext()
	end
	local ac=Duel.AnnounceAttribute(tp,1,0xffff)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end


function c33579940.filter(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e) and c:IsAbleToGrave()
end
function c33579940.filter1(c,g)
	return g:IsExists(Card.IsAttribute,1,c,c:GetAttribute())
end

function c33579940.activate(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(Card.IsAttribute,tp,0,LOCATION_HAND,nil,ac)
	local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,hg)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
		Duel.ShuffleHand(1-tp)
		end
		end
		
