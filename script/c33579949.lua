--Cursed Twin Dolls
--scripted by GameMaster(GM)
function c33579949.initial_effect(c)
c:SetUniqueOnField(1,1,33579949)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33579949.cointg)
e1:SetOperation(c33579949.coinop)
c:RegisterEffect(e1)
end


function c33579949.descon(e,tp,eg,ep,ev,re,r,rp)
local tc=e:GetLabelObject()
if tc:GetFlagEffect(33579949)~=0 then
local c=e:GetHandler()
		return c:GetCode(33579949) and c:IsFacedown()
else
	e:Reset()
	return false
end
end
function c33579949.desop(e,tp,eg,ep,ev,re,r,rp)
local tc=e:GetLabelObject()
Duel.Destroy(tc,REASON_EFFECT)
end


function c33579949.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c33579949.cfilter(c)
return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemove()
end


function c33579949.con888(e,c)
local c=e:GetHandler()
return not c:GetReasonCard()==33579949
end


function c33579949.tg111(e,c)
return c:GetOwner()==e:GetHandlerPlayer() and not c:IsType(TYPE_MONSTER)
end
function c33579949.tg222(e,c)
return c:GetOwner()~=e:GetHandlerPlayer() and not c:IsType(TYPE_MONSTER)
end

function c33579949.tokenfilter555(c)
return c:IsFaceup() and c:IsCode(15259703)
end

function c33579949.filter620(c)
return c:IsFaceup() and c:IsCode(22222234)
end


function c33579949.sdcon0(e,c)
if  c==nil then return false end
local tp=c:GetControler()
return Duel.IsExistingMatchingCard(c33579949.tokenfilter555,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil) 
end


