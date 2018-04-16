--Homunculus-LUST
function c335599102.initial_effect(c)
	--update attack to +2100
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c335599102.condtion)
	e1:SetValue(c335599102.val)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	-- Cannot Banish (Loyalty to controller)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_CANNOT_REMOVE)
	e3:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e3)
	--control
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	c:RegisterEffect(e4)
	-- indes
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e5:SetCountLimit(2)
	e5:SetValue(c335599102.valcon)
	c:RegisterEffect(e5)
	--to grave
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetOperation(c335599102.regop2)
	c:RegisterEffect(e6)
end

function c335599102.regop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_DESTROY) and bit.band(c:GetPreviousLocation(),LOCATION_ONFIELD)~=0 then
		--spsummon
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(335599102,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCost(c335599102.spcost)
		e1:SetTarget(c335599102.sptg)
		e1:SetOperation(c335599102.spop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end

function c335599102.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(335599102)==0 end
	c:RegisterFlagEffect(335599102,nil,0,1)
end

function c335599102.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c335599102.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	 Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end


function c335599102.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c335599102.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL
end
function c335599102.val(e,c)
	if Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil then return 2100
	elseif e:GetHandler()==Duel.GetAttackTarget() then return -0
	else return 0 end
end
