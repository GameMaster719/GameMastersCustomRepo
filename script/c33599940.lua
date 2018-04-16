--Total Defense Shogun (DM)
--Scripted by GameMaster(GM)
function c33599940.initial_effect(c)
	--put into play
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e0:SetCode(EVENT_PREDRAW)
	e0:SetCountLimit(1,300+EFFECT_COUNT_CODE_DUEL)
	e0:SetRange(LOCATION_HAND+LOCATION_DECK)	
	e0:SetTarget(c33599940.tg0)
	e0:SetOperation(c33599940.op0)
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
	e2:SetDescription(aux.Stringid(33599940,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c33599940.spcon)
	e2:SetCountLimit(1)
	e2:SetOperation(c33599940.spop)
	c:RegisterEffect(e2)
	--Lose effect Deck Master
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33599940,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_REMOVED+LOCATION_EXTRA)
	e3:SetProperty(EFFECT_FLAG_REPEAT)
	e3:SetCondition(c33599940.conlose)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetOperation(c33599940.leaveop)
	c:RegisterEffect(e3)
	-- cannot pendulum summon	
	local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_FIELD)
    e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e4:SetRange(LOCATION_PZONE)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e4:SetTargetRange(1,0)
    e4:SetTarget(c33599940.splimit)
    c:RegisterEffect(e4)
	--to defense
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(75372290,0))
	e5:SetCategory(CATEGORY_POSITION)
	e5:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_SUMMON_SUCCESS)
	e5:SetTarget(c33599940.postg)
	e5:SetOperation(c33599940.posop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e6)
	--attack in defense position
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_DEFENSE_ATTACK)
	c:RegisterEffect(e7)
	--destroy
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(51100567,3))
	e8:SetCategory(CATEGORY_DESTROY)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e8:SetCode(EVENT_ATTACK_ANNOUNCE)
	e8:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e8:SetCondition(c33599940.descon)
	e8:SetCost(c33599940.descost)
	e8:SetTarget(c33599940.destg)
	e8:SetOperation(c33599940.desop)
	c:RegisterEffect(e8)
end


--into play
function c33599940.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetTurnCount()==1 and Duel.CheckLocation

(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0 and 
Duel.IsExistingMatchingCard(c33599940.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_HAND+LOCATION_DECK,1,nil) 

end
if Duel.GetFlagEffect(tp,300)~=0 then return false end
if Duel.IsExistingMatchingCard(c33599940.filter,tp,LOCATION_ONFIELD,0,1,nil) then return false end

end


function c33599940.op0(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and 
Duel.GetFlagEffect(tp,300)==0  end
if Duel.GetFlagEffect(tp,300)~=0 then return end
if Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect
(tp,300)==0 then 
Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
Duel.RegisterFlagEffect(tp,300,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
				Duel.Draw(tp,1,REASON_RULE)
end
end
end

--move to field
function c33599940.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end	

function c33599940.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
end


--lose effect
--[511000378-beserk dragon, 13722870-darkflare knight, 49217579--mirage knight,  511013020--fiveheaded dragon ]--

c33599940.collection={ [33599934]=true; [33599935]=true; [33599936]=true;  [33599937]=true; [33599938]=true; [33599939]=true; [33599940]=true;
 [511000378]=true; [13722870]=true; [49217579]=true; [511013020]=true;}

function c33599940.filter(c)
	return c33599940.collection[c:GetCode()] 
end


function c33599940.conlose(e,tp,eg,ep,ev,re,r,rp)
 local g=Duel.GetMatchingGroup(c33599940.filter,tp,LOCATION_ONFIELD,0,nil)   
   return not g:IsExists(c33599940.filter,1,nil)
end

function c33599940.leaveop(e,tp,eg,ep,ev,re,r,rp)
		--victory deck master effect==0x56
		Duel.Win(1-tp,0x56)
end	


--cannot be used for pendulum summon
function c33599940.splimit(e,c,tp,sumtp,sumpos)
    return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end	

--to defense
function c33599940.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end

function c33599940.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end

--pay 1000 destroy attacking monster
function c33599940.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c33599940.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c33599940.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() and tg:IsCanBeEffectTarget(e) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c33599940.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	Duel.Destroy(tc,REASON_EFFECT)
end