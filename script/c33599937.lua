--Jinzo (DM)
--Scripted by GameMaster(GM)
function c33599937.initial_effect(c)
--put into play
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e0:SetCode(EVENT_PREDRAW)
	e0:SetCountLimit(1,300+EFFECT_COUNT_CODE_DUEL)
	e0:SetRange(LOCATION_HAND+LOCATION_DECK)	
	e0:SetTarget(c33599937.tg0)
	e0:SetOperation(c33599937.op0)
	c:RegisterEffect(e0)
	--cannot activate facedown traps 
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_TRIGGER)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e1:SetTargetRange(0,0xa)
	e1:SetTarget(c33599937.distg)
	c:RegisterEffect(e1)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e2:SetTargetRange(0,LOCATION_SZONE)
	e2:SetTarget(c33599937.distg)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e3:SetOperation(c33599937.disop)
	c:RegisterEffect(e3)
	--disable trap monster
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e4:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(c33599937.distg)
	c:RegisterEffect(e4)
	--immune
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IMMUNE_EFFECT)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_PZONE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	--Move to Field
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33599937,0))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetRange(LOCATION_PZONE)
	e6:SetCondition(c33599937.spcon)
	e6:SetCountLimit(1,33599937+EFFECT_COUNT_CODE_DUEL)
	e6:SetOperation(c33599937.spop)
	c:RegisterEffect(e6)
	--Lose effect Deck Master
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(33599937,0))
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetRange(LOCATION_REMOVED+LOCATION_EXTRA)
	e7:SetProperty(EFFECT_FLAG_REPEAT)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetCondition(c33599937.conlose)
	e7:SetOperation(c33599937.leaveop)
	c:RegisterEffect(e7)
	--negate and destroy
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(51100567,10))
	e8:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e8:SetType(EFFECT_TYPE_QUICK_F)
	e8:SetCode(EVENT_CHAINING)
	e8:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e8:SetCondition(c33599937.condition)
	e8:SetTarget(c33599937.target)
	e8:SetOperation(c33599937.activate)
	c:RegisterEffect(e8)
	-- cannot pendulum summon	
	local e9=Effect.CreateEffect(c)
    e9:SetType(EFFECT_TYPE_FIELD)
    e9:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e9:SetRange(LOCATION_PZONE)
    e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e9:SetTargetRange(1,0)
    e9:SetTarget(c33599937.splimit)
    c:RegisterEffect(e9)

end

--[511000378-beserk dragon, 13722870-darkflare knight, 49217579--mirage knight,  511013020--fiveheaded dragon ]--

c33599937.collection={ [33599934]=true; [33599935]=true; [33599936]=true;  [33599937]=true; [33599938]=true; [33599939]=true; [33599940]=true;
 [511000378]=true; [13722870]=true; [49217579]=true; [511013020]=true;}

function c33599937.filter(c)
	return c33599937.collection[c:GetCode()] 
end


function c33599937.conlose(e,tp,eg,ep,ev,re,r,rp)
 local g=Duel.GetMatchingGroup(c33599937.filter,tp,LOCATION_ONFIELD,0,nil)   
   return not g:IsExists(c33599937.filter,1,nil)
end



function c33599937.splimit(e,c,tp,sumtp,sumpos)
    return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end	

function c33599937.leaveop(e,tp,eg,ep,ev,re,r,rp)
		--victory deck master effect==0x56
		Duel.Win(1-tp,0x56)
end

function c33599937.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c33599937.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
end





function c33599937.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetTurnCount()==1 and Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0 and 
Duel.IsExistingMatchingCard(c33599937.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_HAND+LOCATION_DECK,1,nil) end
if Duel.GetFlagEffect(tp,300)~=0 then return false end
if Duel.IsExistingMatchingCard(c33599937.filter,tp,LOCATION_ONFIELD,0,1,nil) then return false end

end


function c33599937.op0(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0  end
if Duel.GetFlagEffect(tp,300)~=0 then return end
if Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect(tp,300)==0 then 
local sg=Duel.GetMatchingGroup(c33599937.filter,tp,LOCATION_HAND+LOCATION_DECK,LOCATION_DECK+LOCATION_HAND,nil)
Duel.ConfirmCards(tp,sg)
Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
Duel.RegisterFlagEffect(tp,300,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
				Duel.Draw(tp,1,REASON_RULE)
end
end
end


function c33599937.distg(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	return c:IsType(TYPE_TRAP) and rp~=tp
end  

function c33599937.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_TRAP) and rp~=tp then
		Duel.NegateEffect(ev)
	end
end

function c33599937.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev) 
end

function c33599937.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ng=Group.CreateGroup()
	local dg=Group.CreateGroup()
	for i=1,ev do
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		ng:AddCard(tc)
		if tc:IsType(TYPE_TRAP) and tc:IsRelateToEffect(te) then
			dg:AddCard(tc)
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c33599937.distg2(c)
	return c:IsType(TYPE_TRAP)
end
function c33599937.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Group.CreateGroup()
	for i=1,ev do
		Duel.NegateActivation(i)
		local te=Duel.GetChainInfo(i,CHAININFO_TRIGGERING_EFFECT)
		local tc=te:GetHandler()
		if tc:IsRelateToEffect(e) and tc:IsRelateToEffect(te) and tc:IsControler(1-tp) then
			dg:AddCard(tc)
		end
	end
	local g=Duel.GetMatchingGroup(c33599937.distg2,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	local c=e:GetHandler()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.Destroy(g,REASON_EFFECT)
end
