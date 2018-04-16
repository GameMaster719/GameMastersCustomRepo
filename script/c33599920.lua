--Spell calling (Anime)
--scripted by GameMaster(GM)
function c33599920.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33599920,0))
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c33599920.setcon)
	e1:SetTarget(c33599920.settg)
	e1:SetOperation(c33599920.setop)
	c:RegisterEffect(e1)
end
function c33599920.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(r,0x41)==0x41 and rp~=tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and c:GetPreviousControler()==tp
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEDOWN)
end
function c33599920.filter(c)
	return c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c33599920.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		and Duel.IsExistingMatchingCard(c33599920.filter,tp,LOCATION_DECK,0,2,nil) end
end
function c33599920.setop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c33599920.filter,tp,LOCATION_DECK,0,2,2,nil)
			Duel.SSet(tp,g)
		end



