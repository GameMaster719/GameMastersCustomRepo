--Dark Sanctuary
--Scripted by GameMaster(GM)
function c335599128.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--maintain
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c335599128.mtcon)
	e2:SetOperation(c335599128.mtop)
	c:RegisterEffect(e2)
	--move to field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c335599128.spcon)
	e3:SetCost(c335599128.spcost)
	e3:SetTarget(c335599128.sptg)
	e3:SetOperation(c335599128.spop)
	c:RegisterEffect(e3)
end

function c335599128.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c335599128.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckReleaseGroup(tp,nil,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(335599128,0)) then
		local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
		Duel.Release(sg,REASON_COST)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
function c335599128.chainreg(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(335599128)==0 then
		e:GetHandler():RegisterFlagEffect(335599128,RESET_EVENT+0x1fc0000+RESET_CHAIN,0,1)
	end
end

function c335599128.spfil(c,tc)
	return c:IsFaceup() and c:IsCode(31893528,67287533,94772232,30170981) and c:GetTurnID()==tc
end
function c335599128.spcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	--return rp==tp and rc:IsCode(94212438) and e:GetHandler():GetFlagEffect(335599128)>0 and Duel.IsExistingMatchingCard(c335599128.spfil,tp,LOCATION_SZONE,0,1,nil,Duel.GetTurnCount())
	if rp~=tp then
		--Debug.Message("Effect activated by another player.")
		return false
	elseif not rc:IsCode(94212438) then
		--Debug.Message("Not Destiny Board.")
		return false
	elseif not Duel.IsExistingMatchingCard(c335599128.spfil,tp,LOCATION_SZONE,0,1,nil,Duel.GetTurnCount()) then
		--Debug.Message("No Spirit Message placed.")
		return false
	else return true end
end
function c335599128.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(335599128+1)==0 end
	c:RegisterFlagEffect(335599128+1,RESET_CHAIN,0,1)
end
function c335599128.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c335599128.spfil,tp,LOCATION_SZONE,0,nil,Duel.GetTurnCount())
	local tc=g:GetFirst()
	if chk==0 then
		--return tc and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,0x11,0,0,1,RACE_FIEND,ATTRIBUTE_DARK)
		if not tc then
			return false
		elseif Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then
			--Debug.Message("No space.")
			return false
		elseif not Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,0x11,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then
			--Debug.Message("Can't be Special Summoned.")
			return false
		else return true end
	end
	e:SetLabelObject(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
end
function c335599128.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=e:GetLabelObject()
	--if not tc or not tc:IsRelateToEffect(e) then return end
	if not tc then 
		--Debug.Message("No summonable card.")
		return
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,0x11,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then
		--Debug.Message("Enters this section.")
		tc:SetStatus(STATUS_NO_LEVEL,false)
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(TYPE_NORMAL+TYPE_MONSTER)
		e1:SetReset(RESET_EVENT+0x47c0000)
		tc:RegisterEffect(e1,true)
		local e1b=e1:Clone()
		e1b:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1b:SetValue(ATTRIBUTE_DARK)
		tc:RegisterEffect(e1b,true)
		local e1c=e1:Clone()
		e1c:SetCode(EFFECT_CHANGE_RACE)
		e1c:SetValue(RACE_FIEND)
		tc:RegisterEffect(e1c,true)
		--immune
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_IMMUNE_EFFECT)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetRange(LOCATION_MZONE)
		e4:SetValue(c335599128.efilter)
		e4:SetReset(RESET_EVENT+0x47c0000)
		tc:RegisterEffect(e4,true)
		--cannot be battle target
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		e2:SetValue(aux.imval1)
		e2:SetReset(RESET_EVENT+0x47c0000)
		tc:RegisterEffect(e2,true)
		--Direct attack
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_DIRECT_ATTACK)
		e3:SetRange(LOCATION_MZONE)
		e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e3:SetTarget(c335599128.dirtg)
		e3:SetReset(RESET_EVENT+0x47c0000)
		tc:RegisterEffect(e3,true)	 
		tc:RegisterFlagEffect(335599128,RESET_EVENT+0x1fe0000,0,1)
	end
end



function c335599128.efilter(e,te)
	local tc=te:GetOwner()
	return tc~=e:GetOwner() and not tc:IsCode(94212438)
end