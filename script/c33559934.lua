--Different Dimension Dragon (Anime)
--scripted by GameMaster(GM)
function c33559934.initial_effect(c)
--special summon from grave when destroyed by battle
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_TO_GRAVE)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetTarget(c33559934.sptg)
e1:SetOperation(c33559934.spop)
e1:SetCondition(c33559934.con1)
e1:SetLabelObject(e1)
c:RegisterEffect(e1)

--cannot be destroyed in battle by 1900ATk or <
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
e3:SetValue(c33559934.value)
c:RegisterEffect(e3)
end

-----------------------------


function c33559934.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if  rp==tp or c:GetPreviousControler()~=tp then return end
	if Duel.GetTurnPlayer()==tp  then
		e:SetLabel(Duel.GetTurnCount())
		c:RegisterFlagEffect(33559934,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
		--end battle phase
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33559934,0))
e1:SetType(EFFECT_TYPE_QUICK_O)
e1:SetHintTiming(TIMING_BATTLE_PHASE+TIMING_END_PHASE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetRange(LOCATION_GRAVE)
e1:SetCondition(c33559934.spcon)
e1:SetTarget(c33559934.sptg)
e1:SetOperation(c33559934.op)
e1:SetValue(1)
e1:SetReset(RESET_PHASE+PHASE_END)
c:RegisterEffect(e1)
end
end




function c33559934.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local c=e:GetHandler()
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
c:ResetFlagEffect(33559934)
end


function c33559934.op(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) then 
Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
end

function c33559934.spcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return  c:GetFlagEffect(33559934)>0
end


-------------------------------
function c33559934.value(e,c)
return c:IsAttackBelow(1900)
end

function c33559934.con1(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
return c:IsReason(REASON_EFFECT) and rp~=tp and c:GetPreviousControler()==tp
and c:IsPreviousLocation(LOCATION_ONFIELD)
end





