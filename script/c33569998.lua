--Mystical Beast of Serket (Anime)
function c33569998.initial_effect(c)
  --atk up
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e2:SetCode(EVENT_BATTLE_DESTROYING)
    e2:SetCondition(c33569998.atkcon)
    e2:SetOperation(c33569998.atkop)
    c:RegisterEffect(e2)
end

function c33569998.atkcon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()~=nil
end
function c33569998.atkop(e,tp,eg,ep,ev,re,r,rp)
    local bc=Duel.GetAttackTarget()
    local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetReset(RESET_EVENT+0x1fe0000)
    e1:SetValue(bc:GetAttack()/2)
    e:GetHandler():RegisterEffect(e1)
end