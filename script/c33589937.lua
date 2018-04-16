--Fairy Metor Crush (DOR)
--scripted by GameMaster (GM)
function c33589937.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_DESTROY)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33589937.target)
e1:SetOperation(c33589937.activate)
c:RegisterEffect(e1)
end

function c33589937.filter(c)
return c:IsType(0xfff) 
end

function c33589937.target(e,tp,eg,ep,ev,re,r,rp,chk)
local oppmonNum = Duel.GetMatchingGroupCount(c33589937.filter,nil,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
local s1=math.min(oppmonNum,oppmonNum)
if chk==0 then return Duel.IsExistingTarget(c33589937.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,19,e:GetHandler()) end
local g=Duel.GetMatchingGroup(c33589937.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
--send this card card to grave 
Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
if g:GetCount()>0 then
local tg=g
if tg:GetCount()>1 then
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SetTargetCard(tg)
Duel.HintSelection(g)
end
end
end

function c33589937.activate(e,tp,eg,ep,ev,re,r,rp)
local oppmonNum = Duel.GetMatchingGroupCount(c33589937.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
local s1=math.min(oppmonNum,oppmonNum)
local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())

if g:GetCount()>9 then
local sg=g:RandomSelect(tp,10)
Duel.Destroy(sg,REASON_EFFECT)
Duel.ConfirmCards(tp,sg)
end
end
