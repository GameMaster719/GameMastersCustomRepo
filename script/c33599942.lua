--Rose Duel rose star coutners
--scipted by GameMaster(GM)
function c33599942.initial_effect(c)
aux.EnablePendulumAttribute(c,true)
c:EnableCounterPermit(0x13A)
c:SetCounterLimit(0x13A,12)
--put into play
local e0=Effect.CreateEffect(c)
e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e0:SetCode(EVENT_PHASE_START+PHASE_STANDBY)
e0:SetCountLimit(1,600+EFFECT_COUNT_CODE_DUEL)
e0:SetRange(LOCATION_HAND+LOCATION_DECK)	
e0:SetTarget(c33599942.tg0)
e0:SetOperation(c33599942.op0)
c:RegisterEffect(e0)
--special summon
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetDescription(aux.Stringid(33599941,5))
e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
e1:SetHintTiming(0,TIMING_MAIN_END)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_PZONE)
e1:SetCost(c33599942.cost3)
e1:SetTarget(c33599942.tg3)
e1:SetOperation(c33599942.op3)
e1:SetCountLimit(1)
c:RegisterEffect(e1)
--add counter custom total
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33599941,0))
e2:SetCategory(CATEGORY_COUNTER)
e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e2:SetRange(LOCATION_PZONE)
e2:SetCountLimit(1)
e2:SetLabelObject(e0)
e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
e2:SetCondition(c33599942.ctcon)
e2:SetOperation(c33599942.ctop)
c:RegisterEffect(e2)
--summon procedure
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetCode(EFFECT_SUMMON_PROC)
e3:SetRange(LOCATION_PZONE)
e3:SetTargetRange(LOCATION_HAND,0)
e3:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_MONSTER))
e3:SetCondition(c33599942.ntcon)
c:RegisterEffect(e3)
local e4=e3:Clone()
e4:SetCode(EFFECT_SET_PROC)
c:RegisterEffect(e4)
--remove coutners
local e5=Effect.CreateEffect(c)
e5:SetDescription(aux.Stringid(33599941,0))
e5:SetCategory(CATEGORY_RECOVER)
e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e5:SetCode(EVENT_SUMMON_SUCCESS)
e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e5:SetRange(LOCATION_PZONE)
e5:SetCondition(c33599942.con5)
e5:SetTarget(c33599942.tg5)
e5:SetOperation(c33599942.op5)
c:RegisterEffect(e5)
--cannot be destroyed
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
e6:SetRange(LOCATION_PZONE)
e6:SetValue(1)
c:RegisterEffect(e6)
--summon count limit
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_FIELD)
e7:SetCode(EFFECT_CANNOT_SUMMON)
e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e7:SetTargetRange(1,0)
e7:SetRange(LOCATION_PZONE)
c:RegisterEffect(e7)
local e8=e7:Clone()
e8:SetCode(EFFECT_CANNOT_MSET)
c:RegisterEffect(e8)

local e9=e6:Clone()
e9:SetCode(EFFECT_CANNOT_REMOVE)
c:RegisterEffect(e9)
local e10=e9:Clone()
e10:SetCode(EFFECT_CANNOT_DISABLE)
c:RegisterEffect(e10)
local e11=e10:Clone()
e11:SetCode(EFFECT_CANNOT_TO_GRAVE)
c:RegisterEffect(e11)
local e12=e11:Clone()
e12:SetCode(EFFECT_CANNOT_TO_HAND)
c:RegisterEffect(e12)
local e13=e12:Clone()
e13:SetCode(EFFECT_CANNOT_TO_DECK)
c:RegisterEffect(e13)
local e14=e13:Clone()
e14:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
c:RegisterEffect(e14)
-- cannot pendulum summon	
local e15=Effect.CreateEffect(c)
e15:SetType(EFFECT_TYPE_FIELD)
e15:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
e15:SetRange(LOCATION_PZONE)
e15:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e15:SetTargetRange(1,0)
e15:SetTarget(c33599942.splimit)
c:RegisterEffect(e15)
--add counter normal total 3
local e16=Effect.CreateEffect(c)
e16:SetDescription(aux.Stringid(33599941,0))
e16:SetCategory(CATEGORY_COUNTER)
e16:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e16:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e16:SetRange(LOCATION_PZONE)
e16:SetCountLimit(1)
e16:SetCode(EVENT_PHASE+PHASE_STANDBY)
e16:SetCondition(c33599942.ctcon2)
e16:SetOperation(c33599942.ctop2)
c:RegisterEffect(e16)
--immune
local e17=Effect.CreateEffect(c)
e17:SetType(EFFECT_TYPE_SINGLE)
e17:SetCode(EFFECT_IMMUNE_EFFECT)
e17:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e17:SetRange(LOCATION_PZONE)
e17:SetValue(1)
c:RegisterEffect(e17)
	local e18=Effect.CreateEffect(c)
	e18:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e18:SetType(EFFECT_TYPE_SINGLE)
	e18:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e18:SetRange(LOCATION_PZONE)
	e18:SetValue(1)
	c:RegisterEffect(e18)
end
function c33599942.splimit(e,c,tp,sumtp,sumpos)
return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end	

