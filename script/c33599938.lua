--Deepsea Warrior (DM)
--Scripted by GameMaster
function c33599938.initial_effect(c)
--put into play
local e0=Effect.CreateEffect(c)
e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
e0:SetCode(EVENT_PREDRAW)
e0:SetCountLimit(1,300+EFFECT_COUNT_CODE_DUEL)
e0:SetRange(LOCATION_HAND+LOCATION_DECK)	
e0:SetTarget(c33599938.tg0)
e0:SetOperation(c33599938.op0)
c:RegisterEffect(e0)
--immune
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetCode(EFFECT_IMMUNE_EFFECT)
e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e1:SetRange(LOCATION_PZONE)
e1:SetValue(1)
c:RegisterEffect(e1)
--Move to Field
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33599938,0))
e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
e2:SetType(EFFECT_TYPE_QUICK_O)
e2:SetCode(EVENT_FREE_CHAIN)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e2:SetRange(LOCATION_PZONE)
e2:SetCondition(c33599938.spcon)
e2:SetCountLimit(1)
e2:SetOperation(c33599938.spop)
c:RegisterEffect(e2)
--Lose effect Deck Master
local e3=Effect.CreateEffect(c)
e3:SetDescription(aux.Stringid(33599938,0))
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e3:SetRange(LOCATION_REMOVED+LOCATION_EXTRA)
e3:SetProperty(EFFECT_FLAG_REPEAT)
e3:SetCondition(c33599938.conlose)
e3:SetCode(EVENT_PHASE+PHASE_END)
e3:SetOperation(c33599938.leaveop)
c:RegisterEffect(e3)
-- cannot pendulum summon	
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_FIELD)
e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
e4:SetRange(LOCATION_PZONE)
e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
e4:SetTargetRange(1,0)
e4:SetTarget(c33599938.splimit)
c:RegisterEffect(e4)
--immune spell
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_SINGLE)
e5:SetCode(EFFECT_IMMUNE_EFFECT)
e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e5:SetRange(LOCATION_MZONE)
e5:SetCondition(c33599938.econ)
e5:SetValue(c33599938.efilter)
c:RegisterEffect(e5)
--battle target
local e6=Effect.CreateEffect(c)
e6:SetCategory(CATEGORY_DAMAGE)
e6:SetDescription(aux.Stringid(51100567,4))
e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
e6:SetCode(EVENT_BE_BATTLE_TARGET)
e6:SetRange(LOCATION_PZONE+LOCATION_MZONE)
e6:SetCost(c33599938.cbcost)
e6:SetCondition(c33599938.cbcon)
e6:SetOperation(c33599938.cbop)
c:RegisterEffect(e6)
end
	
	
function c33599938.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end	

function c33599938.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
end

--[511000378-beserk dragon, 13722870-darkflare knight, 49217579--mirage knight,  511013020--fiveheaded dragon ]--

c33599938.collection={ [33599934]=true; [33599935]=true; [33599936]=true;  [33599937]=true; [33599938]=true; [33599939]=true; [33599940]=true;
 [511000378]=true; [13722870]=true; [49217579]=true; [511013020]=true;}

function c33599938.filter(c)
	return c33599938.collection[c:GetCode()] 
end


function c33599938.conlose(e,tp,eg,ep,ev,re,r,rp)
 local g=Duel.GetMatchingGroup(c33599938.filter,tp,LOCATION_ONFIELD,0,nil)   
   return not g:IsExists(c33599938.filter,1,nil)
end

function c33599938.splimit(e,c,tp,sumtp,sumpos)
    return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end	

function c33599938.leaveop(e,tp,eg,ep,ev,re,r,rp)
		--victory deck master effect==0x56
		Duel.Win(1-tp,0x56)
end	



function c33599938.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetTurnCount()==1 and Duel.CheckLocation

(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0 and 
Duel.IsExistingMatchingCard(c33599938.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_HAND+LOCATION_DECK,1,nil) 

end
if Duel.GetFlagEffect(tp,300)~=0 then return false end
if Duel.IsExistingMatchingCard(c33599938.filter,tp,LOCATION_ONFIELD,0,1,nil) then return false end

end


function c33599938.op0(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and 

Duel.GetFlagEffect(tp,300)==0  end
if Duel.GetFlagEffect(tp,300)~=0 then return end
if Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect

(tp,300)==0 then 
local sg=Duel.GetMatchingGroup(c33599938.filter,tp,LOCATION_HAND+LOCATION_DECK,LOCATION_DECK+LOCATION_HAND,nil)
Duel.ConfirmCards(tp,sg)
Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
Duel.RegisterFlagEffect(tp,300,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
				Duel.Draw(tp,1,REASON_RULE)
end
end
end

	
	
	
	
function c33599938.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c33599938.filter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end
function c33599938.econ(e)
	return Duel.IsExistingMatchingCard(c33599938.filter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end
function c33599938.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c33599938.cbcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,2,e:GetHandler()) end
	local g=Duel.SelectReleaseGroup(tp,nil,2,2,e:GetHandler())
	Duel.Release(g,REASON_COST)
end
function c33599938.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return bt:GetControler()==c:GetControler() 
end
function c33599938.cbop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetAttacker()
	if Duel.NegateAttack() then
		Duel.Damage(1-tp,tg:GetAttack(),REASON_EFFECT)
	end
end
