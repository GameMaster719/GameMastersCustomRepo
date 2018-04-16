--Tears of a Mermaid (Anime)
--scripted by GameMaster (GM)
function c33559941.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c33559941.condition)
	e1:SetTarget(c33559941.target)
	e1:SetOperation(c33559941.activate)
	c:RegisterEffect(e1)
end
function c33559941.condition(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	local p=e:GetHandler():GetControler()
	if d==nil then return end
	if d:GetControler()==p and d:IsAttribute(ATTRIBUTE_WATER) then return true
else return false
end
end



function c33559941.filter(c)
	return c:IsType(TYPE_EQUIP)
end

function c33559941.chainlm(e,rp,tp)
	return tp==rp or e:GetHandler():IsCode(5318639)
end

function c33559941.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chkc then return chkc==tg end
	if chk==0 then return tg:IsOnField() and tg:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tg)
end
function c33559941.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
if tc:IsRelateToEffect(e) then
	Duel.NegateAttack()
	local tc=Duel.GetFirstTarget()
	local eqg=tc:GetEquipGroup()
if eqg:GetCount()>0 then
local oppmonNum = Duel.GetMatchingGroupCount(c33559941.filter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	local s1=math.min(oppmonNum,oppmonNum)
local g=Duel.SelectTarget(tp,c33559941.filter,tp,LOCATION_SZONE,LOCATION_SZONE,s1,s1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetChainLimit(c33559941.chainlm)
	local tc=g:GetFirst()
	while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
			tc:RegisterEffect(e2)
			 tc=g:GetNext()
			end
			Duel.BreakEffect()
		end
		Duel.Destroy(eqg,REASON_EFFECT)
	end
	end
	

			