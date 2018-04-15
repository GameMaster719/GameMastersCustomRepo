--Monster Bash
--scripted by GameMaster(GM)
function c22335501.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c22335501.op)
	e1:SetTarget(c22335501.tg)
	c:RegisterEffect(e1)
end


function c22335501.filter(c)
	return c:IsType(TYPE_MONSTER) 
end

function c22335501.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsExistingMatchingCard(c22335501.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end

function c22335501.op(e,tp,eg,ep,ev,re,r,rp)
repeat
Duel.Draw(tp,1,REASON_EFFECT)
local g=Duel.GetOperatedGroup():GetFirst()
Duel.ConfirmCards(tp,g)
if g:IsType(TYPE_SPELL+TYPE_TRAP) then
Duel.Damage(tp,500,REASON_EFFECT)
end
until g:IsType(TYPE_MONSTER) end
