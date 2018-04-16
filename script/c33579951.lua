--Dark Sanctuary
--Scripted by GameMaster(GM)
function c33579951.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e1)
--tribute monster at end phase to keep on field
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33579951,0))
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
e2:SetCode(EVENT_PHASE+PHASE_END)
e2:SetRange(LOCATION_SZONE)
e2:SetCountLimit(1)
e2:SetCondition(c33579951.mtcon)
e2:SetOperation(c33579951.mtop)
c:RegisterEffect(e2)
--move to field
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
e3:SetCode(EVENT_CHAIN_SOLVED)
e3:SetProperty(EFFECT_FLAG_DELAY)
e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
e3:SetRange(LOCATION_FZONE)
e3:SetCondition(c33579951.spcon)
e3:SetCost(c33579951.spcost)
e3:SetTarget(c33579951.sptg)
e3:SetOperation(c33579951.spop)
c:RegisterEffect(e3)
--selfdes if dark necrofear on field
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_SINGLE)
e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e4:SetCode(EFFECT_SELF_DESTROY)
e4:SetRange(LOCATION_FZONE)
e4:SetCondition(c33579951.sdcon)
c:RegisterEffect(e4)
--If dark sant leave move letters 
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e5:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e5:SetCode(EVENT_TO_GRAVE)
e5:SetTarget(c33579951.tg6)
e5:SetOperation(c33579951.op6)
e5:SetCondition(c33579951.con6)
c:RegisterEffect(e5)
--move tcsters
local e6=Effect.CreateEffect(c)
--e6:SetDescription(aux.Stringid(34358408,0))
e6:SetType(EFFECT_TYPE_IGNITION)
e6:SetRange(LOCATION_FZONE)
e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CARD_TARGET)
e6:SetCode(EVENT_FREE_CHAIN)
e6:SetTarget(c33579951.tg7)
e6:SetOperation(c33579951.op7)
c:RegisterEffect(e6)
end

function c33579951.filter660(c)
	return c:IsType(TYPE_SPELL)
end
function c33579951.tg7(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33579951.filter660,tp,LOCATION_ONFIELD,0,1,nil) and
		(Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or Duel.GetLocationCount(tp,LOCATION_SZONE)> 0 ) end
	local zone=LOCATION_ONFIELD
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then zone=LOCATION_MZONE end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)==0 then zone=LOCATION_SZONE end
	local g=Duel.SelectTarget(tp,c33579951.filter660,tp,zone,0,1,1,nil)
end
function c33579951.op7(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local dest=LOCATION_MZONE
	if tc:GetLocation()==LOCATION_MZONE then dest=LOCATION_SZONE end
	local pos=POS_FACEUP
	if tc:IsFacedown() then pos=POS_FACEDOWN_DEFENSE end
	
	if tc:IsType(TYPE_PENDULUM) and dest==LOCATION_SZONE then
		Duel.MoveToField(tc,tp,tp,dest,pos,true)
			
		local ind={2,1,3,0,5}
		local i = 1
		while not Duel.CheckLocation(tp,LOCATION_SZONE,ind[i]) do 
			i=i+1
		end
		Duel.MoveSequence(tc, ind[i])
	else
		Duel.MoveToField(tc,tp,tp,dest,pos,true)
	local tc=Duel.GetFirstTarget()
		--immune
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_IMMUNE_EFFECT)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetRange(LOCATION_MZONE)
		e4:SetValue(c33579951.efilter)
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
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_CANNOT_ATTACK)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e5,true)
		local e6=Effect.CreateEffect(c)
			e6:SetType(EFFECT_TYPE_SINGLE)
			e6:SetCode(EFFECT_UNRELEASABLE_SUM)
			e6:SetValue(1)
			e6:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e6,true)
			local e7=e6:Clone()
			e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			tc:RegisterEffect(e7,true)
	end
	
	if tc:GetOwner()~=tp then 
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_OWNER_RELATE)
		e1:SetRange(LOCATION_ONFIELD)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_CONTROL)
		e1:SetValue(tp)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		tc:RegisterEffect(e1)
	end
end



c33579951.collection={ [31893528]=true; [67287533]=true; [94772232]=true;  }


function c33579951.filter660(c)
	return c:IsFaceup() and c33579951.collection[c:GetCode()]
