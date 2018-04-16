--Skuzzy
--scripted by GameMaster(GM)
function c33569966.initial_effect(c)
   --move hexadecimal to field and active effect
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e1:SetCode(EVENT_SUMMON_SUCCESS)
    e1:SetRange(LOCATION_MZONE)
    e1:SetTarget(c33569966.target)
    e1:SetOperation(c33569966.activate)
	e1:SetCountLimit(1,33569966+EFFECT_COUNT_CODE_DUEL)
    c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--deepen damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetCondition(c33569966.dcon)
	e4:SetOperation(c33569966.dop)
	c:RegisterEffect(e4)
end

function c33569966.dcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep==tp 
end
function c33569966.dop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev*2)
end


function c33569966.filter(c,e,tp,eg,ep,ev,re,r,rp)
    return c:GetCode()==33559915
end

function c33569966.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
end

function c33569966.activate(e,tp,eg,ep,ev,re,r,rp)
local g=Duel.GetMatchingGroup(c33569966.filter,tp,LOCATION_DECK,0,nil,e,tp,eg,ep,ev,re,r,rp)  
  if g:GetCount()>0  then
    local tc=g:Select(tp,1,1,nil):GetFirst()
    local tpe=tc:GetCode(33559915)
	Duel.ConfirmCards(tp,tc)
	if tc:IsCode(33559915) then
		local te=tc:GetActivateEffect()
		local tep=tc:GetControler()
		if not te then
			Duel.Remove(tc,REASON_EFFECT)
		end
			local condition=te:GetCondition()
			local cost=te:GetCost()
			local target=te:GetTarget()
			local operation=te:GetOperation()
			if te:GetCode()==EVENT_FREE_CHAIN and te:IsActivatable(tep)
				and (not condition or condition(te,tep,eg,ep,ev,re,r,rp))
				and (not cost or cost(te,tep,eg,ep,ev,re,r,rp,0))
				and (not target or target(te,tep,eg,ep,ev,re,r,rp,0)) then
				Duel.ClearTargetCard()
				e:SetProperty(te:GetProperty())
				Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
				Duel.ChangePosition(tc,POS_FACEUP)
				if tc:GetCode()==33559915 then
				Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
				end
				tc:CreateEffectRelation(te)
				if tc:IsRelateToEffect(e) then	
				tc:CancelToGrave(false) end
				if cost then cost(te,tep,eg,ep,ev,re,r,rp,1) end
				if target then target(te,tep,eg,ep,ev,re,r,rp,1) end
				local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
				while g do
					g:CreateEffectRelation(te)
					end
				tc:SetStatus(STATUS_ACTIVATED,true)
				if operation then operation(te,tep,eg,ep,ev,re,r,rp) end
				tc:ReleaseEffectRelation(te)
				while g do
					g:ReleaseEffectRelation(te)
					g=g:GetNext()
				end
			else
				Duel.Destroy(tc,REASON_EFFECT)
			end
		end
	end
end