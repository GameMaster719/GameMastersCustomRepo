--Destiny Draw (DOR)
--scripted by GameMaster(GM)
function c33589936.initial_effect(c)
--draw card if this card is drawn
local e1=Effect.CreateEffect(c)
e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
e1:SetCountLimit(1)
e1:SetRange(LOCATION_HAND+LOCATION_DECK)
e1:SetTarget(c33589936.target)
e1:SetOperation(c33589936.operation)
c:RegisterEffect(e1)
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
e5:SetCode(EVENT_PREDRAW)
e5:SetRange(LOCATION_REMOVED)
e5:SetCountLimit(1,33589936+EFFECT_COUNT_CODE_DUEL)
e5:SetCondition(c33589936.con5)
e5:SetTarget(c33589936.tg5)
e5:SetOperation(c33589936.op5)
c:RegisterEffect(e5)
end



function c33589936.con5(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=Duel.GetLP(1-tp)/2 and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(e:GetHandler():GetControler(),0,LOCATION_MZONE)>0
end

function c33589936.tg5(e,tp,eg,ep,ev,re,r,rp,chk)
if Duel.GetTurnPlayer()~=tp then return end
if chk==0 then return true end
local dt=Duel.GetDrawCount(tp)
if dt~=0 then
	_replace_count=0
	_replace_max=dt
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_DRAW_COUNT)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DRAW)
	e1:SetValue(0)
	Duel.RegisterEffect(e1,tp)
end
end

function c33589936.filter(c)
	return c33589936.collection2 and c:IsFacedown()
end


c33589936.collection2={  
[511005654]=true;--dark hole
[33569906]=true;--change of heart
[44095762]=true;--mirror force
[12580477]=true;--raigeki
[511005648]=true;--dian keto
[511005686]=true;--rirokyu
[33569943]=true;--kinetic soldier
[33589910]=true;--swords of reaveling light
[33589920]=true;--aresenalbug
[33569955]=true;--woodland sprite 
}

function c33589936.op5(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	_replace_count=_replace_count+1
	if _replace_count>_replace_max or not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c33589936.filter,tp,LOCATION_REMOVED,0,c)
  	if g:GetCount()>5 then
	local sg=g:RandomSelect(tp,1):GetFirst()
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	end
 end
	

function c33589936.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c33589936.operation(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
local c=e:GetHandler()
local tp=c:GetControler()
local token=Duel.CreateToken(tp,33589920)
Duel.SendtoHand(token,tp,2,REASON_EFFECT)
local token2=Duel.CreateToken(tp,33569955)
Duel.SendtoHand(token2,tp,2,REASON_EFFECT)
local token3=Duel.CreateToken(tp,511005648)
Duel.SendtoHand(token3,tp,2,REASON_EFFECT)	
local token4=Duel.CreateToken(tp,33569943)
Duel.SendtoHand(token4,tp,2,REASON_EFFECT)	
local token5=Duel.CreateToken(tp,44095762)
Duel.SendtoHand(token5,tp,2,REASON_EFFECT)
local token6=Duel.CreateToken(tp,12580477)
Duel.SendtoHand(token6,tp,2,REASON_EFFECT)
local token7=Duel.CreateToken(tp,33569906)
Duel.SendtoHand(token7,tp,2,REASON_EFFECT)		
local token8=Duel.CreateToken(tp,511005654)
Duel.SendtoHand(token8,tp,2,REASON_EFFECT)	
local token9=Duel.CreateToken(tp,33589910)
Duel.SendtoHand(token9,tp,2,REASON_EFFECT)		
local token10=Duel.CreateToken(tp,511005686)
Duel.SendtoHand(token10,tp,2,REASON_EFFECT)				
Duel.Remove(token,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token2,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token3,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token4,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token5,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token6,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token7,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token8,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token9,POS_FACEDOWN,REASON_EFFECT)
Duel.Remove(token10,POS_FACEDOWN,REASON_EFFECT)
if e:GetHandler():IsPreviousLocation(LOCATION_HAND) then
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Draw(p,d,REASON_EFFECT)
end
end
