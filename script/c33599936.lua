--Judge Man (DM)
--Scripted by GameMaster(GM)
function c33599936.initial_effect(c)
	--put into play
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e0:SetCode(EVENT_PREDRAW)
	e0:SetCountLimit(1,300+EFFECT_COUNT_CODE_DUEL)
	e0:SetRange(LOCATION_HAND+LOCATION_DECK)	
	e0:SetTarget(c33599936.tg0)
	e0:SetOperation(c33599936.op0)
	c:RegisterEffect(e0)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51100567,2))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e1:SetCost(c33599936.cost)
	e1:SetTarget(c33599936.target)
	e1:SetCountLimit(1)
	e1:SetOperation(c33599936.operation)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Move to Field
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33599936,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCondition(c33599936.spcon)
	e3:SetCountLimit(1,33599936+EFFECT_COUNT_CODE_DUEL)
	e3:SetOperation(c33599936.spop)
	c:RegisterEffect(e3)
	--Lose effect Deck Master
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(33599936,0))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetRange(LOCATION_EXTRA+LOCATION_REMOVED)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetProperty(EFFECT_FLAG_REPEAT)
	e6:SetCondition(c33599936.conlose)
	e6:SetOperation(c33599936.leaveop)
	c:RegisterEffect(e6)
	-- cannot pendulum summon	
	local e7=Effect.CreateEffect(c)
    e7:SetType(EFFECT_TYPE_FIELD)
    e7:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e7:SetRange(LOCATION_PZONE)
    e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e7:SetTargetRange(1,0)
    e7:SetTarget(c33599936.splimit)
    c:RegisterEffect(e7)
end

--[511000378-beserk dragon, 13722870-darkflare knight, 49217579--mirage knight,  511013020--fiveheaded dragon ]--


c33599936.collection={ [33599934]=true; [33599935]=true; [33599936]=true;  [33599937]=true; [33599938]=true; [33599939]=true; [33599940]=true;
 [511000378]=true; [13722870]=true; [49217579]=true; [511013020]=true;}


function c33599936.conlose(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33599936.filter,tp,LOCATION_ONFIELD,0,nil)   
   return not g:IsExists(c33599936.filter,1,nil)
end

function c33599936.splimit(e,c,tp,sumtp,sumpos)
    return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end	




function c33599936.leaveop(e,tp,eg,ep,ev,re,r,rp)
	--victory deck master effect==0x56
		Duel.Win(1-tp,0x56)
end

function c33599936.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c33599936.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
end


function c33599936.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) and Duel.GetFlagEffect(tp,51100567+1)==0 end
	Duel.PayLPCost(tp,1000)
	if Duel.GetTurnPlayer()==tp then
		Duel.RegisterFlagEffect(tp,51100567+1,RESET_PHASE+PHASE_END+RESET_OPPO_TURN,0,1)
	else
		Duel.RegisterFlagEffect(tp,51100567+1,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
	end
end
function c33599936.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c33599936.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	Duel.Damage(1-tp,ct*500,REASON_EFFECT)
end


c33599936.collection={ [33599936]=true; [33599934]=true; [33599935]=true; [33599937]=true; [33599938]=true; }


function c33599936.filter(c)
	return c33599936.collection[c:GetCode()] 
end




function c33599936.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetTurnCount()==1 and Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0 and 
Duel.IsExistingMatchingCard(c33599936.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_HAND+LOCATION_DECK,1,nil) end
if Duel.GetFlagEffect(tp,300)~=0 then return false end
if Duel.IsExistingMatchingCard(c33599936.filter,tp,LOCATION_ONFIELD,0,1,nil) then return false end

end


function c33599936.op0(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0  end
if Duel.GetFlagEffect(tp,300)~=0 then return end
if Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect(tp,300)==0 then 
local sg=Duel.GetMatchingGroup(c33599936.filter,tp,LOCATION_HAND+LOCATION_DECK,LOCATION_DECK+LOCATION_HAND,nil)
Duel.ConfirmCards(tp,sg)
Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
Duel.RegisterFlagEffect(tp,300,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
				Duel.Draw(tp,1,REASON_RULE)
end
end
end
