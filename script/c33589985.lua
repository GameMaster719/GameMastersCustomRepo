--Twin-Bow Centaur (Anime)
--scripted by GameMaster (GM)
function c33589985.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Destruction
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33589985,0))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetTarget(c33589985.target)
	e2:SetCost(c33589985.cost)
	e2:SetOperation(c33589985.desop)
	e2:SetCondition(c33589985.con22)
	c:RegisterEffect(e2)
		
end

function c33589985.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()==PHASE_MAIN1 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end

function c33589985.con22(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_MZONE,0,1,nil)  and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) and Duel.GetCurrentPhase()==PHASE_MAIN1 then return true
else return false end
end


function c33589985.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33589985,1))
	local g1=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33589985,2))
	local g2=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil) 
	e:SetLabelObject(g1:GetFirst())
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,2,0,0)
	
end

function c33589985.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if g:GetCount()>1 then
	local sg=g:RandomSelect(tp,1)
 if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)then
 local bc=sg:GetFirst()
if bc:GetPreviousControler()==1-tp then
 local c=e:GetHandler()
 local ATK=sg:GetSum(Card.GetAttack)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ATK)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,c:GetPreviousControler(),ATK)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
else if	bc:GetPreviousControler()==tp then
 local c=e:GetHandler()
 local ATK=sg:GetSum(Card.GetAttack)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ATK)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,c:GetPreviousControler(),ATK)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
	end
	end
	end
	
	local sk=Duel.GetTurnPlayer()
    Duel.BreakEffect()
	Duel.SkipPhase(sk,PHASE_MAIN1,PHASE_END+RESET_SELF_TURN,0,1)
	Duel.SkipPhase(sk,PHASE_BATTLE,PHASE_END+RESET_SELF_TURN,0,1)
    Duel.SkipPhase(sk,PHASE_MAIN2,PHASE_END+RESET_SELF_TURN,0,1)
    Duel.SkipPhase(sk,PHASE_END,PHASE_END+RESET_SELF_TURN,0,1)
	end
	end
	






