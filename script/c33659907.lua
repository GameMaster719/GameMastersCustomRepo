--Funnier Move Spawn

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
    e1:SetOperation(scard.op)
    c:RegisterEffect(e1)
end

function scard.actfil(c)
    return c:IsFacedown() or c:IsType(TYPE_CONTINUOUS+TYPE_FIELD+TYPE_PENDULUM+TYPE_MONSTER+TYPE_TOKEN) and not c:IsType(TYPE_EQUIP)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(scard.actfil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
    g:RemoveCard(e:GetHandler())
    if g:GetCount()==0 then return end
    Duel.SendtoDeck(g,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
    g:KeepAlive()
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_PHASE+PHASE_END)
    e1:SetOperation(scard.retop)
    e1:SetLabelObject(g)
    Duel.RegisterEffect(e1,tp)
end

function scard.retop(e,tp,eg,ep,ev,re,r,rp)
    local g=e:GetLabelObject()
    local sg=Group.CreateGroup()
    local c=g:GetFirst()
    while c do
	if c:GetPreviousControler()==tp then
	local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetCode(EFFECT_SET_CONTROL)
e1:SetValue(0)
c:RegisterEffect(e1)
else
	local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetCode(EFFECT_SET_CONTROL)
e1:SetValue(1)
c:RegisterEffect(e1)
end
local g1=Duel.GetFieldGroup(c:GetPreviousControler(),LOCATION_MZONE,0)
	local g2=Duel.GetFieldGroup(c:GetPreviousControler(),0,LOCATION_MZONE)
		Duel.SwapControl(g1,g2)
        if not Duel.GetFieldCard(c:GetPreviousControler(),c:GetPreviousLocation(),LOCATION_MZONE) then
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

-----------------------------------


