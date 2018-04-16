--Zigeddi Dalk
function c33579910.initial_effect(c)
--spsummon from deck when direct attacked
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(33579910,0))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DELAY)
e1:SetCode(EVENT_ATTACK_ANNOUNCE)
e1:SetRange(LOCATION_DECK)
e1:SetCost(c33579910.cost)
e1:SetCondition(c33579910.spcon)
e1:SetTarget(c33579910.sptg)
e1:SetOperation(c33579910.spop)
e1:SetCountLimit(1)
c:RegisterEffect(e1) 
--summon faceup pend. vanish
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e2:SetCode(EVENT_SPSUMMON_SUCCESS)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
e2:SetRange(LOCATION_MZONE)
e2:SetOperation(c33579910.op)
e2:SetTarget(c33579910.tg)
c:RegisterEffect(e2)
-- Cannot Banish (Loyalty to controller)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_SINGLE)
e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e3:SetCode(EFFECT_CANNOT_REMOVE)
e3:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
c:RegisterEffect(e3)
--return to deck
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
e4:SetCategory(CATEGORY_TODECK)
e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
e4:SetRange(LOCATION_GRAVE)
e4:SetCondition(c33579910.con2)
e4:SetTarget(c33579910.target1)
e4:SetOperation(c33579910.operation1)
e4:SetCountLimit(1)
c:RegisterEffect(e4)	
--if dalk has icecounter vanish her
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_QUICK_F)
e5:SetCode(EVENT_BATTLE_CONFIRM)
e5:SetOperation(c33579910.vanop5)
e5:SetCondition(c33579910.vancon5)
c:RegisterEffect(e5)

end


function c33579910.vanop5(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()  
if c:GetCounter(0x1015)>0 and c:IsCode(33579910)  then 
local c=e:GetHandler()
Duel.Remove(c,POS_FACEUP,REASON_EFFECT,tp)
Duel.SendtoDeck(c,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
end
end



function c33579910.vancon5(e,c)
local c=e:GetHandler()
if  c:GetCounter(0x1015)>0 then return true
else return false
end
end

function c33579910.con2(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,33579910)
end
function c33579910.target1(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return e:GetHandler():IsAbleToDeck() end
Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c33579910.operation1(e,tp,eg,ep,ev,re,r,rp)
if e:GetHandler():IsRelateToEffect(e) then
local c=e:GetHandler()
Duel.SendtoDeck(c,tp,2,REASON_EFFECT)
end
end

function c33579910.cost(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
if chk==0 then return Duel.CheckLPCost(tp,100) and (c:IsAttackAbove(100) or c:IsDefenseAbove(100)) end
local maxc=Duel.GetLP(tp)
local maxpay=c:GetAttack()
local def=c:GetDefense()
if maxpay<def then maxpay=def end
if maxpay<maxc then maxc=maxpay end
if maxc>5000 then maxc=5000 end
maxc=math.floor(maxc/100)*100
local t={}
for i=1,maxc/100 do
	t[i]=i*100
end
local cost=Duel.AnnounceNumber(tp,table.unpack(t))
Duel.PayLPCost(tp,cost)
e:SetLabel(cost)
end

function c33579910.tg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end

function c33579910.filter(c)
return c:IsType(TYPE_PENDULUM) and (c:IsFaceup() and c:IsAbleToRemove())
end

function c33579910.op(e,tp,eg,ep,ev,re,r,rp) 
local sg=Duel.GetMatchingGroup(c33579910.filter,1-tp,LOCATION_EXTRA,1,nil)
local tc=sg:GetFirst()
sg:RemoveCard(e:GetHandler())
if sg:GetCount()==0 then return end
Duel.SendtoDeck(sg,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
sg:KeepAlive()
end


function c33579910.spcon(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c33579910.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c33579910.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
	Duel.ChangeAttackTarget(c)
local val=e:GetLabel()
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_UPDATE_ATTACK)
e1:SetValue(val)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EFFECT_UPDATE_DEFENSE)
c:RegisterEffect(e2)
		   end
end