--Nightmare Penguin (DM)
--Scripted by GameMaster(GM)
function c33599934.initial_effect(c)
	--put into play
	local e0=Effect.CreateEffect(c)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e0:SetCode(EVENT_PREDRAW)
	e0:SetCountLimit(1,300+EFFECT_COUNT_CODE_DUEL)
	e0:SetRange(LOCATION_HAND+LOCATION_DECK)	
	e0:SetTarget(c33599934.tg0)
	e0:SetOperation(c33599934.op0)
	c:RegisterEffect(e0)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER))
	e2:SetValue(200)
	c:RegisterEffect(e2)
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
	e4:SetDescription(aux.Stringid(33599934,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_PZONE)
	e4:SetCondition(c33599934.spcon)
	e4:SetCountLimit(1,33599934+EFFECT_COUNT_CODE_DUEL)
	e4:SetOperation(c33599934.spop)
	c:RegisterEffect(e4)
	--Lose effect Deck Master
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(33599934,0))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_EXTRA+LOCATION_REMOVED)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetProperty(EFFECT_FLAG_REPEAT)
	e5:SetCondition(c33599934.conlose)
	e5:SetOperation(c33599934.leaveop)
	c:RegisterEffect(e5)
	-- cannot pendulum summon	
	local e6=Effect.CreateEffect(c)
    e6:SetType(EFFECT_TYPE_FIELD)
    e6:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e6:SetRange(LOCATION_PZONE)
    e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
    e6:SetTargetRange(1,0)
    e6:SetTarget(c33599934.splimit)
    c:RegisterEffect(e6)
--return
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(81306586,0))
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e7:SetCategory(CATEGORY_TOHAND)
	e7:SetCode(EVENT_FLIP)
	e7:SetTarget(c33599934.thtg)
	e7:SetOperation(c33599934.thop)
	c:RegisterEffect(e7)
	end
	
function c33599934.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c33599934.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end



--c:GetFlagEffect(300)>0 local f1=Duel.GetFlagEffect(tp,300+2) --


function c33599934.splimit(e,c,tp,sumtp,sumpos)
    return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end	

--[511000378-beserk dragon, 13722870-darkflare knight, 49217579--mirage knight,  511013020--fiveheaded dragon ]--

c33599934.collection={ [33599934]=true; [33599935]=true; [33599936]=true;  [33599937]=true; [33599938]=true; [33599939]=true; [33599940]=true;
 [511000378]=true; [13722870]=true; [49217579]=true; [511013020]=true;}

function c33599934.filter(c)
	return c33599934.collection[c:GetCode()] 
end


function c33599934.conlose(e,tp,eg,ep,ev,re,r,rp)
 local g=Duel.GetMatchingGroup(c33599934.filter,tp,LOCATION_ONFIELD,0,nil)   
   return not g:IsExists(c33599934.filter,1,nil)
end



function c33599934.leaveop(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		--victory deck master effect==0x56
		Duel.Win(1-tp,0x56)
end



function c33599934.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c33599934.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_MZONE,POS_FACEUP,true)
end

function c33599934.tg0(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetTurnCount()==1 and Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0 and 
Duel.IsExistingMatchingCard(c33599934.filter,tp,LOCATION_DECK+LOCATION_HAND,LOCATION_HAND+LOCATION_DECK,1,nil) end
if Duel.GetFlagEffect(tp,300)~=0 then return false end
if Duel.IsExistingMatchingCard(c33599934.filter,tp,LOCATION_ONFIELD,0,1,nil) then return false end

end


function c33599934.op0(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return Duel.CheckLocation(tp,LOCATION_SZONE,6) or Duel.CheckLocation(tp,LOCATION_SZONE,7) and Duel.GetFlagEffect(tp,300)==0  end
if Duel.GetFlagEffect(tp,300)~=0 then return end
if Duel.GetTurnCount()==1 and Duel.GetTurnPlayer()==tp or Duel.GetTurnPlayer()~=tp and Duel.GetFlagEffect(tp,300)==0 then 
local sg=Duel.GetMatchingGroup(c33599934.filter,tp,LOCATION_HAND+LOCATION_DECK,LOCATION_DECK+LOCATION_HAND,nil)
Duel.ConfirmCards(tp,sg)
Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
Duel.RegisterFlagEffect(tp,300,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,1)
if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
				Duel.Draw(tp,1,REASON_RULE)
end
end
end



