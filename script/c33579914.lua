--Memory Snatcher
function c33579914.initial_effect(c)
    --activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33579914.tg)
c:RegisterEffect(e1)
--attach as material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_GRAVE)
	e2:SetOperation(c33579914.operation)
	c:RegisterEffect(e2)
	--add graveyard monster to snacther
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CUSTOM+33579914)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c33579914.olcon)
	e3:SetOperation(c33579914.olop)
	c:RegisterEffect(e3)   
end

function c33579914.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end

function c33579914.olcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsCode(33579914)
end


function c33579914.filter22(c,tp)
return c:IsType(TYPE_MONSTER) and c:IsFaceup() 
end

function c33579914.olop(e,tp,eg,ep,ev,re,r,rp)
   local wg=Duel.GetMatchingGroup(c33579914.filter22,tp,0,LOCATION_GRAVE,nil,e)
--where g is card group
local c=wg:GetFirst()
while c do
	--do your thing to c
	local og=c:GetOverlayGroup()
	if og:GetCount()>0 then Duel.SendtoGrave(og,REASON_RULE) end
	c=wg:GetNext()
end
Duel.Overlay(e:GetHandler(),wg)
end

function c33579914.filter(c,tp)
    return c:IsType(TYPE_MONSTER) and  c:GetOwner()==1-tp

end
function c33579914.antifilter(c)
	return not c33579914.filter(c)
end

function c33579914.operation(e,tp,eg,ep,ev,re,r,rp)
	local g = eg:Filter(c33579914.filter,nil,tp)
	local c = g:GetFirst()
	while c do
		if c:GetOverlayCount()>0 then 
			local og=c:GetOverlayGroup()
			Duel.SendtoGrave(og:Filter(c33579914.antifilter,nil),REASON_RULE)
			Duel.Overlay(e:GetHandler(),og:Filter(c33579914.filter,nil,tp)) 
		end
		c = g:GetNext()
	end
	Duel.Overlay(e:GetHandler(),g)
	Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+33579914,e,0,0,tp,0)
end