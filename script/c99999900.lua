--Schitzotrakzit
--scripted by GameMaster(GM)
function c99999900.initial_effect(c)
 --summon effect destroys all other monsters you control
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c99999900.sptg)
    e1:SetOperation(c99999900.spop)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    c:RegisterEffect(e3)
--While on the field cannot normal summon effect monsters 	
	local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_CANNOT_SUMMON)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetTargetRange(LOCATION_HAND,0)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_EFFECT))
    e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c99999900.con)
    c:RegisterEffect(e4)
--removed required
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_REMOVE)
	e5:SetOperation(c99999900.rmop)
	c:RegisterEffect(e5)
--special summon from bansied zone
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_REMOVED)
	e5:SetCondition(c99999900.con653)
	e5:SetTarget(c99999900.tg653)
	e5:SetOperation(c99999900.op653)
	c:RegisterEffect(e5)
	--Destroy a spell on stadbyphase
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_REPEAT+EFFECT_FLAG_CARD_TARGET)
	e6:SetCondition(c99999900.con6666)
	e6:SetCountLimit(1)
	e6:SetTarget(c99999900.destg)
	e6:SetOperation(c99999900.desop)
	c:RegisterEffect(e6)
--Destroy 1 your spells/one card of opponents
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetCountLimit(1)
	e7:SetRange(LOCATION_MZONE)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetCategory(CATEGORY_DESTROY)
	e7:SetTarget(c99999900.destg7)
	e7:SetOperation(c99999900.desop7)
	c:RegisterEffect(e7)
end


function c99999900.destg7(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_SZONE,0,1,nil)
		and Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c99999900.desop7(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end


function c99999900.con6666(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end

function c99999900.desfilter(c)
	return c:IsDestructable() and c:IsFaceup()
end
function c99999900.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local turnp=Duel.GetTurnPlayer()
	if chkc then return chkc:IsControler(turnp) and chkc:IsLocation(LOCATION_ONFIELD) and c99999900.desfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(turnp,c99999900.desfilter,turnp,LOCATION_ONFIELD,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end

function c99999900.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
		local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end


function c99999900.rmop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsFacedown() then return end
	e:GetHandler():RegisterFlagEffect(99999900,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end

function c99999900.con653(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(99999900)~=0
end

function c99999900.tg653(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(99999900)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,tp,LOCATION_REMOVED)
	e:GetHandler():RegisterFlagEffect(99999900,RESET_PHASE+PHASE_END,0,1)
end

function c99999900.op653(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
if Duel.SendtoHand (c,nil,REASON_EFFECT) then 
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local sg=Duel.GetMatchingGroup(c99999900.oppthfilter,tp,LOCATION_DECK,0,nil)
local g=sg:Select(tp,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,tp,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
end
end
end 
end

function c99999900.oppthfilter(c)
return c:IsType(TYPE_SPELL) and c:IsAbleToHand() 
end


function c99999900.con(e,c)
local c=e:GetHandler()
	return not c:IsType(TYPE_NORMAL)
end

function c99999900.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
    Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end

function c99999900.spop(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if c:IsRelateToEffect(e)  then
        local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,c)
        Duel.Destroy(g,REASON_EFFECT)
    end
end