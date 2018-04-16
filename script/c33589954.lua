--kumbhanda
----scripted by GameMaster(GM)
function c33589954.initial_effect(c)
--summon effect destroys all other monsters you control
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e1:SetCategory(CATEGORY_DESTROY)	
e1:SetCode(EVENT_SUMMON_SUCCESS)
e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
e1:SetTarget(c33589954.sptg)
e1:SetOperation(c33589954.spop)
c:RegisterEffect(e1)
local e2=e1:Clone()
e2:SetCode(EVENT_SPSUMMON_SUCCESS)
c:RegisterEffect(e2)
local e3=e2:Clone()
e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
c:RegisterEffect(e3)
--Move Black bind tokens to oppoents field
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(33589954,0))
e4:SetCategory(CATEGORY_DESTROY)
e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e4:SetRange(LOCATION_MZONE)
e4:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
e4:SetCode(EVENT_CUSTOM+33589954)
e4:SetCondition(c33589954.spcon4)
e4:SetTarget(c33589954.tg4)
e4:SetOperation(c33589954.op4)
c:RegisterEffect(e4)
end


function c33589954.spcon4(e,tp,eg,ep,ev,re,r,rp)
return ep==tp
end

function c33589954.tg4(e,tp,eg,ep,ev,re,r,rp,chk)
 if chk==0 then return true end
local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end



function c33589954.op4(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e)  then
local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,c)
	Duel.Destroy(g,REASON_EFFECT)
end
end




function c33589954.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,e:GetHandler())
Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end

function c33589954.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if c:IsRelateToEffect(e)  then
local g=Duel.GetMatchingGroup(c33589954.filter,tp,LOCATION_DECK,0,nil,e,tp,eg,ep,ev,re,r,rp) 
if g:GetCount()<1  then
local token=Duel.CreateToken(tp,33589956)
Duel.SendtoDeck(token,tp,2,REASON_EFFECT)
local g=Duel.GetMatchingGroup(c33589954.filter,tp,LOCATION_DECK,0,nil,e,tp,eg,ep,ev,re,r,rp) 
if g:GetCount()>0  then
local tc=g:Select(tp,1,1,nil):GetFirst()
local tpe=tc:GetCode(33589956)
Duel.ConfirmCards(tp,tc)
if tc:IsCode(33589956) then
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
			if tc:GetCode()==33589956 then
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
		Duel.Destroy(tc,REASON_EFFECT)
		Duel.RaiseEvent(e:GetHandler(),EVENT_CUSTOM+33589954,e,0,0,tp,0)
		end
	
	end
end
end
end
end


function c33589954.filter(c,e,tp,eg,ep,ev,re,r,rp)
return c:GetCode()==33589956
end


