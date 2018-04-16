--Temple of the kings (Anime)
--Modified by GameMaster(GM)
function c33579962.initial_effect(c)
--Activate
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e0)
--sp summon mystical beast of serket
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33579962,0))
e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_SZONE)
e1:SetCondition(c33579962.con1)
e1:SetTarget(c33579962.sptg)
e1:SetOperation(c33579962.spop)
c:RegisterEffect(e1)	
--Trap activate in set turn
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e2:SetRange(LOCATION_SZONE)
e2:SetTargetRange(LOCATION_SZONE,0)
c:RegisterEffect(e2)
--Special summon from temple stairs
local e4=Effect.CreateEffect(c)
e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
e4:SetDescription(aux.Stringid(33579962,1))
e4:SetType(EFFECT_TYPE_IGNITION)
e4:SetRange(LOCATION_FZONE)
e4:SetCost(c33579962.cost3)
e4:SetTarget(c33579962.tg3)
e4:SetOperation(c33579962.op3)
c:RegisterEffect(e4)
--material
local e5=Effect.CreateEffect(c)
e5:SetDescription(aux.Stringid(33579962,2))
e5:SetType(EFFECT_TYPE_IGNITION)
e5:SetCode(EVENT_FREE_CHAIN)
e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
e5:SetRange(LOCATION_FZONE)
e5:SetTarget(c33579962.mattg)
e5:SetOperation(c33579962.matop)
e5:SetCondition(c33579962.con3)
e5:SetCountLimit(1)
c:RegisterEffect(e5)
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_FIELD)
e6:SetCode(EFFECT_CANNOT_ACTIVATE)
e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e6:SetRange(LOCATION_SZONE)
e6:SetTargetRange(0,1)
e6:SetCondition(c33579962.econ)
e6:SetValue(c33579962.elimit)
c:RegisterEffect(e6)
if not c33579962.global_check then
c33579962.global_check=true
c33579962[0]=0
c33579962[1]=0
--activate limit
local ge1=Effect.CreateEffect(c)
ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
ge1:SetCode(EVENT_CHAINING)
ge1:SetRange(LOCATION_MZONE)
ge1:SetOperation(c33579962.aclimit1)
Duel.RegisterEffect(ge1,0)
local ge2=Effect.CreateEffect(c)
ge2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
ge2:SetCode(EVENT_CHAIN_NEGATED)
ge2:SetRange(LOCATION_MZONE)
ge2:SetOperation(c33579962.aclimit2)
Duel.RegisterEffect(ge2,0)
local ge3=Effect.CreateEffect(c)
ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
ge3:SetCode(EVENT_ADJUST)
ge3:SetCountLimit(1)
ge3:SetOperation(c33579962.clear)
Duel.RegisterEffect(ge3,0)
end
end



function c33579962.con3(e,tp,eg,ep,ev,re,r,rp)
local g=e:GetHandler():GetOverlayGroup()
if g:GetCount()==1 then return false
else return true
end
end
function c33579962.cost3(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckReleaseGroup(tp,c33579962.serketfilter503,1,nil)  end
local sg=Duel.SelectReleaseGroup(tp,c33579962.serketfilter503,1,1,nil)
Duel.Release(sg,REASON_COST)
end


function c33579962.tg3(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.IsPlayerCanSpecialSummon(tp) end
local g=e:GetHandler():GetOverlayGroup()
local c=g:Select(tp,1,1,nil) 
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,c:GetCount(),0,0)
end

function c33579962.op3(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not Duel.IsPlayerCanSpecialSummon(tp) then return end
local ex1,g=Duel.GetOperationInfo(0,CATEGORY_SPECIAL_SUMMON)
Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
local tc=g:GetFirst()
if tc and tc:GetCode()==10000010 then 
local g=Duel.GetMatchingGroup(c33579962.serketfilter503,tp,LOCATION_GRAVE,0,e:GetHandler())
local atk=g:GetSum(Card.GetPreviousAttackOnField)
local def=g:GetSum(Card.GetPreviousDefenseOnField)
if atk<0 then atk=0 end
if atk>0 then
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_SET_ATTACK)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_COPY_INHERIT)
e1:SetValue(atk)
e1:SetReset(RESET_EVENT+0x1fe0000)
tc:RegisterEffect(e1)
if def<0 then def=0 end
if def>0 then			
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetType(EFFECT_TYPE_SINGLE)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_COPY_INHERIT)
e2:SetCode(EFFECT_SET_DEFENSE)
e2:SetReset(RESET_EVENT+0x1fe0000)
e2:SetValue(def)
tc:RegisterEffect(e2)
end
end
end
end



function c33579962.mattg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33579962.cfilter,tp,LOCATION_HAND,0,1,nil) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
local tc=Duel.SelectMatchingCard(tp,c33579962.cfilter,tp,LOCATION_HAND,0,1,1,nil)
Duel.SetTargetCard(tc)
end
function c33579962.matop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local tc=Duel.GetFirstTarget()
if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
Duel.Overlay(c,tc)
end
end


function c33579962.cfilter2(c,code)
return c:IsFaceup() and c:IsCode(code)
end

function c33579962.con1(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33579962.serketfilter503,tp,LOCATION_MZONE,0,1,nil) then return false
elseif Duel.IsExistingMatchingCard(c33579962.cfilter2,tp,LOCATION_SZONE,0,1,nil,511001305)
and Duel.IsExistingMatchingCard(c33579962.cfilter2,tp,LOCATION_SZONE,0,1,nil,511001306)
then return true		
end
end

function c33579962.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
and Duel.IsPlayerCanSpecialSummonMonster(tp,33569998,0,0x21,2500,2000,6,RACE_FAIRY,ATTRIBUTE_EARTH) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33579962.spop(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
or not Duel.IsPlayerCanSpecialSummonMonster(tp,33569998,0,0x21,2500,2000,6,RACE_FAIRY,ATTRIBUTE_EARTH) then return end
local token=Duel.CreateToken(tp,33569998)
Duel.SpecialSummon(token,0,tp,tp,true,false,POS_FACEUP)
end

function c33579962.serketfilter503(c)
return c:GetCode()==89194033
end

function c33579962.cfilter(c)
return c:IsAbleToRemoveAsCost() and c:IsType(TYPE_MONSTER)
end



function c33579962.aclimit1(e,tp,eg,ep,ev,re,r,rp)
if not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
c33579962[ep]=c33579962[ep]+1
end
function c33579962.aclimit2(e,tp,eg,ep,ev,re,r,rp)
if not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return end
c33579962[ep]=c33579962[ep]-1
end
function c33579962.clear(e,tp,eg,ep,ev,re,r,rp)
c33579962[0]=0
c33579962[1]=0
end
function c33579962.econ(e)
return c33579962[1-e:GetHandlerPlayer()]>=2
end
function c33579962.elimit(e,te,tp)
return te:IsHasType(EFFECT_TYPE_ACTIVATE)
end
