--Robotic Knight(DM)
--Scripted by GameMaster(GM)
function c33599935.initial_effect(c)
	--put into play
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e0:SetCode(EVENT_PREDRAW)
	e0:SetCountLimit(1,300+EFFECT_COUNT_CODE_DUEL)
	e0:SetRange(LOCATION_HAND+LOCATION_DECK)	
	e0:SetTarget(c33599935.tg0)
	e0:SetOperation(c33599935.op0)
	c:RegisterEffect(e0)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51100567,8))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c33599935.cost)
	e1:SetTarget(c33599935.target)
	e1:SetOperation(c33599935.operation)
	c:RegisterEffect(e1)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_PZONE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--Move to Field
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(33599935,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCondition(c33599935.spcon)
	e4:SetCountLimit(1,33599935+EFFECT_COUNT_CODE_DUEL)
	e4:SetOperation(c33599935.spop)
	c:RegisterEffect(e4)
	--Lose effect Deck Master
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(33599935,0))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_EXTRA+LOCATION_REMOVED)
	e5:SetProperty(EFFECT_FLAG_REPEAT)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetCondition(c33599935.conlose)
	e5:SetOperation(c33599935.leaveop)
	c:RegisterEffect(e5)
	-- cannot pendulum summon	
	local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_FIELD)
    e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e6:SetRange(LOCATION_PZONE)
    e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e6:SetTargetRange(1,0)
    e6:SetTarget(c33599935.splimit)
    c:RegisterEffect(e6)
	
end



--[[	--Pass ability Material
		local e7=Effect.CreateEffect(c)
		e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e7:SetCode(EVENT_BE_MATERIAL)
		e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e7:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
		e7:SetTarget(c33599935.tg7)
		Duel.RegisterEffect(e7,0)

function c33599935.tg7(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c33599935.abcon,1,nil,tp) end
	local g=eg:Filter(c33599935.abcon,nil,tp)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
	while tc do
	local rc=tc:GetReasonCard()
	rc:RegisterFlagEffect(300,0,0,1)
	tc:ResetFlagEffect(300)
	tc=g:GetNext()
	end
	end
end 

function c33599935.abcon(c)
	if c.dm_custom_pass_ability then return c.dm_custom_pass_ability
	else
	return c:GetFlagEffect(300)>0 and r~=REASON_SUMMON end
end 
]]--

function c33599935.costfilter(c)
	return c:IsAbleToGraveAsCost() and c:IsRace(RACE_MACHINE)
end
function c33599935.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c33599935.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c33599935.costfilter,tp,LOCATION_HAND,0,0,99,nil)
	Duel.SendtoGrave(cg,REASON_COST)
	e:SetLabel(cg:GetCount())
end
function c33599935.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=e:GetLabel()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*500)
end
function c33599935.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end


function c33599935.splimit(e,c,tp,sumtp,sumpos)
    return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end	



function c33599935.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c33599935.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
end

--[511000378-beserk dragon, 13722870-darkflare knight, 49217579--mirage knight,  511013020--fiveheaded dragon 511001057--perfect machine king]--

c33599935.collection={ [33599934]=true; [33599935]=true; [33599936]=true;  [33599937]=true; [33599938]=true; [33599939]=true; [33599940]=true;
 [511000378]=true; [13722870]=true; [49217579]=true; [511013020]=true;}

function c33599935.filter(c)
	return c33599935.collection[c:GetCode()] 
end


function c33599935.conlose(e,tp,eg,ep,ev,re,r,rp)
 local g=Duel.GetMatchingGroup(c33599935.filter,tp,LOCATION_ONFIELD,0,nil)   
   return not g:IsExists(c33599935.filter,1,nil)
end

function c33599935.leaveop(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
			--victory deck master effect==0x56
		Duel.Win(1-tp,0x56)
end



function c33599935.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetTurnCount()==1 and Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0 and 
Duel.IsExistingMatchingCard(c33599935.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_HAND+LOCATION_DECK,1,nil) end
if Duel.GetFlagEffect(tp,300)~=0 then return false end
if Duel.IsExistingMatchingCard(c33599935.filter,tp,LOCATION_ONFIELD,0,1,nil) then return false end

end


function c33599935.op0(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0  end
if Duel.GetFlagEffect(tp,300)~=0 then return end
if Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect(tp,300)==0 then 
local sg=Duel.GetMatchingGroup(c33599935.filter,tp,LOCATION_HAND+LOCATION_DECK,LOCATION_DECK+LOCATION_HAND,nil)
Duel.ConfirmCards(tp,sg)
Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
Duel.RegisterFlagEffect(tp,300,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
				Duel.Draw(tp,1,REASON_RULE)
end
end
end

