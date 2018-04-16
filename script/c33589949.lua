--arcnana Force Wheel of Destiny
--scripted by GameMaster(GM)
function c33589949.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33589949,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c33589949.cointg)
	e1:SetOperation(c33589949.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	end
	
	
function c33589949.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end

	
function c33589949.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local res=0
	if c:IsHasEffect(33589945) or c:IsHasEffect(73206827) then
		res=1-Duel.SelectOption(tp,60,61)
	else res=Duel.TossCoin(tp,1) end
	if res==1 then
		c33589949.arcanareg(c,res)
	else 	
	if res==0 then 
	Duel.GetControl(c,1-tp)
	c33589949.arcanareg(c,res)
end
end
end

function c33589949.arcanareg(c,coin)
	
	--dice
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33589949,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c33589949.con2)
		e2:SetOperation(c33589949.op2)
		e2:SetTarget(c33589949.tg2)
		c:RegisterEffect(e2)
		c:RegisterFlagEffect(36690018,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,coin,63-coin)
	end

	
	
	


function c33589949.filter(c)
return c:IsAbleToHand()
end

function c33589949.con2(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c33589949.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end







function c33589949.op2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local dice=Duel.TossDice(tp,1)
	if dice==1 then
		Duel.Recover(tp,500,REASON_EFFECT)
	elseif dice==2 then
local sg=Duel.GetMatchingGroup(c33589949.filter,tp,LOCATION_DECK,0,nil)
Duel.ConfirmCards(tp,sg)
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local sg=Duel.GetMatchingGroup(c33589949.filter,tp,LOCATION_DECK,0,nil)
local g=sg:Select(tp,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,tp,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
end
	elseif dice==3 then
		Duel.Draw(tp,1,REASON_EFFECT)
		Duel.DiscardDeck(1-tp,1,REASON_EFFECT)
	elseif dice==4 then
		Duel.SetTargetPlayer(1-tp)
		Duel.SetTargetParam(500)
		Duel.Damage(1-tp,500,REASON_EFFECT)
	elseif dice==5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif dice==6 then
		local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_TURN)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
	Duel.SetTargetPlayer(tp)
		Duel.SetTargetParam(1000)
		Duel.Damage(tp,1000,REASON_EFFECT)
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end