function c33579949.coinop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local op=Duel.SelectOption(1-tp,aux.Stringid(33579949,0),aux.Stringid(33579949,1))
Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(33579949,2))
if ( op==1) then
if c and c:IsLocation(LOCATION_GRAVE) or c:IsLocation(LOCATION_HAND) or c:IsLocation(LOCATION_DECK) then return end
local sg=Group.CreateGroup()
if Duel.IsExistingMatchingCard(c33579949.filter620,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) then return false end
local token=Duel.CreateToken(tp,22222234)
Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
sg:AddCard(token)
sg:KeepAlive()
token:RegisterFlagEffect(33579949,RESET_EVENT+0x1fe0000,0,1)
local e20=Effect.CreateEffect(e:GetHandler())
e20:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e20:SetCode(EVENT_ADJUST)
e20:SetCountLimit(1)
e20:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e20:SetLabelObject(token)
e20:SetCondition(c33579949.descon)
e20:SetOperation(c33579949.desop)
Duel.RegisterEffect(e20,tp)
e:GetHandler():SetCardTarget(token) -- sets tc as target of card c
	
	--token
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e0:SetCode(EVENT_SPSUMMON_SUCCESS)
e0:SetRange(LOCATION_MZONE)	
e0:SetCondition(c33579949.sdescon321)
e0:SetOperation(c33579949.sdesop321)
token:RegisterEffect(e0)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK)
e1:SetReset(RESET_EVENT+0x1fe0000)
token:RegisterEffect(e1,true)
local e2=e1:Clone()
e2:SetCode(EFFECT_CANNOT_TRIGGER)
token:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_UNRELEASABLE_SUM)
e3:SetValue(1)
e3:SetReset(RESET_EVENT+0x1fe0000)
token:RegisterEffect(e3,true)
local e4=e3:Clone()
e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
token:RegisterEffect(e4,true)
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
e5:SetValue(1)
token:RegisterEffect(e5,true)
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
e6:SetValue(1)
e6:SetReset(RESET_EVENT+0x1fe0000)
token:RegisterEffect(e6)
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_SINGLE)
e7:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
e7:SetValue(1)
token:RegisterEffect(e7)
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e8:SetRange(LOCATION_MZONE)
e8:SetCode(EFFECT_IMMUNE_EFFECT)
e8:SetReset(RESET_EVENT+0x1fe0000)
e8:SetValue(1)
token:RegisterEffect(e8)
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetCode(EFFECT_DISABLE)
e9:SetValue(1)
token:RegisterEffect(e9)
--destroy
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e10:SetRange(LOCATION_MZONE)
e10:SetCode(EVENT_LEAVE_FIELD)
e10:SetCondition(c33579949.sdescon123)
e10:SetOperation(c33579949.sdesop123)
token:RegisterEffect(e10)
--cannot be target
local e11=Effect.CreateEffect(c)
e11:SetType(EFFECT_TYPE_SINGLE)
e11:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e11:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IMMEDIATELY_APPLY)
e11:SetRange(LOCATION_MZONE)
e11:SetValue(1)
token:RegisterEffect(e11)
local e12=Effect.CreateEffect(c)
e12:SetType(EFFECT_TYPE_SINGLE)
e12:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
e12:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IMMEDIATELY_APPLY)
e12:SetRange(LOCATION_MZONE)
e12:SetValue(1)
token:RegisterEffect(e12)
token:SetStatus(STATUS_NO_LEVEL,true)
--recover for cards if no cursebox
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e0:SetCode(EVENT_TO_GRAVE)
e0:SetRange(LOCATION_SZONE)
e0:SetOperation(c33579949.recop1)
e0:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e0)
--remove
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
e1:SetRange(LOCATION_SZONE)
e1:SetTargetRange(0xff,0)
e1:SetValue(LOCATION_REMOVED)
e1:SetTarget(c33579949.tg111)
e1:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e1)
--cards in grave cannot activate
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e2:SetCode(EFFECT_CANNOT_ACTIVATE)
e2:SetRange(LOCATION_SZONE)
e2:SetTargetRange(1,0)
e2:SetValue(c33579949.aclimit)
c:RegisterEffect(e2)
--necro valley
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetCode(EFFECT_NECRO_VALLEY)
e3:SetRange(LOCATION_SZONE)
e3:SetTargetRange(LOCATION_GRAVE,0)
c:RegisterEffect(e3)
--cannot send cards from deck to grave
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_FIELD)
e4:SetCode(EFFECT_CANNOT_DISCARD_DECK)
e4:SetRange(LOCATION_SZONE)
e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e4:SetTargetRange(1,0)
c:RegisterEffect(e4)
--special summon condition
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetCode(EFFECT_SPSUMMON_CONDITION)
e5:SetRange(LOCATION_SZONE)
e5:SetTargetRange(LOCATION_GRAVE,0)
e5:SetValue(aux.FALSE)
c:RegisterEffect(e5)
--cannot to to grave
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_FIELD)
e7:SetCode(EFFECT_CANNOT_TO_GRAVE)
e7:SetRange(LOCATION_SZONE)
e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e7:SetTargetRange(1,0)
c:RegisterEffect(e7)
--cannot to remove
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_FIELD)
e8:SetCode(EFFECT_CANNOT_REMOVE)
e8:SetRange(LOCATION_SZONE)
e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e8:SetTargetRange(LOCATION_GRAVE,0)
e8:SetCondition(c33579949.con888)
c:RegisterEffect(e8)
--cannot to discard hand
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_FIELD)
e9:SetCode(EFFECT_CANNOT_DISCARD_HAND)
e9:SetRange(LOCATION_SZONE)
e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e9:SetTargetRange(1,0)
c:RegisterEffect(e9)
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_FIELD)
e10:SetCode(EFFECT_CANNOT_USE_AS_COST)
e10:SetTargetRange(LOCATION_GRAVE,0)
e10:SetTarget(c33579949.tg10)
c:RegisterEffect(e10)
--Cannot target
local e11=Effect.CreateEffect(c)
e11:SetType(EFFECT_TYPE_FIELD)
e11:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e11:SetRange(LOCATION_SZONE)
e11:SetTargetRange(LOCATION_GRAVE,0)
e11:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_MONSTER))
e11:SetValue(c33579949.value11)
c:RegisterEffect(e11)
local g=Duel.GetMatchingGroup(c33579949.cfilter,tp,LOCATION_GRAVE,0,nil)
Duel.Remove(g,POS_FACEUP,REASON_COST)
else if ( op==0) then 
if c and c:IsLocation(LOCATION_GRAVE) or c:IsLocation(LOCATION_HAND) or c:IsLocation(LOCATION_DECK) then return end
local sg=Group.CreateGroup()
local token=Duel.CreateToken(tp,22222234)
Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP_ATTACK)
sg:AddCard(token)
sg:KeepAlive()
token:RegisterFlagEffect(33579949,RESET_EVENT+0x1fe0000,0,1)
local e20=Effect.CreateEffect(e:GetHandler())
e20:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e20:SetCode(EVENT_ADJUST)
e20:SetCountLimit(1)
e20:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e20:SetLabelObject(token)
e20:SetCondition(c33579949.descon)
e20:SetOperation(c33579949.desop)
Duel.RegisterEffect(e20,tp)
e:GetHandler():SetCardTarget(token) -- sets tc as target of card c
--token
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e0:SetCode(EVENT_SPSUMMON_SUCCESS)
e0:SetRange(LOCATION_MZONE)	
e0:SetCondition(c33579949.sdescon321)
e0:SetOperation(c33579949.sdesop321)
token:RegisterEffect(e0)
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_CANNOT_ATTACK)
e1:SetReset(RESET_EVENT+0x1fe0000)
token:RegisterEffect(e1,true)
local e2=e1:Clone()
e2:SetCode(EFFECT_CANNOT_TRIGGER)
token:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetCode(EFFECT_UNRELEASABLE_SUM)
e3:SetValue(1)
e3:SetReset(RESET_EVENT+0x1fe0000)
token:RegisterEffect(e3,true)
local e4=e3:Clone()
e4:SetCode(EFFECT_UNRELEASABLE_NONSUM)
token:RegisterEffect(e4,true)
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
e5:SetValue(1)
token:RegisterEffect(e5,true)
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_SINGLE)
e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
e6:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
e6:SetValue(1)
e6:SetReset(RESET_EVENT+0x1fe0000)
token:RegisterEffect(e6)
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_SINGLE)
e7:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e7:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
e7:SetValue(1)
token:RegisterEffect(e7)
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_SINGLE)
e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e8:SetRange(LOCATION_MZONE)
e8:SetCode(EFFECT_IMMUNE_EFFECT)
e8:SetReset(RESET_EVENT+0x1fe0000)
e8:SetValue(1)
token:RegisterEffect(e8)
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_SINGLE)
e9:SetCode(EFFECT_DISABLE)
e9:SetValue(1)
token:RegisterEffect(e9)
--destroy
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e10:SetRange(LOCATION_MZONE)
e10:SetCode(EVENT_LEAVE_FIELD)
e10:SetCondition(c33579949.sdescon123)
e10:SetOperation(c33579949.sdesop123)
token:RegisterEffect(e10)
--cannot be target
local e11=Effect.CreateEffect(c)
e11:SetType(EFFECT_TYPE_SINGLE)
e11:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e11:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IMMEDIATELY_APPLY)
e11:SetRange(LOCATION_MZONE)
e11:SetValue(1)
token:RegisterEffect(e11)
local e12=Effect.CreateEffect(c)
e12:SetType(EFFECT_TYPE_SINGLE)
e12:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
e12:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IMMEDIATELY_APPLY)
e12:SetRange(LOCATION_MZONE)
e12:SetValue(1)
token:RegisterEffect(e12)
token:SetStatus(STATUS_NO_LEVEL,true)
--recover for spellcards if no cursebox
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e0:SetCode(EVENT_TO_GRAVE)
e0:SetRange(LOCATION_SZONE)
e0:SetOperation(c33579949.recop2)
e0:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e0)
--remove spells/traps
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
e1:SetRange(LOCATION_SZONE)
e1:SetTargetRange(0,0xff)
e1:SetValue(LOCATION_REMOVED)
e1:SetTarget(c33579949.tg222)
e1:SetReset(RESET_EVENT+0x1fe0000)
c:RegisterEffect(e1)
--cards in grave cannot activate
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e2:SetCode(EFFECT_CANNOT_ACTIVATE)
e2:SetRange(LOCATION_SZONE)
e2:SetTargetRange(0,1)
e2:SetValue(c33579949.aclimit)
c:RegisterEffect(e2)
--necro valley
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetCode(EFFECT_NECRO_VALLEY)
e3:SetRange(LOCATION_SZONE)
e3:SetTargetRange(0,LOCATION_GRAVE)
c:RegisterEffect(e3)
--cannot send cards from deck to grave
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_FIELD)
e4:SetCode(EFFECT_CANNOT_DISCARD_DECK)
e4:SetRange(LOCATION_SZONE)
e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
c:RegisterEffect(e4)
--special summon condition
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetCode(EFFECT_SPSUMMON_CONDITION)
e5:SetRange(LOCATION_SZONE)
e5:SetTargetRange(0,LOCATION_GRAVE)
e5:SetValue(aux.FALSE)
c:RegisterEffect(e5)
--cannot to deck
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_FIELD)
e7:SetCode(EFFECT_CANNOT_TO_GRAVE)
e7:SetRange(LOCATION_SZONE)
e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e7:SetTargetRange(0,1)
c:RegisterEffect(e7)
--cannot to remove
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_FIELD)
e8:SetCode(EFFECT_CANNOT_REMOVE)
e8:SetRange(LOCATION_SZONE)
e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e8:SetTargetRange(0,LOCATION_GRAVE)	
e8:SetCondition(c33579949.con888)
c:RegisterEffect(e8)
--cannot to to discard hand
local e9=Effect.CreateEffect(c)
e9:SetType(EFFECT_TYPE_FIELD)
e9:SetCode(EFFECT_CANNOT_DISCARD_HAND)
e9:SetRange(LOCATION_SZONE)
e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e9:SetTargetRange(0,1)
c:RegisterEffect(e9)
local e10=Effect.CreateEffect(c)
e10:SetType(EFFECT_TYPE_FIELD)
e10:SetCode(EFFECT_CANNOT_USE_AS_COST)
e10:SetTargetRange(0,LOCATION_GRAVE)
e10:SetTarget(c33579949.tg10)
c:RegisterEffect(e10)
--Cannot target
local e11=Effect.CreateEffect(c)
e11:SetType(EFFECT_TYPE_FIELD)
e11:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
e11:SetRange(LOCATION_SZONE)
e11:SetTargetRange(0,LOCATION_GRAVE)
e11:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_MONSTER))
e11:SetValue(c33579949.value11)
c:RegisterEffect(e11)		
local g=Duel.GetMatchingGroup(c33579949.cfilter,1-tp,LOCATION_GRAVE,0,nil)
Duel.Remove(g,POS_FACEUP,REASON_COST)
end
end 
end


