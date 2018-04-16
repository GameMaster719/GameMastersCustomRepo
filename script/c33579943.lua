--funnier Move Spawn

local function getID()
  local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
  str=string.sub(str,1,string.len(str)-4)
  local scard=_G[str]
  local s_id=tonumber(string.sub(str,2))
  return scard,s_id
end

local scard,s_id=getID()

function scard.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33579943.target)
    e1:SetOperation(scard.op)
    c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33579943,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c33579943.condition)
	e2:SetCountLimit(1)
	e2:SetOperation(scard.op)
	c:RegisterEffect(e2)
	--treatead as Toon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetCode(EFFECT_ADD_TYPE)
	e3:SetValue(TYPE_TOON)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TOON))
	e4:SetCondition(c33579943.dircon)
	c:RegisterEffect(e4)
	--battle indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_TOON))
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--disable field
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EFFECT_DISABLE_FIELD)
	e6:SetOperation(c33579943.disop)
	e6:SetLabelObject(e1)
	c:RegisterEffect(e6)
	end

function c33579943.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 end
	local g=Duel.GetMatchingGroup(scard.actfil,tp,LOCATION_ONFIELD,0,e:GetHandler())
	local dis=Duel.SelectDisableField(tp,g,LOCATION_MZONE,0,0)
	e:SetLabel(dis)
end

	
function c33579943.dirfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end

function c33579943.dircon(e)
	return not Duel.IsExistingMatchingCard(c33579943.dirfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end

function c33579943.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end

function scard.actfil(c)
    return c:IsType(TYPE_TOON) 
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.SelectTarget(tp,scard.actfilter,tp,LOCATION_MZONE,0,1,5,nil)
	local tc=g:GetFirst()
	while tc do
	e:SetLabel(tc:GetPreviousSequence())
	local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local nseq=0
	if s==1 then nseq=0
	elseif s==2 then nseq=1
	elseif s==4 then nseq=2
	elseif s==8 then nseq=3
	else nseq=4 end
	local dis1=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	local seq=0
	if dis1==1 then seq=0 end
	if dis1==2 then seq=1 end
	if dis1==4 then seq=2 end
	if dis1==8 then seq=3 end
	if dis1==16 then seq=4 end
	local seq=seq+16 
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY,2)
		e1:SetLabelObject(e)
		e1:SetCountLimit(1)
		e1:SetOperation(c33579943.retop)
		Duel.RegisterEffect(e1,tp)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_DISABLE_FIELD)
		e2:SetReset(RESET_PHASE+PHASE_STANDBY,2)
		e2:SetLabel(seq)
		e2:SetLabelObject(e)
		e2:SetCondition(c33579943.discon)
		e2:SetOperation(c33579943.disop)
		Duel.RegisterEffect(e2,tp)
		tc=g:GetNext()
	g:RemoveCard(e:GetHandler())
	if g:GetCount()==0 then return end
    Duel.SendtoDeck(g,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
    g:KeepAlive()
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
    e1:SetOperation(scard.retop)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c33579943.rtcon)
    e1:SetLabelObject(g)
	e1:SetCountLimit(1)
    Duel.RegisterEffect(e1,tp)
end
end


function c33579943.discon(e,c)
if e:GetLabelObject(g) then return true end
	return false
end




function c33579943.disop(e,tp)
 return e:GetLabelObject():GetLabel(seq)
end



function c33579943.rtcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c33579943.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.ReturnToField(c)
end




function scard.retop(e,tp,eg,ep,ev,re,r,rp)
   local g=e:GetLabelObject(seq)
    local sg=Group.CreateGroup()
    local c=g:GetFirst()
    while c do
        if not Duel.GetFieldCard(c:GetPreviousControler(),c:GetPreviousLocation(),c:GetPreviousSequence()) then
            Duel.ReturnToField(c)
            sg:AddCard(c)
		        end
			c=g:GetNext()
          end
    g:Sub(c,sg)
	Duel.ReturnToField(c)
    g:DeleteGroup()
    e:Reset()
end


