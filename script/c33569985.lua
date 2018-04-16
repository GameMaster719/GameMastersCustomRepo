--Tartarus - Persona Zone
function c33569985.initial_effect(c)
--Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)  
--discard opp deck
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e2:SetCategory(CATEGORY_DECKDES)
    e2:SetDescription(aux.Stringid(33569985,1))
    e2:SetCode(EVENT_PHASE+PHASE_END)
    e2:SetRange(LOCATION_FZONE)
    e2:SetProperty(EFFECT_FLAG_REPEAT)
    e2:SetCountLimit(1)
    e2:SetCondition(c33569985.discon)
    e2:SetTarget(c33569985.target)
    e2:SetOperation(c33569985.activate)
    e2:SetLabelObject(e1)
    c:RegisterEffect(e2)
    --discard your deck
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e3:SetCategory(CATEGORY_DECKDES)
    e3:SetDescription(aux.Stringid(33569985,1))
    e3:SetCode(EVENT_PHASE+PHASE_END)
    e3:SetRange(LOCATION_FZONE)
    e3:SetProperty(EFFECT_FLAG_REPEAT)
    e3:SetCountLimit(1)
    e3:SetCondition(c33569985.discon2)
    e3:SetTarget(c33569985.target2)
    e3:SetOperation(c33569985.activate2)
    e3:SetLabelObject(e1)
    c:RegisterEffect(e3)   
--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x315))
	e4:SetValue(1000)
	c:RegisterEffect(e4)	
end

function c33569985.discon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp
end

function c33569985.target(e,tp,eg,ep,ev,re,r,rp,chk)
   	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_MZONE)
end
function c33569985.activate(e,tp,eg,ep,ev,re,r,rp)
    local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,LOCATION_MZONE,0)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	Duel.ShuffleDeck(p)
end

function c33569985.discon2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()~=tp
end

function c33569985.target2(e,tp,eg,ep,ev,re,r,rp,chk)
   	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,1-tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,1-tp,LOCATION_MZONE)
end
function c33569985.activate2(e,tp,eg,ep,ev,re,r,rp)
    local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,LOCATION_MZONE,0)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
	Duel.ShuffleDeck(p)
end
