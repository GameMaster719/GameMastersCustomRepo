--Homunclus Envy
--scripted by GameMaster(GM)
function c335599107.initial_effect(c)
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30312361,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c335599107.cost)
	e1:SetTarget(c335599107.target)
	e1:SetOperation(c335599107.operation)
	c:RegisterEffect(e1)
	--pull spells to monster zone
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c335599107.op2)
	c:RegisterEffect(e2)
	--indestuctable battle/effects up to 4
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(4)
	e3:SetValue(c335599107.valcon)
	c:RegisterEffect(e3)
	--to grave
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetOperation(c335599107.regop2)
	c:RegisterEffect(e4)
end

function c335599107.regop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_DESTROY) and bit.band(c:GetPreviousLocation(),LOCATION_ONFIELD)~=0 then
		--spsummon
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(335599107,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCost(c335599107.spcost)
		e1:SetTarget(c335599107.sptg)
		e1:SetOperation(c335599107.spop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end


function c335599107.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(335599107)==0 end
	c:RegisterFlagEffect(335599107,nil,0,1)
end

function c335599107.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end

function c335599107.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	 Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end


function c335599107.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end

function c335599107.op2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(23603403,0)) then
		Duel.Hint(HINT_CARD,0,335599107)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		Duel.MoveToField(sc,sc:GetControler(),sc:GetControler(),LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
		Duel.BreakEffect()
		if sc:IsControler(tp) then
			Duel.GetControl(sc,1-tp,PHASE_END)
		end
		Duel.ChangeAttackTarget(sc)
	end
end

function c335599107.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(30312361)==0 end
	e:GetHandler():RegisterFlagEffect(30312361,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c335599107.filter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c335599107.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c335599107.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c335599107.filter,tp,LOCATION_GRAVE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c335599107.filter,tp,LOCATION_GRAVE,LOCATION_MZONE,1,1,nil)
end
function c335599107.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) then
		local code=tc:GetOriginalCode()
		local ba=tc:GetBaseAttack()
		if ba<0 then ba=0 end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetLabelObject(e1)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(ba-c:GetAttack())
		c:RegisterEffect(e2)
		local cid=c:CopyEffect(code,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(30312361,1))
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_PHASE+PHASE_END)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetCountLimit(1)
		e3:SetRange(LOCATION_MZONE)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e3:SetLabel(cid)
		e3:SetLabelObject(e2)
		e3:SetOperation(c335599107.rstop)
		c:RegisterEffect(e3)
	end
end
function c335599107.rstop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cid=e:GetLabel()
	c:ResetEffect(cid,RESET_COPY)
	local e2=e:GetLabelObject()
	local e1=e2:GetLabelObject()
	e1:Reset()
	e2:Reset()
	Duel.HintSelection(Group.FromCards(c))
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
