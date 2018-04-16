--Surprise Attack from Beyond
--scripted by GameMaster (GM)
function c33589950.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c33589950.activate)
	e1:SetCondition(c33589950.con2323)
	c:RegisterEffect(e1)
end
function c33589950.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_TURN)
	e1:SetTargetRange(0,1)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)
    local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	e5:SetCode(EFFECT_SKIP_DP)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_BATTLE then
		e5:SetCondition(c33589950.skipcon)
		e5:SetLabel(Duel.GetTurnCount())
		e5:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN,2)
	else
		e5:SetReset(RESET_PHASE+PHASE_BATTLE+RESET_SELF_TURN)
	end
	Duel.RegisterEffect(e5,tp)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_SKIP_SP)
	Duel.RegisterEffect(e6,tp)
	local e7=e6:Clone()
	e7:SetCode(EFFECT_SKIP_M1)
	Duel.RegisterEffect(e7,tp)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_EP)
	e8:SetTargetRange(1,0)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_MAIN1 then
		e8:SetReset(RESET_PHASE+PHASE_MAIN1,2)
	else
		e8:SetReset(RESET_PHASE+PHASE_MAIN1)
	end
	Duel.RegisterEffect(e8,tp)
	local e9=e8:Clone()
	e9:SetCode(EFFECT_SKIP_M2)
	Duel.RegisterEffect(e9,tp)
	local e10=Effect.CreateEffect(e:GetHandler())
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e10:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e10:SetReset(RESET_PHASE+PHASE_BATTLE)
	e10:SetCountLimit(1)
	e10:SetOperation(c33589950.operation)
	Duel.RegisterEffect(e10,tp)
end

function c33589950.skipcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end

function c33589950.con2323(e,tp,eg,ep,ev,re,r,rp)

	return Duel.GetCurrentPhase()==PHASE_MAIN2 
end


function c33589950.filter(c,e,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c33589950.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,33589950)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c33589950.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c33589950.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp)
		local tc=g:GetFirst()
		if tc and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		if  tc:GetOriginalCode()==66600 then 
		local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_CANNOT_TO_GRAVE)
	e0:SetReset(RESET_EVENT+0x1fe0000)
	e0:SetValue(c33589950.efilter)
	tc:RegisterEffect(e0,true)
	end
	Duel.SpecialSummonComplete()
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCode(EFFECT_CANNOT_M2)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_BATTLE then
	e1:SetCondition(c33589950.skipcon)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		end
		Duel.RegisterEffect(e1,tp)
	end
end




function c33589950.efilter(e,re,rp,c)
return re:GetHandler()==c
end

