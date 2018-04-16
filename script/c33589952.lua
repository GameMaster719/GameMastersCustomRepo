--Holy Member Asuka Tachibana
function c33589952.initial_effect(c)
 --token
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33589952,0))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e1:SetType(EFFECT_TYPE_QUICK_O)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetRange(LOCATION_MZONE)
e1:SetCountLimit(8,33589952+EFFECT_COUNT_CODE_DUEL)
e1:SetCondition(c33589952.spcon2)
e1:SetTarget(c33589952.sptg2)
e1:SetOperation(c33589952.spop2)
c:RegisterEffect(e1)
local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)	
	e2:SetOperation(c33589952.op)
	c:RegisterEffect(e2)
	--cannot attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e3)
	--recover
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33589952,0))
	e4:SetCategory(CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c33589952.con999)
	e4:SetTarget(c33589952.tg999)
	e4:SetOperation(c33589952.op999)
	c:RegisterEffect(e4)
end







function c33589952.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local wg=Duel.GetMatchingGroup(c33589952.ofilter1,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local wbc=wg:GetFirst()
	local g=Group.CreateGroup()
	while wbc do
		if wbc:GetOverlayGroup():IsExists(Card.IsType,1,nil,TYPE_TOKEN) then
			local ov=wbc:GetOverlayGroup()
			local ov1=ov:GetFirst()
			while ov1 do
				if ov1:IsType(TYPE_TOKEN) then
					g:AddCard(ov1)
				end
				ov1=ov:GetNext()
			end
		end
		wbc=wg:GetNext()
	end
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(33589952)==0 then
			local e1=Effect.CreateEffect(c)
			e1:SetCode(EFFECT_SEND_REPLACE)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetTarget(c33589952.reptg)
			e1:SetOperation(c33589952.repop)
			e1:SetReset(RESET_EVENT+EVENT_ADJUST,1)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(33589952,EVENT_ADJUST,0,1) 	
		end
		tc=g:GetNext()
	end
end

function c33589952.ofilter1(c)
	return c:GetOverlayCount()~=0
end


function c33589952.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	return true
end
function c33589952.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=0
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP_ATTACK,true)
	elseif Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	elseif Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 then
		Duel.MoveToField(c,1-tp,1-tp,LOCATION_MZONE,POS_FACEUP_ATTACK,true)
	else
		Duel.MoveToField(c,1-tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	Duel.Destroy(c,REASON_RULE)
	Duel.Release(c,REASON_RULE)
	Duel.SendtoGrave(c,REASON_RULE)
	Duel.Remove(c,POS_FACEUP,REASON_RULE)
end

function comp(c,code)
return c:GetCode()==22222231
end

function c33589952.spcon2(e,tp,eg,ep,ev,re,r,rp)
return not e:GetHandler():GetCardTarget():SearchCard(comp,e:GetHandler():GetEquipTarget()) 
end


function c33589952.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsPlayerCanSpecialSummonMonster(tp,22222231,0,0x4011,500,100,9,RACE_MACHINE,ATTRIBUTE_LIGHT) end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end

function c33589952.spop2(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
if Duel.IsPlayerCanSpecialSummonMonster(tp,22222231,0,0x4011,500,100,9,RACE_MACHINE,ATTRIBUTE_LIGHT) then
local token1=Duel.CreateToken(tp,22222231)
Duel.SpecialSummonStep(token1,0,tp,tp,false,false,POS_FACEUP_ATTACK)
--attach orb to monster
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(22222231,2))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c33589952.mattg)
	e1:SetOperation(c33589952.matop)
	token1:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE+LOCATION_OVERLAY)	
	e2:SetOperation(c33589952.op)
	token1:RegisterEffect(e2)
	--battle dam 0
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetValue(1)
	token1:RegisterEffect(e3)
--attach orb to orb
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetDescription(aux.Stringid(22222231,3))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_MZONE+LOCATION_GRAVE+LOCATION_OVERLAY)
	e4:SetTarget(c33589952.mattg4)
	e4:SetOperation(c33589952.matop4)
	token1:RegisterEffect(e4)
	--detach
    local e6=Effect.CreateEffect(e:GetHandler())
    e6:SetDescription(aux.Stringid(888000027,2))
    e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e6:SetCode(EVENT_TO_GRAVE)
    e6:SetOperation(c33589952.op359)
	e6:SetCondition(c33589952.con953)
    token1:RegisterEffect(e6)
	--atk/defup
	local e7=Effect.CreateEffect(e:GetHandler())
	e7:SetType(EFFECT_TYPE_XMATERIAL)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetCode(EFFECT_UPDATE_ATTACK)
	e7:SetRange(LOCATION_OVERLAY)
	e7:SetValue(600)
	token1:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_UPDATE_DEFENSE)
	token1:RegisterEffect(e8)
	--atk/defup
	local e9=Effect.CreateEffect(e:GetHandler())
	e9:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_TRIGGER_F)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e9:SetRange(LOCATION_MZONE)
	e9:SetCountLimit(1)
	e9:SetCondition(c33589952.con999)
	e9:SetTarget(c33589952.tg999)
	e9:SetOperation(c33589952.op999)
	token1:RegisterEffect(e9)
