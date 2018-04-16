--EarthShaker (DOR)
--scripted by GameMaster(GM)
function c33599989.initial_effect(c)
--to grave
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_TOGRAVE)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetTarget(c33599989.target)
e1:SetOperation(c33599989.activate)
c:RegisterEffect(e1)
end

function c33599989.cfilter(c)
return c:GetOriginalCode()==33599901 and c:IsAbleToGrave()
end

function c33599989.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33599989.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
or Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)  end
local sg=Duel.GetMatchingGroup(c33599989.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,sg,sg:GetCount(),0,0)
local sg2=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
Duel.SetOperationInfo(0,CATEGORY_POSITION,sg2,sg2:GetCount(),0,0)
end

function c33599989.activate(e,tp,eg,ep,ev,re,r,rp)
local sg=Duel.GetMatchingGroup(c33599989.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
Duel.SendtoGrave(sg,REASON_EFFECT)
local sg2=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
if sg2:GetCount()>0 then
Duel.ChangePosition(sg2,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
end
end
