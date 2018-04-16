--DOR DRAW
--scripted by GameMaster(GM)
function c33589934.initial_effect(c)
--draw card if this card is drawn
local e1=Effect.CreateEffect(c)
e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_DISABLE_CHAIN)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
e1:SetCode(EVENT_PHASE_START+PHASE_DRAW)
e1:SetCountLimit(1)
e1:SetRange(LOCATION_HAND+LOCATION_DECK)
e1:SetTarget(c33589934.target)
e1:SetOperation(c33589934.operation)
c:RegisterEffect(e1)
--draw till you have 6 cards each drawphase
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(EFFECT_DRAW_COUNT)
e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e2:SetRange(LOCATION_REMOVED)
e2:SetCondition(c33589934.con2)
e2:SetTargetRange(1,0)
e2:SetValue(c33589934.value)
c:RegisterEffect(e2)
--immune
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_SINGLE)
e4:SetCode(EFFECT_IMMUNE_EFFECT)
e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e4:SetRange(LOCATION_REMOVED)
e4:SetValue(1)
c:RegisterEffect(e4)
--removed
local e4=Effect.CreateEffect(c)
e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
e4:SetCode(EVENT_DRAW)
e4:SetOperation(c33589934.op4)
c:RegisterEffect(e4)
--cannot lose to deck out
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e5:SetCode(EFFECT_CANNOT_LOSE_DECK)
e5:SetRange(LOCATION_REMOVED)
e5:SetTargetRange(1,0)
e5:SetValue(1)
c:RegisterEffect(e5)
--Discard 
local e6=Effect.CreateEffect(c)
e6:SetDescription(aux.Stringid(33589934,0))
e6:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_CANNOT_DISABLE)
e6:SetCategory(CATEGORY_HANDES)
e6:SetType(EFFECT_TYPE_IGNITION)
e6:SetRange(LOCATION_REMOVED)
e6:SetCountLimit(1)
e6:SetTarget(c33589934.tg6)
e6:SetOperation(c33589934.op6)
c:RegisterEffect(e6)
--cannot draw
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_FIELD)
e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_BOTH_SIDE)
e7:SetCode(EFFECT_CANNOT_DRAW)
e7:SetRange(LOCATION_REMOVED)
e7:SetTargetRange(1,1)
e7:SetCondition(c33589934.con)
c:RegisterEffect(e7)
local e8=e7:Clone()
e8:SetCode(EFFECT_DRAW_COUNT)
e8:SetValue(0)
c:RegisterEffect(e8)
--fusion
local e9=Effect.CreateEffect(c)
e9:SetDescription(aux.Stringid(33589934,1))
e9:SetCategory(CATEGORY_SPECIAL_SUMMON)
e9:SetType(EFFECT_TYPE_IGNITION)
e9:SetRange(LOCATION_REMOVED)
e9:SetTarget(c33589934.target22)
e9:SetOperation(c33589934.operation22)
c:RegisterEffect(e9)
end

function c33589934.filter11(c,e)
return c:IsCanBeFusionMaterial() and c:IsAbleToGrave() and not c:IsImmuneToEffect(e)
end
function c33589934.filter22(c,e,tp,m,f,chkf)
return c:IsType(TYPE_FUSION) and (not f or f(c))
	and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) and c:CheckFusionMaterial(m,nil,chkf)
end



function c33589934.target22(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c33589934.filter11,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
	local res=Duel.IsExistingMatchingCard(c33589934.filter22,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
	if not res then
		local ce=Duel.GetChainMaterial(tp)
		if ce~=nil then
			local fgroup=ce:GetTarget()
			local mg2=fgroup(ce,e,tp)
			local mf=ce:GetValue()
			res=Duel.IsExistingMatchingCard(c33589934.filter22,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
		end
	end
	return res
end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end

function c33589934.operation22(e,tp,eg,ep,ev,re,r,rp)
local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
if not e:GetHandler():IsRelateToEffect(e) then return end
local mg1=Duel.GetMatchingGroup(c33589934.filter11,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
local sg1=Duel.GetMatchingGroup(c33589934.filter22,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
local mg2=nil
local sg2=nil
local ce=Duel.GetChainMaterial(tp)
if ce~=nil then
	local fgroup=ce:GetTarget()
	mg2=fgroup(ce,e,tp)
	local mf=ce:GetValue()
	sg2=Duel.GetMatchingGroup(c33589934.filter22,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
end
if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
	local sg=sg1:Clone()
	if sg2 then sg:Merge(sg2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=sg:Select(tp,1,1,nil)
	local tc=tg:GetFirst()
	if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
		local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
		tc:SetMaterial(mat1)
		Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
	else
		local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
		local fop=ce:GetOperation()
		fop(ce,e,tp,tc,mat2)
	end
	tc:CompleteProcedure()
end
end



function c33589934.value(e,tp,eg,ep,ev,re,r,rp)
local tp=Duel.GetTurnPlayer()
local ht=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
if ht<6 then 
	return 6-ht 
end
end


function c33589934.con(e)
local tp=Duel.GetTurnPlayer()
return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>=6 
end


function c33589934.con2(e,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) and Duel.IsPlayerCanDraw(1-tp) 
	and (ct1<6 or ct2<6) end
local tp=Duel.GetTurnPlayer()

return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)<6
end


function c33589934.filter6(c)
return c:IsType(0xff)
end
function c33589934.tg6(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsExistingMatchingCard(c33589934.filter6,tp,LOCATION_HAND,0,2,nil) end
Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,2)
end
function c33589934.op6(e,tp,eg,ep,ev,re,r,rp)
local oppmonNum = Duel.GetMatchingGroupCount(c33589934.filter,tp,LOCATION_HAND,0,nil)
local s1=math.min(oppmonNum,oppmonNum)	
	Duel.DiscardHand(tp,c33589934.filter6,2,s1,REASON_EFFECT+REASON_DISCARD) 
	Duel.ShuffleHand(tp)
end





function c33589934.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(1)
Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c33589934.operation(e,tp,eg,ep,ev,re,r,rp)
if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
if e:GetHandler():IsPreviousLocation(LOCATION_HAND) then
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Draw(p,d,REASON_EFFECT)
end
end


function c33589934.op4(e,tp,eg,ep,ev,re,r,rp)
if e:GetHandler():IsFacedown() then return end
if tp==Duel.GetTurnPlayer() then
	e:GetHandler():RegisterFlagEffect(33589934,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end

