--Dragon Piper (Anime)
function c33589911.initial_effect(c)
   --summon eff 
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
    e1:SetCondition(c33589911.con)
	e1:SetTarget(c33589911.mttarget)
    e1:SetOperation(c33589911.op)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    c:RegisterEffect(e2)
    local e3=e1:Clone()
    e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    c:RegisterEffect(e3)
end

function c33589911.filter2(c)
	return c:GetCode(50045299)
end

function c33589911.mttarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler()
		and Duel.IsExistingTarget(Card.IsCode,tp,LOCATION_MZONE,0,1,nil,50045299) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsCode,tp,LOCATION_MZONE,0,1,1,nil,50045299)
end

function c33589911.con(e,c)
	return Duel.IsExistingMatchingCard(c33589911.filter2,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil,50045299)
end
function c33589911.op(e,tp,eg,ep,ev,re,r,rp,chk)	
	local g=Duel.GetOverlayGroup(tp,1,1)
	if g:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			local sg=g:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,nil,tp,tp,true,false,POS_FACEUP)
		local tc=sg:GetFirst()
		end
end		

