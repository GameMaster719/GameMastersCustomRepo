--Castle of Dark Illusions (Anime)
--scripted by GameMaster(GM)
function c33579944.initial_effect(c)
--facedwn
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_QUICK_O)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetRange(LOCATION_MZONE)
e1:SetOperation(c33579944.op)
e1:SetTarget(c33579944.tg)
e1:SetCondition(c33579944.con)
c:RegisterEffect(e1) 
--Atk
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(EFFECT_UPDATE_ATTACK)
e2:SetRange(LOCATION_MZONE)
e2:SetTargetRange(LOCATION_MZONE,0)
e2:SetValue(c33579944.val1)
c:RegisterEffect(e2)
--Def
local e3=e2:Clone()
e3:SetCode(EFFECT_UPDATE_DEFENSE)
e3:SetValue(c33579944.val2)
c:RegisterEffect(e3)
--atk
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_DELAY)
e4:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
e4:SetRange(LOCATION_MZONE)
e4:SetCountLimit(1)
e4:SetOperation(c33579944.op4)
e4:SetCondition(c33579944.con4)
c:RegisterEffect(e4)
--Destroy all Monsters 
local e5=Effect.CreateEffect(c)
e5:SetDescription(aux.Stringid(33579944,0))
e5:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_QUICK_F)
e5:SetCode(EVENT_DESTROYED)
e5:SetRange(LOCATION_GRAVE)
e5:SetTarget(c33579944.tg5)
e5:SetOperation(c33579944.op5)
e5:SetCondition(c33579944.con5)
c:RegisterEffect(e5)
--cannot select battle target
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_FIELD)
e6:SetRange(LOCATION_MZONE)
e6:SetTargetRange(0,LOCATION_MZONE)
e6:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
e6:SetValue(c33579944.atlimit)
c:RegisterEffect(e6)
--cannot be target
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_FIELD)
e7:SetCode(EFFECT_CANNOT_SELECT_EFFECT_TARGET)
e7:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
e7:SetRange(LOCATION_MZONE)
e7:SetTargetRange(0,0xff)
e7:SetValue(c33579944.etarget)
c:RegisterEffect(e7)
--set MONSTERS in facedwn atk
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e8:SetCode(EVENT_ADJUST)
e8:SetRange(LOCATION_MZONE)
e8:SetOperation(c33579944.op8)
c:RegisterEffect(e8)
end

function c33579944.con(e,tp,eg,ep,ev,re,r,rp)
return not Duel.IsExistingMatchingCard(c33579944.filter10,tp,0,LOCATION_ONFIELD,1,nil) 
end
function c33579944.filter10(c)
return c:IsFaceup() and c:IsCode(72302403)
end

function c33579944.filter5(c)
return c:IsFaceup() and c:IsCode(33579945)
end
function c33579944.con5(e,tp,eg,ep,ev,re,r,rp)
return Duel.IsExistingMatchingCard(c33579944.filter5,tp,LOCATION_ONFIELD,0,1,nil) 
end

function c33579944.etarget(e,re,c)
return c:IsFacedown() and c:IsControler(e:GetHandlerPlayer()) and c:IsLocation(LOCATION_MZONE) and c:IsType(TYPE_MONSTER)
end


