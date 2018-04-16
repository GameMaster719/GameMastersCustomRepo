--Memory snatcher
--scripted by GameMaster (GM)
function c33589955.initial_effect(c)
--activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e1)
--declare card name or negate summon
local e2=Effect.CreateEffect(c)
e2:SetCategory(CATEGORY_NEGATE)
e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_QUICK_F)
e2:SetCode(EVENT_CHAINING)
e2:SetRange(LOCATION_SZONE)
e2:SetCondition(c33589955.con2)
e2:SetOperation(c33589955.op1111)
c:RegisterEffect(e2)
--necro valley
local e6=Effect.CreateEffect(c)
e6:SetType(EFFECT_TYPE_FIELD)
e6:SetCode(EFFECT_NECRO_VALLEY)
e6:SetRange(LOCATION_SZONE)
e6:SetTargetRange(0,LOCATION_GRAVE)
c:RegisterEffect(e6)
--summon faceup pend. vanish
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_QUICK_F)
e7:SetCode(EVENT_CHAIN_SOLVING)
e7:SetRange(LOCATION_SZONE)
e7:SetCondition(c33589955.con7)
e7:SetOperation(c33589955.op7)
c:RegisterEffect(e7)
local e8=Effect.CreateEffect(c)
e8:SetDescription(aux.Stringid(22222231,1))
e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e8:SetCode(EVENT_CHAINING)
e8:SetOperation(c33589955.op888)
c:RegisterEffect(e8)

end



function c33589955.con7(e,tp)
local g=Duel.GetMatchingGroup(c33589955.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,e:GetHandler()) --the same
return g:IsExists(Card.IsCode,1,nil,22222236) 
end

function c33589955.op888(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
local c=e:GetHandler()	
local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,22222236)
if g:GetCount()==0 then return end
local tc=g:GetFirst()
local first=g:GetNext()
while tc do
if tc:GetSequence()<first:GetSequence() then Duel.SendtoGrave(tc,REASON_RULE) end
tc=g:GetNext()
end
end


function c33589955.op1111(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
local c=e:GetHandler()	
if c:GetCode(33589955) and c:IsFaceup() then 
local token=Duel.CreateToken(1-tp,22222236)
--cannot special summon
local e1=Effect.CreateEffect(token)
e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetRange(LOCATION_GRAVE)
e1:SetCode(EFFECT_SPSUMMON_CONDITION)
token:RegisterEffect(e1)
Duel.SendtoHand(token,1-tp,2,REASON_EFFECT)
if Duel.SendtoHand(token,1-tp,2,REASON_EFFECT) then  
Duel.SendtoGrave(token,REASON_EFFECT)
local token=Duel.CreateToken(tp,22222236)
--cannot special summon
local e1=Effect.CreateEffect(token)
e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
e1:SetType(EFFECT_TYPE_SINGLE)
e1:SetRange(LOCATION_GRAVE)
e1:SetCode(EFFECT_SPSUMMON_CONDITION)
token:RegisterEffect(e1)
Duel.SendtoHand(token,tp,2,REASON_EFFECT)
if Duel.SendtoHand(token,tp,2,REASON_EFFECT) then  
Duel.SendtoGrave(token,REASON_EFFECT)
Duel.ConfirmCards(1-tp,token)
end
end
end
Duel.Hint(HINT_SELECTMSG,1-tp,564)
local ac=Duel.AnnounceCard(1-tp,TYPE_MONSTER)
Duel.SetTargetParam(ac)
Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
local c=e:GetHandler()
local tc=re:GetHandler()
if not Duel.IsChainDisablable(ev) or tc:IsHasEffect(EFFECT_NECRO_VALLEY_IM) then return end
local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
local g=Duel.GetFieldGroup(tp,0,LOCATION_GRAVE)
if g:GetCount()==0 then return end
Duel.ConfirmCards(1-tp,g)
Duel.Hint(HINT_SELECTMSG,1-tp,526)
local sg=g:FilterSelect(1-tp,Card.IsCode,1,1,nil,ac)
local tc=sg:GetFirst()
if tc then
Duel.ConfirmCards(tp,sg)
local res=false
local targets=nil
if re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
targets=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
end
local im0=not Duel.IsPlayerAffectedByEffect(0,EFFECT_NECRO_VALLEY_IM)
local im1=not Duel.IsPlayerAffectedByEffect(1,EFFECT_NECRO_VALLEY_IM)
else
Duel.NegateEffect(ev)
end
end




function c33589955.filter(c)
return c:IsCode(22222236) and (c:IsFaceup() and c:IsAbleToRemove())
end

function c33589955.op7(e,tp,eg,ep,ev,re,r,rp) 
local g=Duel.GetMatchingGroup(c33589955.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,e:GetHandler())
g:RemoveCard(e:GetHandler())
if g:GetCount()==0 then return end
Duel.SendtoDeck(g,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
g:KeepAlive()
end

function c33589955.filter2525(c)
return c:IsFaceup() and c:IsCode(22222236)
end


function c33589955.filter005(c)
return c:IsType(TYPE_SPELL) and c33589955.collection[c:GetCode()]
end



function c33589955.filter2(c,e,tp)
return  c:IsControler(1-tp) and not c:IsLocation(LOCATION_HAND+LOCATION_DECK+LOCATION_REMOVED) and (not e or c:IsRelateToEffect(e))
end
function c33589955.con2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if ep==tp then return false end
local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
if tg==nil then return false end
local g=tg:Filter(c33589955.filter2,nil,nil,tp)
g:KeepAlive()
e:SetLabelObject(g)
return ex and tc+g:GetCount()-tg:GetCount()>0 
end
function c33589955.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(Card.IsType,tp,0,LOCATION_GRAVE,1,nil,TYPE_MONSTER)
and Duel.IsPlayerCanSpecialSummon(1-tp) end
Duel.Hint(HINT_SELECTMSG,1-tp,564)
local ac=Duel.AnnounceCard(1-tp,TYPE_MONSTER)
Duel.SetTargetParam(ac)
Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end


function c33589955.op2(e,tp,eg,ep,ev,re,r,rp)
Duel.NegateActivation(ev) 
local c=e:GetHandler()
local tc=re:GetHandler()
if not Duel.IsChainDisablable(ev) or tc:IsHasEffect(EFFECT_NECRO_VALLEY_IM) then return end
local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
local g=Duel.GetFieldGroup(tp,0,LOCATION_GRAVE)
if g:GetCount()==0 then return end
Duel.ConfirmCards(1-tp,g)
Duel.Hint(HINT_SELECTMSG,1-tp,526)
local sg=g:FilterSelect(1-tp,Card.IsCode,1,1,nil,ac)
local tc=sg:GetFirst()
if tc then
Duel.ConfirmCards(tp,sg)
Duel.SpecialSummon(tc,0,1-tp,1-tp,false,false,POS_FACEUP) 
local c=e:GetHandler()  
local res=false
local targets=nil
if re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then
targets=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
end
local im0=not Duel.IsPlayerAffectedByEffect(0,EFFECT_NECRO_VALLEY_IM)
local im1=not Duel.IsPlayerAffectedByEffect(1,EFFECT_NECRO_VALLEY_IM)
else
Duel.NegateEffect(ev)
end
end

