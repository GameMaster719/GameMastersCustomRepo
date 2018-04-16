--Counterbalance
--scripted by GameMaster(GM)
function c33579950.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--discard opp deck
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetDescription(aux.Stringid(33579950,1))
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetCountLimit(1)
	e2:SetCondition(c33579950.discon)
	e2:SetTarget(c33579950.target)
	e2:SetOperation(c33579950.activate)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--discard your deck
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCategory(CATEGORY_DECKDES)
	e3:SetDescription(aux.Stringid(33579950,1))
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCountLimit(1)
	e3:SetCondition(c33579950.discon3)
	e3:SetTarget(c33579950.target3)
	e3:SetOperation(c33579950.activate3)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)	
	--discard opp deck if dolls 
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCategory(CATEGORY_DECKDES)
	e4:SetDescription(aux.Stringid(33579950,1))
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_REPEAT)
	e4:SetCountLimit(1)
	e4:SetCondition(c33579950.discon4)
	e4:SetTarget(c33579950.target4)
	e4:SetOperation(c33579950.activate4)
	e4:SetLabelObject(e1)
	c:RegisterEffect(e4)
	--discard your deck if dolls
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCategory(CATEGORY_DECKDES)
	e5:SetDescription(aux.Stringid(33579950,1))
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_SZONE)
	e5:SetProperty(EFFECT_FLAG_REPEAT)
	e5:SetCountLimit(1)
	e5:SetCondition(c33579950.discon5)
	e5:SetTarget(c33579950.target5)
	e5:SetOperation(c33579950.activate5)
	e5:SetLabelObject(e1)
	c:RegisterEffect(e5)	
end

--opponents
function c33579950.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp  and not Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_CANNOT_DISCARD_DECK) 
end

function c33579950.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33579950.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetMatchingGroupCount(c33579950.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*1
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,dam)
end
function c33579950.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(c33579950.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*1
	Duel.DiscardDeck(1-tp,dam,REASON_EFFECT)
	
	
end

function c33579950.discon4(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c33579950.dollfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) and Duel.GetTurnPlayer()~=tp  and not Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_CANNOT_DISCARD_DECK)  then return true
else return false end
		return Duel.GetTurnPlayer()~=tp 
end

function c33579950.target4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33579950.filter2,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetMatchingGroupCount(c33579950.filter2,tp,LOCATION_GRAVE,0,nil)*1
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,dam)
end
function c33579950.activate4(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(c33579950.filter2,tp,LOCATION_GRAVE,0,nil)*1
	Duel.DiscardDeck(1-tp,dam,REASON_EFFECT)
	
	
end



--self





function c33579950.discon3(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp  and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_DISCARD_DECK) 
	end

function c33579950.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33579950.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.SetTargetPlayer(tp)
	local dis=Duel.GetMatchingGroupCount(c33579950.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*1
	Duel.SetTargetParam(dis)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,dis)
end
function c33579950.activate3(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dis=Duel.GetMatchingGroupCount(c33579950.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)*1
	Duel.DiscardDeck(tp,dis,REASON_EFFECT)
	
	
end



function c33579950.filter2(c)
	return c:IsType(TYPE_MONSTER) and c:GetCode()~=22222234
end


function c33579950.discon5(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsExistingMatchingCard(c33579950.dollfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) and Duel.GetTurnPlayer()==tp  and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_DISCARD_DECK)  then return true
else return false end
	return Duel.GetTurnPlayer()==tp 
end

function c33579950.target5(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33579950.filter2,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.SetTargetPlayer(tp)
	local dis=Duel.GetMatchingGroupCount(c33579950.filter2,tp,0,LOCATION_GRAVE,nil)*1
	Duel.SetTargetParam(dis)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,dis)
end
function c33579950.activate5(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dis=Duel.GetMatchingGroupCount(c33579950.filter2,tp,0,LOCATION_GRAVE,nil)*1
	Duel.DiscardDeck(tp,dis,REASON_EFFECT)
end

--------------------------------



function c33579950.dollfilter(c)
	return c:IsFaceup() and c:GetOriginalCode()==33579949
end









