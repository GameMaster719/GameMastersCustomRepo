--arcnana force vii－THE CHARIOT anime
--scripted by GameMaster(GM)
function c33589944.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33589944,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c33589944.cointg)
	e1:SetOperation(c33589944.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	
	
end
	
function c33589944.con4(e,tp,eg,ep,ev,re,r,rp)
return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)and e:GetHandler():IsReason(REASON_BATTLE)
end



function c33589944.filter(c,tid)
	return c:IsCode(33589944) and c:GetTurnID()==tid and c:IsReason(REASON_BATTLE) and c:GetFlagEffectLabel(33589944)==0
end
	
function c33589944.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end

function c33589944.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local res=0
	if c:IsHasEffect(73206827) then
		res=1-Duel.SelectOption(tp,60,61)
	else res=Duel.TossCoin(tp,1) end
if res==1 then 
	c33589944.arcanareg(c,res)
else
c33589944.arcanareg2(c,res)
end
end


function c33589944.arcanareg(c,coin)
	--coin effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33589944,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c33589944.spcon)
	e1:SetTarget(c33589944.sptg)
	e1:SetOperation(c33589944.spop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)	
	e2:SetOperation(c33589944.ctop)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	c:RegisterFlagEffect(36690018,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,coin,63-coin)
	c:RegisterFlagEffect(33589944,0,0,1,coin)
end

function c33589944.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--heads
	if c:GetFlagEffectLabel(36690018)==1 and c:GetFlagEffectLabel(33589944)==1 then
		c:SetFlagEffectLabel(36690018,0)
	end
	--tails
	if c:GetFlagEffectLabel(36690018)==0 and c:GetFlagEffectLabel(33589944)==0 then
		c:SetFlagEffectLabel(36690018,1)
	end
end



function c33589944.arcanareg2(c,coin)
	--reg
	local e2=Effect.CreateEffect(c)
    e2:SetCode(EVENT_BATTLE_DESTROYED)
    e2:SetType(EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_SINGLE_RANGE)
    e2:SetTarget(c33589944.reptg)
	e2:SetOperation(c33589944.repop)
   	e2:SetCondition(c33589944.con4)
    c:RegisterEffect(e2)
	--spsummon
		local e4=Effect.CreateEffect(c)
		e4:SetDescription(aux.Stringid(33589944,0))
		e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e4:SetCode(EVENT_BATTLE_DESTROYED)
		e4:SetTarget(c33589944.sptg2)
		e4:SetOperation(c33589944.spop2)
		e4:SetCountLimit(1)
		c:RegisterEffect(e4)
	c:RegisterFlagEffect(36690018,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,coin,63-coin)	
end
function c33589944.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
  if  e:GetHandler():IsRelateToEffect(e) then end	 
	c:RegisterFlagEffect(33589944,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
end



function c33589944.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    if chk==0 then return  c:IsReason(REASON_BATTLE) end
    return true
end

function c33589944.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c33589944.spop2(e,tp,eg,ep,ev,re,r,rp)
 local c=e:GetHandler()
  if  e:GetHandler():IsRelateToEffect(e) then
        local np=e:GetHandler():GetPreviousControler()
		Duel.SpecialSummon(c,0,1-np,1-np,false,false,POS_FACEUP)
		e:GetHandler():ResetFlagEffect(33589944)
	end
end

function c33589944.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetFlagEffectLabel(36690018)==1 and c:IsRelateToBattle() and c:IsStatus(STATUS_OPPO_BATTLE)
end

function c33589944.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and tc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
end

function c33589944.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
end