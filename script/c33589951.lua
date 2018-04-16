--Impact Revive
--scripted by GameMaster(GM)
function c33589951.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c33589951.condition)
	e1:SetTarget(c33589951.target)
	e1:SetOperation(c33589951.activate)
	e1:SetHintTiming(TIMING_BATTLE_END)
	c:RegisterEffect(e1)
end
function c33589951.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c33589951.filter(c,e,tp,tid)
	return bit.band(c:GetReason(),REASON_BATTLE)~=0 and c:GetTurnID()==tid
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.GetLocationCount(c:GetOwner(),LOCATION_MZONE)>0
end
function c33589951.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c33589951.filter(chkc,e,tp,tid) end
	if chk==0 then return Duel.IsExistingTarget(c33589951.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c33589951.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp,tid)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c33589951.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tc:GetOwner(),tc:GetOwner(),true,false,POS_FACEUP_ATTACK)>0 then
		local e0=Effect.CreateEffect(e:GetHandler())
		e0:SetType(EFFECT_TYPE_SINGLE)
		e0:SetCode(EFFECT_UPDATE_ATTACK)
		e0:SetReset(RESET_EVENT+0x1fe0000)
		e0:SetValue(500)
		tc:RegisterEffect(e0)
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
		e5:SetCondition(c33589951.skipcon)
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
	end
end


function c33589951.skipcon(e)
	return Duel.GetTurnCount()~=e:GetLabel()
end