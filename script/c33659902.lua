--Dark Sage Anime	
--scripted by GameMaster(GM)
function c33659902. initial_effect(c)
c:EnableReviveLimit()
--add 1 spell card instead of conduction normal draw
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
e1:SetCode(EVENT_PREDRAW)
e1:SetRange(LOCATION_MZONE)
e1:SetOperation(c33659902.thop)
e1:SetTarget(c33659902.thtg)
e1:SetCondition(c33659902.con)
c:RegisterEffect(e1)
--activate spell from hand during opponents turn 
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33659902,0))
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
e2:SetRange(LOCATION_MZONE)
e2:SetCode(EVENT_FREE_CHAIN)
e2:SetCondition(c33659902.con2)
e2:SetTarget(c33659902.tg)
e2:SetOperation(c33659902.op)
e2:SetCountLimit(1)
c:RegisterEffect(e2)
--special summon
local e3=Effect.CreateEffect(c)
e3:SetDescription(aux.Stringid(33659902,0))
e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
e3:SetRange(LOCATION_HAND+LOCATION_DECK)
e3:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
e3:SetCode(EVENT_CUSTOM+71625222)
e3:SetCondition(c33659902.spcon)
e3:SetCost(c33659902.cost)
e3:SetTarget(c33659902.sptg)
e3:SetOperation(c33659902.spop)
c:RegisterEffect(e3)
end

function c33659902.spcon(e,tp,eg,ep,ev,re,r,rp)
return (ep==tp or ep~=tp)
end

function c33659902.cost(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,46986414) end
local g=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,46986414)
Duel.Release(g,REASON_COST)
end
function c33659902.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) 
and Duel.IsExistingMatchingCard(c33659902.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end

function c33659902.filter(c,e,tp)
return c:IsCode(33659902) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end

function c33659902.spop(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
local g=Duel.SelectMatchingCard(tp,c33659902.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
local tc=g:GetFirst()
if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)~=0 then
tc:CompleteProcedure()
end
end

function c33659902.tg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingMatchingCard(c33659902.fil2,tp,LOCATION_HAND,0,1,nil) end
end

function c33659902.op(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.SelectMatchingCard(tp,c33659902.fil2,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
local tpe=tc:GetType()
local te=tc:GetActivateEffect()
local tg=te:GetTarget()
local co=te:GetCost()
local op=te:GetOperation()
e:SetCategory(te:GetCategory())
e:SetProperty(te:GetProperty())
Duel.ClearTargetCard()
Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
Duel.Hint(HINT_CARD,0,tc:GetCode())
tc:CreateEffectRelation(te)
tc:CancelToGrave(false)
if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
Duel.BreakEffect()
local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
if g then
local etc=g:GetFirst()
while etc do
etc:CreateEffectRelation(te)
etc=g:GetNext()
end
end
if op then op(te,tp,eg,ep,ev,re,r,rp) end
tc:ReleaseEffectRelation(te)
if etc then	
etc=g:GetFirst()
while etc do
etc:ReleaseEffectRelation(te)
etc=g:GetNext()
end
end
end  


function c33659902.con(e,tp,eg,ep,ev,re,r,rp)
return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and Duel.GetDrawCount(tp)>0 and Duel.IsExistingMatchingCard(c33659902.fil,tp,LOCATION_DECK,0,1,nil)
end

function c33659902.con2(e,tp,eg,ep,ev,re,r,rp)
return tp~=Duel.GetTurnPlayer()  and Duel.IsExistingMatchingCard(c33659902.fil2,tp,LOCATION_HAND,0,1,nil)
end

function c33659902.fil(c)
return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end

function c33659902.fil2(c)
return c:IsType(TYPE_SPELL) 
end

function c33659902.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33659902.fil,tp,LOCATION_DECK,0,1,nil) end
local dt=Duel.GetDrawCount(tp)
if dt~=0 then
_replace_count=0
_replace_max=dt
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e1:SetCode(EFFECT_DRAW_COUNT)
e1:SetTargetRange(1,0)
e1:SetReset(RESET_PHASE+PHASE_DRAW)
e1:SetValue(0)
Duel.RegisterEffect(e1,tp)
end
Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end

function c33659902.thop(e,tp,eg,ep,ev,re,r,rp)
_replace_count=_replace_count+1
if _replace_count>_replace_max or not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown()then return end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
local g=Duel.SelectMatchingCard(tp,c33659902.fil,tp,LOCATION_DECK,0,1,1,nil)
if g:GetCount()>0 then
Duel.SendtoHand(g,nil,REASON_EFFECT)
Duel.ConfirmCards(1-tp,g)
end
end