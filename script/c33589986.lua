--Toy Box
--scripted by GameMaster(GM)
function c33589986.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33589986.tg)
	e1:SetOperation(c33589986.op)
	e1:SetCondition(c33589986.spcon)
	c:RegisterEffect(e1)
end


function c33589986.filter6(c)
return c:IsCode(22222237)
end
function c33589986.spcon(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33589986.filter6,tp,LOCATION_MZONE,0,1,nil) then return false
else return true end
end


--activate
function c33589986.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function c33589986.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
	for i=1,1 do
	local token=Duel.CreateToken(tp,22222237)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
			local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e0:SetCode(EVENT_SPSUMMON_SUCCESS)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCondition(c33589986.con)
	e0:SetTarget(c33589986.rvtg)	
	e0:SetOperation(c33589986.rvop)
	token:RegisterEffect(e0)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1,true)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
			e2:SetValue(1)
			token:RegisterEffect(e2,true)
			local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetDescription(aux.Stringid(60365591,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c33589986.tg2)
	e3:SetOperation(c33589986.op2)
	token:RegisterEffect(e3)
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetValue(c33589986.efilter)
	token:RegisterEffect(e4)
			token:SetStatus(STATUS_NO_LEVEL,true)
			Duel.SpecialSummonComplete()
	end
end
end


function c33589986.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end

function c33589986.filter3(c)
	return c:GetFlagEffect(33589986)
end

function c33589986.op3(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	local ct=e:GetLabelObject():FilterCount(c33589986.filter3,nil)
	if ct==0 then  
	Duel.Destroy(e:GetHandler(),REASON_RULE)
end
end
		
function c33589986.con(e,c)
local c=e:GetHandler()
if c:GetCode()==22222237 then return true
else return false end	
end

function c33589986.rvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33589986.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND+LOCATION_MZONE)
end

function c33589986.rvop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.GetMatchingGroup(c33589986.filter,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=g:Select(tp,1,2,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	local tc=rg:GetFirst()
	while tc do
		tc:RegisterFlagEffect(33589986,RESET_EVENT+0x1fe0000,0,0)
		tc=rg:GetNext()
	end
end

function c33589986.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove() and c:GetCode()~=22222237 and not c:IsType(TYPE_TOKEN)
end
		
		

	
function c33589986.filter2(c,e,tp)
	return c:GetFlagEffect(33589986)~=0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c33589986.tg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c33589986.filter2(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c33589986.filter2,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c33589986.filter2,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end

function c33589986.op2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
	local g=Duel.GetMatchingGroup(c33589986.filter3,tp,LOCATION_REMOVED,0,nil)
	if g:GetCount()==0 then
	local c=e:GetHandler()
	local  token=c:IsCode(22222237)
	Duel.Destroy(c,REASON_EFFECT)
end	
end


	