function c33599942.con5(e,c,tp)
local ct=e:GetHandler():GetCounter(0x13A)
return Duel.GetTurnPlayer()==tp and c:IsLevelBelow(ct)
end

function c33599942.tg5(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetTargetCard(eg)
end

function c33599942.op5(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x13A,nil,REASON_COST) end
if not e:GetHandler():IsRelateToEffect(e) then return end
local tc=eg:GetFirst()
if tc:IsRelateToEffect(e) and tc:IsFaceup() then
e:GetHandler():RemoveCounter(tp,0x13A,tc:GetLevel(),REASON_COST)

end
end

function c33599942.ntcon(e,c,minc)
local ct=e:GetHandler():GetCounter(0x13A)
if c==nil then return true end
return minc==0 and c:GetLevel()>4 and c:IsLevelBelow(ct) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end

function c33599942.count(e,c)
return not  e:GetHandler()
end



function c33599942.cost3(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x13A,nil,REASON_COST) and Duel.GetActivityCount(tp,ACTIVITY_NORMALSUMMON)==0 end
local ct=e:SetLabel(e:GetHandler():GetCounter(0x13A))

end


function c33599942.filter4(c,e,tp,lv)
local ct=e:GetHandler():GetCounter(0x13A)

return  c:IsLevelBelow(ct) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) or (c:IsSummonable(true,nil) or c:IsMSetable(true,nil))  
end
function c33599942.tg3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_HAND) and c33599942.filter4(chkc,e,tp) end
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c33599942.filter4,tp,LOCATION_HAND,0,1,nil,e,tp) end
Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
e:GetHandler():RegisterFlagEffect(33599941,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end

function c33599942.op3(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
local g=Duel.SelectTarget(tp,c33599942.filter4,tp,LOCATION_HAND,0,1,1,nil,e,tp)
Duel.SetOperationInfo(0,CATEGORY_SUMMON,g,1,0,0)
local tc=g:GetFirst()
if tc then
	local s1=tc:IsSummonable(true,nil)
	local s2=tc:IsMSetable(true,nil)
	if (s1 and s2 and Duel.SelectPosition(tp,tc,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)==POS_FACEUP_ATTACK) or not s2 then
	Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,c:GetBattlePosition(),true)
end
end
e:GetHandler():RemoveCounter(tp,0x13A,tc:GetLevel(),REASON_COST)
e:GetHandler():RegisterFlagEffect(33599941,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
Duel.ShuffleHand(tp)
end



function c33599942.filter(c)
return c:IsCode(33599941)
end

--into play
function c33599942.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetTurnCount()==1 and Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) 
and Duel.GetFlagEffect(tp,600)==0 and Duel.IsExistingMatchingCard(c33599942.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil) end
if Duel.GetFlagEffect(tp,600)~=0 then return false end
if Duel.IsExistingMatchingCard(c33599942.filter,tp,LOCATION_ONFIELD,0,1,nil) then return false end

end


function c33599942.op0(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,600)==0  end
if Duel.GetFlagEffect(tp,600)~=0 then return end
if Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect(tp,600)==0 then 
Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
--thanks to MLD pointers with setlabel
if  Duel.SelectYesNo(tp,aux.Stringid(33599941,2))  then 
count=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12)
Duel.RegisterFlagEffect(tp,800,EFFECT_FLAG_NO_TURN_RESET,0,1)
Duel.RegisterFlagEffect(1-tp,800,EFFECT_FLAG_NO_TURN_RESET,0,1)
local p=Duel.GetTurnPlayer()
Duel.Hint(HINT_CARD,0,33599942)
e:SetLabel(count)
--how to make your card declare a choice/number selected
e:GetHandler():SetHint(CHINT_NUMBER,count)
else 
e:SetLabel(3)
--how to make your card declare a choice/number selected
e:GetHandler():SetHint(CHINT_NUMBER,3)
end
if e:GetHandler():IsPreviousLocation(LOCATION_HAND+LOCATION_DECK) then
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Draw(p,d,REASON_EFFECT)
end
end 

function c33599942.ctcon2(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==tp and Duel.GetFlagEffect(tp,800)==0
end

function c33599942.ctop2(e,tp,eg,ep,ev,re,r,rp)
local count=e:GetHandler():GetCounter(0x13A)
if count==11 then 
e:GetHandler():AddCounter(0x13A,1)
elseif count==10 then 
e:GetHandler():AddCounter(0x13A,2)
else 
e:GetHandler():AddCounter(0x13A,3)
end
end


function c33599942.ctcon(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==tp and Duel.GetFlagEffect(tp,800)>0 
end

function c33599942.ctop(e,tp,eg,ep,ev,re,r,rp)
local countmax=12
local count=e:GetHandler():GetCounter(0x13A)
--credit to MLD for helping with setlabel
local val2=e:GetLabelObject():GetLabel()
if e:GetHandler():IsCanAddCounter(0x13A,val2)then 
e:GetHandler():AddCounter(0x13A,val2)
else
local count2=e:GetHandler():GetCounter(0x13A)
local ct=12-count2
if ct>0 and e:GetHandler():IsCanAddCounter(0x13A,ct) then 
e:GetHandler():AddCounter(0x13A,ct)
Duel.RegisterFlagEffect(tp,33599941,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
end
end

