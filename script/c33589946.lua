--Light Barrier (ANIME)
--scripted by GameMaster(GM)

local scard=c33589946

function c33589946.initial_effect(c)
--Activate
local e0=Effect.CreateEffect(c)
e0:SetType(EFFECT_TYPE_ACTIVATE)
e0:SetCode(EVENT_FREE_CHAIN)
e0:SetCondition(c33589946.coincon)
e0:SetTarget(c33589946.cointg)
e0:SetOperation(c33589946.coinop)
c:RegisterEffect(e0)
--flip coin to determin active or not
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(73206827,0))
e1:SetCategory(CATEGORY_COIN)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
e1:SetRange(LOCATION_FZONE)
e1:SetCountLimit(1)
e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
e1:SetCondition(c33589946.coincon)
e1:SetTarget(c33589946.cointg)
e1:SetOperation(c33589946.coinop)
c:RegisterEffect(e1)
--coin adjust for own arcana monsters- ocg light barrier effect check
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_FIELD)
e2:SetCode(73206827)
e2:SetRange(LOCATION_FZONE)
e2:SetTargetRange(LOCATION_MZONE,0)
e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5))
e2:SetCondition(c33589946.effectcon)
c:RegisterEffect(e2)
--recover lp if you destroy monster with field active
local e4=Effect.CreateEffect(c)
e4:SetDescription(aux.Stringid(73206827,1))
e4:SetCategory(CATEGORY_RECOVER)
e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e4:SetRange(LOCATION_FZONE)
e4:SetCode(EVENT_BATTLE_DESTROYING)
e4:SetTarget(c33589946.rectg)
e4:SetOperation(c33589946.recop)
e4:SetCondition(c33589946.reccon)
c:RegisterEffect(e4)
--disable
local e5=Effect.CreateEffect(c)
e5:SetType(EFFECT_TYPE_FIELD)
e5:SetCode(EFFECT_DISABLE)
e5:SetRange(LOCATION_FZONE)
e5:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
e5:SetTarget(c33589946.tg5)
e5:SetCondition(c33589946.con5)
c:RegisterEffect(e5)
--recover lp if your destroy monster with field active
local e6=Effect.CreateEffect(c)
e6:SetDescription(aux.Stringid(73206827,1))
e6:SetCategory(CATEGORY_RECOVER)
e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e6:SetRange(LOCATION_FZONE)
e6:SetCode(EVENT_BATTLE_DESTROYING)
e6:SetTarget(c33589946.rectg2)
e6:SetOperation(c33589946.recop2)
e6:SetCondition(c33589946.reccon2)
c:RegisterEffect(e6)
--disable
local e7=Effect.CreateEffect(c)
e7:SetType(EFFECT_TYPE_FIELD)
e7:SetCode(EFFECT_DISABLE)
e7:SetRange(LOCATION_FZONE)
e7:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
e7:SetTarget(c33589946.tg5)
e7:SetCondition(c33589946.effectcon)
c:RegisterEffect(e7)
--coin adjust for if arcana monster summoned to opponents field
local e8=Effect.CreateEffect(c)
e8:SetType(EFFECT_TYPE_FIELD)
e8:SetCode(33589946)
e8:SetRange(LOCATION_FZONE)
e8:SetTargetRange(0,LOCATION_MZONE)
e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
e8:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5))
e8:SetCondition(c33589946.effectcon1)
c:RegisterEffect(e8)
--function overwrite scripted by MLD
local f=Duel.TossCoin
Duel.TossCoin=function(tp,ct)
if not c:IsType(TYPE_MONSTER) and c:IsSetCard(0x5) then return false end	
if Duel.IsPlayerAffectedByEffect(tp,33589946) and c:GetFlagEffect(73206827)==0   and (c:GetSummonPlayer()==tp or c:GetSummonPlayer()~=tp)   then
	local tct=ct
	local t={}
	for i=1,ct do
		local res=1-Duel.SelectOption(1-tp,60,61)
		table.insert(t,res)
	end
	return table.unpack(t)
else
	return f(tp,ct)
end
end
end


c33589946.collection={  [5861892]=true; [8396952]=true; [23846921]=true; [34568403]=true; [511016000]=true; 
[35781051]=true; [60953118]=true; [61175706]=true; [62892347]=true;[511016002]=true; [69831560]=true;[97452817]=true; [97574404]=true; 
[100000116]=true; [513000126]=true; [100000106]=true; [511005634]=true; }






--e2
function c33589946.coincon(e,tp,eg,ep,ev,re,r,rp)
return tp==Duel.GetTurnPlayer()
end

function c33589946.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end



function c33589946.coinop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if not c:IsRelateToEffect(e) then return end
c:ResetFlagEffect(33589946)--reset coin flip description
local res=0
res=Duel.TossCoin(tp,1) 
c:RegisterFlagEffect(33589946,RESET_EVENT+0x1fe0000,EFFECT_FLAG_CLIENT_HINT,1,res,63-res)-- set hint to the coin flip make sure has a property EFFECT_FLAG_CLIENT_HINT**
if res==0 then
c:RegisterFlagEffect(73206827,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,2)
Duel.RegisterFlagEffect(tp,33589946,RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,2)
  end
end

function c33589946.effectcon(e)
local c=e:GetHandler()
return c:GetFlagEffect(73206827)==0 or c:IsHasEffect(EFFECT_CANNOT_DISABLE)
end

function c33589946.effectcon1(e,c)
local c=e:GetHandler()
return c:GetFlagEffect(73206827)==0 or c:IsHasEffect(EFFECT_CANNOT_DISABLE) and (c:IsType(TYPE_MONSTER) and c:IsSetCard(0x5))
end



--e3


--e4
function c33589946.reccon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local rc=eg:GetFirst()
return rc:IsRelateToBattle()  and rc:IsFaceup() and rc:IsControler(tp) and c:GetFlagEffect(73206827)==0
end


function c33589946.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local tc=eg:GetFirst():GetBattleTarget()
local atk=tc:GetBaseAttack()
if atk<0 then atk=0 end
Duel.SetTargetPlayer(tp)
Duel.SetTargetParam(atk)
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end
function c33589946.recop(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Recover(p,d,REASON_EFFECT)
end


--e5
function c33589946.tg5(e,c)
return c:IsType(TYPE_MONSTER) and not c:IsSetCard(0x5)
end
function c33589946.con5(e)
local c=e:GetHandler()
return e:GetHandler():GetFlagEffectLabel(73206827)==1
end

--e6

function c33589946.reccon2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local rc=eg:GetFirst()
return rc:IsRelateToBattle()  and rc:IsFaceup() and rc:IsControler(1-tp) and c:GetFlagEffect(73206827)==0
end	


function c33589946.rectg2(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
local tc=eg:GetFirst():GetBattleTarget()
local atk=tc:GetBaseAttack()
if atk<0 then atk=0 end
Duel.SetTargetPlayer(1-tp)
Duel.SetTargetParam(atk)
Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,1-tp,atk)
end
function c33589946.recop2(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
Duel.Recover(p,d,REASON_EFFECT)
end