end


function c33579951.tg6(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingMatchingCard(c33579951.filter660,tp,LOCATION_MZONE,0,1,nil)  end
end

function c33579951.op6(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c33579951.filter660,tp,LOCATION_MZONE,0,1,3,nil)
	e:SetLabel(g:GetCount())
	local ct=e:GetLabel()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=ct then
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c33579951.costfilter,tp,LOCATION_SZONE,0,ct,ct,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
	local g=Duel.SelectMatchingCard(tp,c33579951.filter660,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
	while tc do	
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tp=tc:GetControler()
		tc=g:GetNext()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c33579951.filter660,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
	while tc do	
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tp=tc:GetControler()
		tc=g:GetNext()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local g=Duel.SelectMatchingCard(tp,c33579951.filter660,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
	while tc do	
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		local tp=tc:GetControler()
		tc=g:GetNext()
													end
											end
									end
							end
					end
			end
	end
end



function c33579951.con6(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	return e:GetHandler():GetLocation()==LOCATION_GRAVE
end

function c33579951.costfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
end




function c33579951.filter6(c)
return c:GetOriginalCode()==335599127 
end
function c33579951.sdcon(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33579951.filter6,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) then return true
else return false end
end

function c33579951.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c33579951.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckReleaseGroup(tp,nil,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(33579951,0)) then
		local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
		Duel.Release(sg,REASON_COST)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
function c33579951.chainreg(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(33579951)==0 then
		e:GetHandler():RegisterFlagEffect(33579951,RESET_EVENT+0x1fc0000+RESET_CHAIN,0,1)
	end
end

function c33579951.spfil(c,tc)
	return c:IsFaceup() and c:IsCode(31893528,67287533,94772232,30170981) and c:GetTurnID()==tc
end
function c33579951.spcon(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	--return rp==tp and rc:IsCode(94212438) and e:GetHandler():GetFlagEffect(33579951)>0 and Duel.IsExistingMatchingCard(c33579951.spfil,tp,LOCATION_SZONE,0,1,nil,Duel.GetTurnCount())
	if rp~=tp then
		--Debug.Message("Effect activated by another player.")
		return false
	elseif not rc:IsCode(94212438) then
		--Debug.Message("Not Destiny Board.")
		return false
	elseif not Duel.IsExistingMatchingCard(c33579951.spfil,tp,LOCATION_SZONE,0,1,nil,Duel.GetTurnCount()) then
		--Debug.Message("No Spirit Message placed.")
		return false
	else return true end
end
function c33579951.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(33579951+1)==0 end
	c:RegisterFlagEffect(33579951+1,RESET_CHAIN,0,1)
end
function c33579951.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c33579951.spfil,tp,LOCATION_SZONE,0,nil,Duel.GetTurnCount())
	local tc=g:GetFirst()
	if chk==0 then
		--return tc and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSumtcMonster(tp,tc:GetCode(),0,0x11,0,0,1,RACE_FIEND,ATTRIBUTE_DARK)
		if not tc then
			return false
		elseif Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then
			--Debug.Message("No space.")
			return false
		else return true end
	end
	e:SetLabelObject(tc)
end
function c33579951.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local tc=e:GetLabelObject()
	--if not tc or not tc:IsRelateToEffect(e) then return end
	if not tc then 
		--Debug.Message("No sumtcable card.")
		return
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0  then
		--Debug.Message("Enters this section.")
		Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
		--immune
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_IMMUNE_EFFECT)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetRange(LOCATION_MZONE)
		e4:SetValue(c33579951.efilter)
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
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetCode(EFFECT_CANNOT_ATTACK)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e5,true)
		local e6=Effect.CreateEffect(c)
			e6:SetType(EFFECT_TYPE_SINGLE)
			e6:SetCode(EFFECT_UNRELEASABLE_SUM)
			e6:SetValue(1)
			e6:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e6,true)
			local e7=e6:Clone()
			e7:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			tc:RegisterEffect(e7,true)
		tc:RegisterFlagEffect(33579951,RESET_EVENT+0x1fe0000,0,1)
			end
end



function c33579951.efilter(e,te)
	local tc=te:GetOwner()
	return tc~=e:GetOwner() and not tc:IsCode(94212438)
end