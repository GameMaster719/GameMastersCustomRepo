--Time Wizard (DOR)
function c33579970.initial_effect(c)
    --destroy zombie typed monster when FLIPPED
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33579965,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_FLIP)
	e1:SetTarget(c33579970.tg)
	e1:SetOperation(c33579970.op)
	c:RegisterEffect(e1)
end


function c33579970.filter(c)
	return c:IsType(TYPE_MONSTER) and (c:IsRace(RACE_DRAGON) and c:GetAttack()<=2300)
end


function c33579970.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetLabelObject(),1,0,0)
end

function c33579970.op(e,tp,eg,ep,ev,re,r,rp) 
	local g=Duel.GetMatchingGroup(c33579970.filter,tp,LOCATION_MZONE,0,nil)
    local tg=Group.CreateGroup()
    for i=1,Duel.Destroy(g,REASON_EFFECT) do
        tg:AddCard(Duel.CreateToken(tp,33579971))
    end
    Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c33579970.filter,tp,0,LOCATION_MZONE,nil)
    local tg=Group.CreateGroup()
    for i=1,Duel.Destroy(g,REASON_EFFECT) do
        tg:AddCard(Duel.CreateToken(1-tp,33579971))
		end
    Duel.SpecialSummon(tg,0,1-tp,1-tp,false,false,POS_FACEUP)
end

	