function c33579944.op8(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_HAND,0,nil,TYPE_MONSTER)
if g:GetCount()<=0 then return end
local tc=g:GetFirst()
while tc do
	if tc:GetFlagEffect(33579944)==0 then
		tc:RegisterFlagEffect(33579944,RESET_PHASE+PHASE_END,0,1)
		--no tribute
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(10000080,1))
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LIMIT_SET_PROC)
		e1:SetCondition(c33579944.ntcon)
		e1:SetOperation(c33579944.ntop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		--1 tribute
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(10000080,1))
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_LIMIT_SET_PROC)
		e2:SetCondition(c33579944.tcon)
		e2:SetOperation(c33579944.top)
		e2:SetReset(RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		--2 tribute
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetDescription(aux.Stringid(10000080,1))
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_LIMIT_SET_PROC)
		e3:SetCondition(c33579944.ttcon)
		e3:SetOperation(c33579944.ttop)
		e3:SetReset(RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
	tc=g:GetNext()
end		
end

function c33579944.spchk(c)
return c:IsFaceup() and not c:IsStatus(STATUS_DISABLED) and c:GetOriginalCode()==33579944
end

function c33579944.ntcon(e,c)
if c==nil then return true end
return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and c:GetLevel()<=4
end

function c33579944.ntop(e,tp,eg,ep,ev,re,r,rp,c)
if Duel.IsExistingMatchingCard(c33579944.spchk,tp,LOCATION_MZONE,0,1,nil) then
	e:SetTargetRange(POS_FACEDOWN,0)
else
	e:SetTargetRange(POS_FACEDOWN_DEFENSE,0)
end
end

function c33579944.tcon(e,c)
if c==nil then return true end
return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1 and (c:GetLevel()==5 or c:GetLevel()==6) 
	and Duel.GetTributeCount(c)>=1
end

function c33579944.top(e,tp,eg,ep,ev,re,r,rp,c)
if Duel.IsExistingMatchingCard(c33579944.spchk,tp,LOCATION_MZONE,0,1,nil) then
	e:SetTargetRange(POS_FACEDOWN,0)
else
	e:SetTargetRange(POS_FACEDOWN_DEFENSE,0)
end
local g=Duel.SelectTribute(tp,c,1,1)
c:SetMaterial(g)
Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end

function c33579944.ttcon(e,c)
if c==nil then return true end
return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-2 and Duel.GetTributeCount(c)>=2 
	and c:GetLevel()>=7
end

function c33579944.ttop(e,tp,eg,ep,ev,re,r,rp,c)
if Duel.IsExistingMatchingCard(c33579944.spchk,tp,LOCATION_MZONE,0,1,nil) then
	e:SetTargetRange(POS_FACEDOWN,0)
else
	e:SetTargetRange(POS_FACEDOWN_DEFENSE,0)
end
local g=Duel.SelectTribute(tp,c,2,2)
c:SetMaterial(g)
Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end

function c33579944.tg5(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local g=Duel.GetMatchingGroup(c33579944.filter6,tp,LOCATION_MZONE,0,nil)
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c33579944.op5(e,tp,ecg,ep,ev,re,r,rp)
Duel.Destroy(Duel.GetFieldGroup(tp,LOCATION_MZONE,0),REASON_EFFECT)
end	

function c33579944.con4(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==tp
end

function c33579944.filter(c)
return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsCanTurnSet() and c:GetCode()~=62121)
end

function c33579944.filter2(c)
return c:IsFacedown() and c:IsAttackPos()
end

function c33579944.filter6(c,g,pg)
return c:IsType(TYPE_MONSTER) and c:IsDestructable()
end

function c33579944.filter4(c,tp)
return  c:GetPreviousControler()==tp
end

function c33579944.op4(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33579944.filter2,tp,LOCATION_MZONE,0,nill)
if g:GetCount()>0 then
	Duel.ChangePosition(g,POS_FACEUP_ATTACK)
end
end

function c33579944.atlimit(e,c)
return c:IsFacedown()
end

function c33579944.val1(e,c)
local r=c:GetRace()
if bit.band(r,RACE_FIEND+RACE_SPELLCASTER)>0 then return c:GetAttack()*3/10
elseif bit.band(r,RACE_FAIRY)>0 then return -c:GetAttack()*3/10
else return 0 end
end

function c33579944.val2(e,c)
local r=c:GetRace()
if bit.band(r,RACE_FIEND+RACE_SPELLCASTER)>0 then return c:GetDefense()*3/10
elseif bit.band(r,RACE_FAIRY)>0 then return -c:GetDefense()*3/10
else return 0 end
end

function c33579944.tg(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
if chk==0 then return Duel.IsExistingMatchingCard(c33579944.filter,tp,LOCATION_MZONE,0,1,nil)  end 
local g=Duel.GetMatchingGroup(c33579944.filter,tp,LOCATION_MZONE,0,nil)
Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end

function c33579944.op(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33579944.filter,tp,LOCATION_MZONE,0,nil)
if g then
	Duel.ChangePosition(g,POS_FACEDOWN_ATTACK,0,POS_FACEDOWN_DEFENSE,0)
	end
end
