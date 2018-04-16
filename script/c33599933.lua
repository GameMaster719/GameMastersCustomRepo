--The Big 5
--scripted by GameMaster(GM)
function c33599933.initial_effect(c)
--draw card if this card is drawn
local e1=Effect.CreateEffect(c)
e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
e1:SetCountLimit(1)
e1:SetRange(LOCATION_HAND+LOCATION_DECK)
e1:SetTarget(c33599933.target)
e1:SetOperation(c33599933.operation)
c:RegisterEffect(e1)
--Remove Deck master during drawphase
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33589934,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetCountLimit(1)
	e2:SetCondition(c33599933.con)
	e2:SetTarget(c33599933.tg2)
	e2:SetOperation(c33599933.op2)
	c:RegisterEffect(e2)
--protection (steal Boss Duel xD)
		local e3=Effect.CreateEffect(c)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_TO_GRAVE)
		c:RegisterEffect(e3)
		local e4=e3:Clone()
		e4:SetCode(EFFECT_CANNOT_TO_HAND)
		c:RegisterEffect(e4)
		local e5=e3:Clone()
		e5:SetCode(EFFECT_CANNOT_TO_DECK) 
		c:RegisterEffect(e5)
		local e6=e3:Clone()
		e6:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		c:RegisterEffect(e6)
	--MOVE effect during standby
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
	e7:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e7:SetRange(LOCATION_REMOVED)
	e7:SetCountLimit(1)
	e7:SetCondition(c33599933.con2)
	e7:SetTarget(c33599933.tg7)
	e7:SetOperation(c33599933.op7)
	c:RegisterEffect(e7)
	--MOVE Big 5
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(33599933,1))
	e8:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
	e8:SetRange(LOCATION_REMOVED)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetCountLimit(1)
	e8:SetTarget(c33599933.tg8)
	e8:SetCondition(c33599933.con8)
	e8:SetOperation(c33599933.op8)
	c:RegisterEffect(e8)
end

function c33599933.con8(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>3
end

function c33599933.tg8(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>3
		and Duel.IsExistingMatchingCard(c33599933.filter,tp,LOCATION_REMOVED,0,4,nil,e,tp) end
	
end
function c33599933.op8(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<4 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c33599933.filter,tp,LOCATION_REMOVED,0,4,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		local tc=g:GetFirst()
		while tc do
		local tpe=tc:GetType(TYPE_PENDULUM)
		Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
			tc=g:GetNext()
		end
end
local sg=Duel.GetMatchingGroup(c33599933.filter,tp,LOCATION_REMOVED,1,nil)
	local tc=sg:GetFirst()
	sg:RemoveCard(e:GetHandler())
	if sg:GetCount()==0 then return end
    Duel.SendtoDeck(sg,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
    sg:KeepAlive()	
end



function c33599933.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
end


function c33599933.operation(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
local token=Duel.CreateToken(tp,33599938)
			Duel.SendtoHand(token,tp,2,REASON_EFFECT)
local token2=Duel.CreateToken(tp,33599934)
			Duel.SendtoHand(token2,tp,2,REASON_EFFECT)
local token3=Duel.CreateToken(tp,33599936)
			Duel.SendtoHand(token3,tp,2,REASON_EFFECT)	
local token4=Duel.CreateToken(tp,33599935)
			Duel.SendtoHand(token4,tp,2,REASON_EFFECT)	
local token5=Duel.CreateToken(tp,33599937)
			Duel.SendtoHand(token5,tp,2,REASON_EFFECT)
			Duel.Remove(token,POS_FACEUP,REASON_EFFECT)
			Duel.Remove(token2,POS_FACEUP,REASON_EFFECT)
			Duel.Remove(token3,POS_FACEUP,REASON_EFFECT)
			Duel.Remove(token4,POS_FACEUP,REASON_EFFECT)
			Duel.Remove(token5,POS_FACEUP,REASON_EFFECT)
if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
				Duel.Draw(tp,1,REASON_RULE)
end
end

function c33599933.filter2(c)
	return c:IsType(TYPE_PENDULUM) and c33599933.collection2 and not c:IsLocation(LOCATION_MZONE) and not (c:IsCode(33559907) or c:IsCode(33599933))
end

function c33599933.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33599933.filter2,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(c33599933.filter2,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c33599933.op2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c33599933.filter2,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end



function c33599933.con(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c33599933.filter,tp,LOCATION_ONFIELD,0,nil) --the same
    return Duel.GetTurnPlayer()==tp and g:IsExists( c33599933.filter,1,nil)
end

function c33599933.con2(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetTurnPlayer()==tp 
end

function c33599933.retop(e,tp,eg,ep,ev,re,r,rp)
    local g=e:GetLabelObject()
    local sg=Group.CreateGroup()
    local c=g:GetFirst()
    while c do
        if not Duel.GetFieldCard(c:GetPreviousControler(),c:GetPreviousLocation(),c:GetPreviousSequence()) then
            Duel.ReturnToField(c)
            sg:AddCard(c)
        end
        c=g:GetNext()
    end
    g:Sub(sg)
    Duel.SendtoGrave(g,REASON_RULE)
    g:DeleteGroup()
    e:Reset()
end
--------------------------
function c33599933.filter(c)
	return c:IsType(TYPE_PENDULUM) and c33599933.collection2 and not (c:IsCode(33559907) or c:IsCode(33599933))
end
function c33599933.tg7(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) 
		and Duel.IsExistingMatchingCard(c33599933.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	
end

function c33599933.op7(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33599933.filter,tp,LOCATION_ONFIELD,0,nil) --the same
   if g:IsExists( c33599933.filter,1,nil) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SELECT)
	local tc=Duel.SelectMatchingCard(tp,c33599933.filter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp):GetFirst()
	if tc then
	local tpe=tc:GetType(TYPE_PENDULUM)
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
end

function c33599933.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,33599933)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end

c33599933.collection2={ 
[33599938]=true;--Deepseawarrior
[33599934]=true;--nightmarepenguin
[33599936]=true;--judgeman
[33599935]=true;--roboticknight
[33599937]=true;--jinzo 
}
--------------------------