local c=e:GetHandler()
c:SetCardTarget(token1)
Duel.SpecialSummonComplete()
if c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousCodeOnField()==22222231 and c:IsPreviousLocation(LOCATION_ONFIELD) then 
e:GetHandler():CancelCardTarget(token1)			
		end
end
end

function c33589952.con999(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	return tp==Duel.GetTurnPlayer() and c:GetOverlayGroup():IsExists(Card.IsCode,1,nil,22222231)
end
function c33589952.tg999(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(400)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,400)
end
function c33589952.op999(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Recover(p,d,REASON_EFFECT)
	end
end

function c33589952.con953(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return  c:IsPreviousLocation(LOCATION_OVERLAY) and (not c:IsReason(REASON_RELEASE) and not c:IsReason(REASON_MATERIAL))
end

function c33589952.op359(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()  
   if not c:IsPreviousLocation(LOCATION_OVERLAY) then return end
   if not Duel.IsExistingTarget(c33589952.matfilter2,tp,LOCATION_MZONE,0,1,nil) then return end
   if c:IsPreviousLocation(LOCATION_OVERLAY)  then  
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33589952.matfilter2,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
	Duel.GetControl(tc,1-tp)
  end
end
end	
	
function c33589952.filter2(c)
		return c:IsCode(22222231)
end






function c33589952.matfilter4(c)
	return  c:IsCode(33589952) or c:IsCode(22222231) 
end



	
	

function c33589952.mattg4(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33589952.matfilter4(chkc) end
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingTarget(c33589952.matfilter4,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33589952.matfilter4,tp,LOCATION_MZONE,0,1,1,nil)
	end
function c33589952.matop4(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
   if not c:IsLocation(0x80) then return end
		Duel.GetControl(tc,tp)
	if Duel.GetControl(tc,tp) and c:IsLocation(0x80) then 
	local c=e:GetHandler()
--get effect
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetDescription(aux.Stringid(31755044,1))
	e2:SetType(EFFECT_TYPE_XMATERIAL)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e2:SetRange(LOCATION_OVERLAY)
	c:RegisterEffect(e2)
	Duel.BreakEffect()
	local c=e:GetHandler()
	if c:GetOverlayCount()~=0 and Duel.SelectYesNo(tp,aux.Stringid(22222231,0))  then 
	local g1=Duel.SelectTarget(tp,c33589952.matfilter4,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33589952.filter2,tp,LOCATION_MZONE,0,1,1,nil)
	local c=e:GetHandler()
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if tc1:IsFacedown() or not tc1:IsRelateToEffect(e) then return end
	local og=tc1:GetOverlayGroup()
	if og:GetCount()==0 then return end
	if Duel.SendtoGrave(og,REASON_EFFECT)~=0 and tc2:IsFaceup() and tc2:IsRelateToEffect(e) and c:IsRelateToEffect(e) then
		c:CancelToGrave()
		Duel.Overlay(tc2,Group.FromCards(c))
		end
end
end
end 
end 


	
function c33589952.matfilter2(c)
	return c:IsFaceup() and (c:GetControler()~=c:GetOwner() and c:IsAbleToChangeControler() and not c:GetOverlayGroup():IsExists(Card.IsCode,1,nil,22222231))
end
	
function c33589952.matfilter(c)
	return c:IsFaceup() 
end
function c33589952.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c33589952.matfilter(chkc) end
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingTarget(c33589952.matfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33589952.matfilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c33589952.matop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Overlay(tc,Group.FromCards(c))
	if not c:IsLocation(0x80) then return end
		Duel.GetControl(tc,tp)
	if Duel.GetControl(tc,tp) and c:IsLocation(0x80) then 
	local c=e:GetHandler()
--get effect
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetDescription(aux.Stringid(31755044,1))
	e2:SetType(EFFECT_TYPE_XMATERIAL)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
	e2:SetRange(LOCATION_OVERLAY)
	c:RegisterEffect(e2)	
		end
end
end


