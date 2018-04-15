--Shadow Duel 
--scripted by GameMaster(GM)
function c33559907.initial_effect(c)
--First player draws
local e0=Effect.CreateEffect(c)
e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e0:SetCode(EVENT_PHASE_START+PHASE_DRAW)
e0:SetCountLimit(1)
e0:SetRange(LOCATION_HAND+LOCATION_DECK)
e0:SetTarget(c33559907.tg0)
e0:SetOperation(c33559907.op0)
c:RegisterEffect(e0)
--draw card if this card is drawn
local e1=Effect.CreateEffect(c)
e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
e1:SetCountLimit(1)
e1:SetRange(LOCATION_HAND+LOCATION_DECK)
e1:SetTarget(c33559907.target)
e1:SetOperation(c33559907.operation)
c:RegisterEffect(e1)
--set monsters in faceup defense
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetRange(LOCATION_REMOVED)
e2:SetCode(EFFECT_DEVINE_LIGHT)
e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e2:SetTargetRange(1,1)
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
end


function c33559907.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetTurnCount()==1 end
if Duel.GetFlagEffect(tp,33559907)~=0 then return false end
if Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()==tp and Duel.GetFlagEffect(tp,33559907)==0 then 
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
Duel.RegisterFlagEffect(tp,33559907,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1) 
elseif Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect(tp,33559907)==0 then  
Duel.SetTargetPlayer(1-tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
Duel.RegisterFlagEffect(tp,33559907,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)

end
end


function c33559907.op0(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return true end
Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
if e:GetHandler():IsPreviousLocation(LOCATION_DECK) or e:GetHandler():IsPreviousLocation(LOCATION_HAND)  then
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Draw(p,d,REASON_EFFECT)
end
end


function c33559907.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c33559907.operation(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
if e:GetHandler():IsPreviousLocation(LOCATION_HAND) then
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Draw(p,d,REASON_EFFECT)
end
end