function c33579949.value11(e,re,rp)
return re:IsActiveType(TYPE_MONSTER) 
end

function c33579949.tg10(e,c)
return c:IsType(TYPE_MONSTER)
end

function c33579949.filter1(c,tp)
return c:GetOwner()==1-tp
end
function c33579949.recop1(e,tp,eg,ep,ev,re,r,rp)
local d1=eg:FilterCount(c33579949.filter1,nil,tp)*200
Duel.Recover(1-tp,d1,REASON_EFFECT)
end
function c33579949.filter2(c,tp)
return c:GetOwner()==tp
end
function c33579949.recop2(e,tp,eg,ep,ev,re,r,rp)
local d1=eg:FilterCount(c33579949.filter2,nil,tp)*200
Duel.Recover(tp,d1,REASON_EFFECT)
end
function c33579949.filter(c)
return c:IsType(TYPE_MONSTER)
end


function c33579949.sfilter(c)
return c:IsPreviousPosition(POS_FACEUP) and c:GetOriginalCode()==33579949 and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c33579949.sdescon123(e,tp,eg,ep,ev,re,r,rp)
return eg:IsExists(c33579949.sfilter,1,nil)
end
function c33579949.sdesop123(e,tp,eg,ep,ev,re,r,rp)
Duel.Destroy(e:GetHandler(),REASON_RULE)
end



function c33579949.aclimit(e,re,tp)
local loc=re:GetActivateLocation()
return loc==LOCATION_GRAVE  and re:IsActiveType(TYPE_MONSTER)
end

function c33579949.sfilter2(c)
return   c:IsPreviousPosition(POS_FACEUP) and c:GetOriginalCode()==33579949 and c:IsPreviousLocation(LOCATION_ONFIELD)
end

function c33579949.sdescon321(e,tp,eg,ep,ev,re,r,rp)
return eg:IsExists(c33579949.sfilter2,1,nil)
end
function c33579949.sdesop321(e,tp,eg,ep,ev,re,r,rp)
Duel.Destroy(e:GetHandler(),REASON_RULE)
end
