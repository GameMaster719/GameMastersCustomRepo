--Ultimecia
--scripted by GameMaster(GM)
function c33579906.initial_effect(c)
    aux.EnablePendulumAttribute(c,true)
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	c:RegisterEffect(e1)
	--Remove Attribute monster
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c33579906.target)
	e2:SetOperation(c33579906.operation)
	c:RegisterEffect(e2)
end
function c33579906.filter(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e) and c:IsAbleToRemove()
end
function c33579906.filter1(c,g)
	return g:IsExists(Card.IsAttribute,1,c,c:GetAttribute())
end
function c33579906.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c33579906.filter(chkc,e) end
	if chk==0 then 
		local g=Duel.GetMatchingGroup(c33579906.filter,tp,0,LOCATION_GRAVE,nil,e)
		return g:IsExists(c33579906.filter1,1,nil,g) 
		end
	local g=Duel.GetMatchingGroup(c33579906.filter,tp,0,LOCATION_GRAVE,nil,e)	
	local rg=g:Filter(c33579906.filter1,nil,g)
	local tc=rg:GetFirst()
	local att=0
	while tc do
		att=bit.bor(att,tc:GetAttribute())
		tc=rg:GetNext()
	end
	local ac=Duel.AnnounceAttribute(tp,1,att)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local sg=rg:FilterSelect(tp,Card.IsAttribute,1,1,nil,ac)
	Duel.SetTargetCard(sg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,1,0,0)
end


	

function c33579906.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
end
