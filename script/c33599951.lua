--Barrel Dragon (DOR)
--scripted by GameMaster (GM)
function c33599951.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_FLIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c33599951.target)
	e1:SetOperation(c33599951.activate)
	c:RegisterEffect(e1)
end


function c33599951.filter(c)
    return c:IsType(0xfff) and c:GetCode()~=33599941 and c:GetCode()~=33599942--not the rose cards
  end


function c33599951.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local oppmonNum = Duel.GetMatchingGroupCount(c33599951.filter,nil,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local s1=math.min(oppmonNum,oppmonNum)
	if chk==0 then return Duel.IsExistingTarget(c33599951.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())  end
	local g=Duel.GetMatchingGroup(c33599951.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if g:GetCount()>0  then
		local tg=g
		if tg:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			Duel.SetTargetCard(tg)
			Duel.HintSelection(g)
	end
	end
end


function c33599951.activate(e,tp,eg,ep,ev,re,r,rp)
local oppmonNum = Duel.GetMatchingGroupCount(c33599951.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	local s1=math.min(oppmonNum,oppmonNum)
	local g=Duel.GetMatchingGroup(c33599951.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if g:GetCount()>0 then
	local sg=g:RandomSelect(tp,1)
		Duel.Destroy(sg,REASON_EFFECT)
        Duel.ConfirmCards(tp,sg)
end
end





