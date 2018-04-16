function RaphaelStartup(deck)
  -- function called at the start of the duel, if the AI was detected playing your deck.
  --AI.Chat("Startup functions loaded.")
  AI.Chat("You are now playing against AI_Raphael by GameMaster.")
  -- Your links to the important AI functions. If you don't specify a function,
  -- or your function returns nil, the default logic will be used as a fallback.
  deck.Init                 = RaphaelInit
  deck.Card                 = RaphaelCard
  deck.Chain                = RaphaelChain
  deck.EffectYesNo          = RaphaelEffectYesNo
  deck.Position             = RaphaelPosition
  deck.ActivateBlacklist    = RaphaelActivateBlacklist
  deck.SummonBlacklist      = RaphaelSummonBlacklist
  deck.SetBlacklist         = RaphaelSetBlacklist
  deck.RepositionBlacklist  = RaphaelRepoBlacklist
  deck.Unchainable          = RaphaelUnchainable
  deck.PriorityList         = RaphaelPriorityList
  deck.BattleCommand        = RaphaelBattleCommand
  deck.AttackTarget         = RaphaelAttackTarget
  deck.YesNo                = RaphaelYesNo
  deck.ChainOrder           = RaphaelChainOrder
--  deck.SkipLethalCheck      = true

  --[[
  Other, more obscure functions, in case you need them. Same as before,
  not defining a function or returning nil causes default logic to take over
  deck.Option
  deck.Sum
  deck.Tribute
  deck.DeclareCard
  deck.Number
  deck.Attribute
  deck.MonsterType
  ]]
--[[  local e0=Effect.GlobalEffect()
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAIN_SOLVED)
	e0:SetOperation(function(e,tp,eg,ep,ev,re,r,rp)
		local g=Duel.GetFieldGroup(player_ai,LOCATION_HAND,0)
		--Duel.ConfirmCards(1-player_ai,g)
	end)
	Duel.RegisterEffect(e0,0)
	local e1=e0:Clone()
	e1:SetCode(EVENT_TO_HAND)
	Duel.RegisterEffect(e1,0)
	local e2=e0:Clone()
	e2:SetCode(EVENT_PHASE_START+PHASE_MAIN1)
	Duel.RegisterEffect(e2,0)
  local e3=Effect.GlobalEffect()
  e3:SetType(EFFECT_TYPE_FIELD)
  e3:SetCode(EFFECT_PUBLIC)
  e3:SetTargetRange(LOCATION_HAND,0)
  Duel.RegisterEffect(e3,player_ai)]]
end

-- Your deck. The startup function must be on top of this line.
-- 3 required parameters.
-- First one: Your deck's name, as a string. Will be displayed in debug mode.
-- 2nd: The deck identifier. Can be a card ID (as a number) or a list of IDs.
--   Use a card or a combination of cards, that identifies your deck from others.
-- 3rd: The Startup function. Must be defined here, so it can be called at the start of the duel.
--  Technically not required, but doesn't make a lot of sense to leave it out, it would prevent
--  you from setting up all your functions and blacklists.

DECK_Raphael = NewDeck("Raphael",{34022290,511000440},RaphaelStartup) -- eatos, guardian fromation
-- BlueEyes White Dragon and BlueEyes Maiden. BEWD is used in the Exodia deck as well,
-- so we use a 2nd card to identify the deck 100%. Could just use Maiden as well.

RaphaelActivateBlacklist={
170000207,--backup Gardna
511001650,--orichalcos sword of sealing
48179391,--seal of orichalcos
500000051,--guardian treasure
511001497,--guardian sheild
69243953,--butterfly dager elma
32022366,--Gravity Axe - Grarl
68427465,--Wicked-Breaking Flamberge - Baou
55569674,--Celestial Sword - Eatos
95515060,--rod of silence
511001500,--Obedience
94793422,--rod of minds eye
93671934,--Moral boost
60519422,--Kishido Spirit
511000283,--purity of the cemetary


}

RaphaelSummonBlacklist={


}

RaphaelSetBlacklist={
511002939,--Rescuer from the Grave
60519422,--Kishido Spirit
511000453,--crystal seal
511000428,--limit tribute


}

RaphaelRepoBlacklist={



}

RaphaelUnchainable={

48179391,--seal of orichalcos
170000207,--backup Gardna

}

----------------------------Summon------------------------------------


function SummonBackupGardna()
   return Duel.GetCurrentPhase()==PHASE_MAIN1
 end
 
 
 
 --------------------------------------------------------
------------POSITIONS---------------------
 
 
 --backup Gardna
function BackupGardnaToDef()
  return true
end
 
 
 ----------------------------------------------------
---------------------USE------------------------------

function UseTheSealofOrichalcos()
  return  HasID(AIHand(),48179391,true) 
end


function UseKishidoSpirit()
  return #AIMon()>0
end


function UseGuardianTreasure()
  return   CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL+TYPE_TRAP)>4
end

function UseObedience()
  return #OppMon()>0 and #AIMon()>0 
end


function UseCelestialSword()
  return  HasID(AIMon(),170000207,true) or HasID(AIMon(),34022290,true)
end



function UseRodofSilence()
  return  HasID(AIMon(),170000207,true) or HasID(AIMon(),9633505,true)
end


function UseGravityAxe()
  return  HasID(AIMon(),170000207,true) or HasID(AIMon(),47150851,true)
end


function UseMoralBoost()
  return  HasID(AIMon(),170000207,true)
end



function UseBackupGardna()
  return (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2) and OPTCheck(170000207)
end


function UsePurity()
  return  CardsMatchingFilter(AIGrave(),FilterType,TYPE_MONSTER)==0
end

-----------------------------------------------------

-------------------------Has---------------

function HasGuardianTreasure()
return  HasID(AIST(),500000051,true)
end


function HasRodofSilence()
return  HasID(AIST(),95515060,true)
end


function HasMoralBoost()
return  HasID(AIST(),93671934,true) or HasID(OppST(),93671934,true)
end


function HasRescuer()
return  HasID(AIGrave(),511002939,true)
end



function HasGuardianMonster()
return HasID(AIGrave(),47150851,true) or HasID(AIGrave(),74367458,true) or HasID(AIGrave(),34022290,true) or HasID(AIGrave(),34022290,true) or HasID(AIGrave(),18175965,true) or HasID(AIGrave(),73544866,true)
end


--[[Grarl==47150851
elma==74367458
kayest==9633505
eatos==34022290
dreadsythe==18175965
Baou==73544866]]--

---------------------------------------------------

function OppGetStrongestDefense(filter,opt)
  local cards=OppMon()
  local result=0
  ApplyATKBoosts(cards)
  for i=1,#cards do
    local c=cards[i]
    if c and c.defense>result 
    and FilterCheck(c,filter,opt)
    and FilterPosition(c,POS_FACEUP_DEFENSE)
    then
      result=c.defense-c.bonus
    end
  end
  return result
end






function RaphaelInit(cards) --Main Phase 1 and 2 ONLY!
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
   --set Guardian Formation
   if HasID(AIHand(),511000440,true) and #AIST()<5 then
   return COMMAND_SET_ST,1
     end
if HasIDNotNegated(Act,511000283,UsePurity) then -- purity of the cemetary
      return COMMAND_ACTIVATE,CurrentIndex
    end   
if HasIDNotNegated(Sum,170000207,SummonBackupGardna) then --summon Backup Gardna
    return COMMAND_SUMMON,CurrentIndex
  end 
   if HasIDNotNegated(Act,48179391,UseTheSealofOrichalcos) then -- seal of orichalcos
      return COMMAND_ACTIVATE,CurrentIndex
    end    
   if HasIDNotNegated(Act,500000051,UseGuardianTreasure) and not HasGuardianTreasure() then -- guardian treasure
      return COMMAND_ACTIVATE,CurrentIndex
    end  	
  if HasIDNotNegated(Act,93671934,UseMoralBoost) and not HasMoralBoost() then -- Moral Boost
      return COMMAND_ACTIVATE,CurrentIndex
    end	
  if HasID(Rep,170000207,BackupGardnaToDef,nil,LOCATION_MZONE,POS_FACEUP_ATTACK) then --change backup Gardna to DEF 
    return COMMAND_CHANGE_POS,CurrentIndex
  end 
   if HasIDNotNegated(Act,511001500,UseObedience)  then -- Obedience
      return COMMAND_ACTIVATE,CurrentIndex
    end 
    if HasIDNotNegated(Act,55569674,UseCelestialSword)  then -- CelestialSword
      return COMMAND_ACTIVATE,CurrentIndex
    end 
 if HasIDNotNegated(Act,32022366,UseGravityAxe)  then -- Gravity Axe
      return COMMAND_ACTIVATE,CurrentIndex
    end
if HasIDNotNegated(Act,95515060,UseRodofSilence)  then -- Rod of silence
      return COMMAND_ACTIVATE,CurrentIndex
    end 
	if HasIDNotNegated(Act,60519422,UseKishidoSpirit)  then -- KishidoSpirit
      return COMMAND_ACTIVATE,CurrentIndex
    end 
	if HasIDNotNegated(Act,170000207,UseBackupGardna) and HasGuardianMonster() then -- backup Gardna
	OPTSet(170000207)	     
	 return COMMAND_ACTIVATE,CurrentIndex
    end 	
end

function RaphaelCard(cards,min,max,id,c,minTargets,maxTargets,triggeringID,triggeringCard) --Card targeting
 if triggeringID == 0 and not triggeringCard
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetCurrentPhase()==PHASE_END 
  and minTargets==maxTargets and minTargets == #AIHand()-6
  and LocCheck(cards,LOCATION_HAND,true)
  then
    --probably end phase discard
   return (Add(cards,PRIO_TOGRAVE,minTargets,ExcludeID,81954378) and Add(cards,PRIO_TOGRAVE,minTargets,ExcludeID,18175965) and Add(cards,PRIO_TOGRAVE,minTargets,ExcludeID,34022290) )
  end 
  if id == 55569674 then
    return CelestialSwordTarget(cards)
  end 
   if id == 95515060 then
    return RodofSilenceTarget(cards)
  end  
 if id == 32022366 then
    return GravityAxeTarget(cards)
  end   
  if id == 500000051 then
    return GuardianTreasureTarget(cards)
  end   
  if id == 69243953 then
    return ButterflyDaggerTarget(cards)
  end   
  return nil
end

-------------TARGETS--------------------------------


--Guardian Treasure
function GuardianTreasureTarget(cards)
 if CardsMatchingFilter(AIHand(),FilterType,TYPE_SPELL+TYPE_TRAP)>4 then
   return Add(cards,PRIO_TOGRAVE,5,FilterType,TYPE_SPELL+TYPE_TRAP)
end
end 



--CelestialSword
function CelestialSwordTarget(cards)
  if HasID(AIMon(),170000207,true) or HasID(AIMon(),34022290,true) then
   return FindID(170000207,cards,true) or FindID(34022290,cards,true)
  end
end


--rod of silence 
function RodofSilenceTarget(cards)
  if HasID(AIMon(),170000207,true) or HasID(AIMon(),9633505,true) then
   return FindID(170000207,cards,true) or FindID(9633505,cards,true)
  end
end


--Gravity Axe
function GravityAxeTarget(cards)
  if HasID(AIMon(),170000207,true) or HasID(AIMon(),47150851,true) then
   return FindID(170000207,cards,true) or FindID(47150851,cards,true)
  end
end


--Butterfly Dagger
function ButterflyDaggerTarget(cards)
  if HasID(AIMon(),170000207,true) or HasID(AIMon(),74367458,true) then
   return FindID(170000207,cards,true) or FindID(74367458,cards,true)
  end
end


---------------------------------------



--List cards that you want the AI to choose to put in attack mode when having to decide the position of a summon.
RaphaelAtt={


}

--List cards that you want the AI to choose to put in defense mode when having to decide the position of a summon.
RaphaelDef={

170000207,--Backup Gardna


}

function RaphaelPosition(id,available) --References above.
  local result
  for i=1,#RaphaelAtt do
    if RaphaelAtt[i]==id
    then
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#RaphaelDef do
    if RaphaelDef[i]==id
    then
      result=POS_FACEUP_DEFENSE
    end
  end
 return result
end

function RaphaelEffectYesNo(id,card) --"Do you want to use the effect of [card]?"
  local result
if id==170000207 then  --use backup Gardna during battlephase
  result = 1
  end

 return result
end

------------------CHAIN-----------------------------------------







function RaphaelChain(cards) --Chains cards. This applies to all phases the card can be used in.

 return nil
end



-----------------------------------------------------------------------------
function RaphaelAttackTarget(cards,attacker) --You can choose what a card attacks. Would probably be useful for that Revival Jam thing if you don't want to use best targets.
  local id = attacker.id
  local result ={attacker}
  ApplyATKBoosts(result)
  ApplyATKBoosts(cards)
  result = {}
  local atk = attacker.attack
  if NotNegated(attacker) then --I will leave an example below of how I utilized this, with some stuff omitted. Check attacker ID, check what it can fight
    --and win, and if it matches conditions of what you want to hit, then return a targeting function.
    --[[if id == 56832966 and CanWinBattle(attacker,cards,true,false,DoubleUtopiaAttackTargetFilter) then
      return SpecterLightningAttackTarget(cards,attacker,false,DoubleUtopiaAttackTargetFilter)
    end]]
  end
 return nil
end

function RaphaelBattleCommand(cards,activatable)
  ApplyATKBoosts(cards)
  for i=1,#cards do
    cards[i].index = i
  end
  -- check for monsters, that cannot be attacked, or have to be attacked first.
  local targets = OppMon()
  local attackable = {}
  local mustattack = {}
  local lightning = {}
  for i=1,#targets do
    if targets[i]:is_affected_by(EFFECT_CANNOT_BE_BATTLE_TARGET)==0 then
      attackable[#attackable+1]=targets[i]
    end
    if targets[i]:is_affected_by(EFFECT_MUST_BE_ATTACKED)>0 then
      mustattack[#mustattack+1]=targets[i]
    end
  end
  if #mustattack>0 then
    targets = mustattack
  else
    targets = attackable
  end
  ApplyATKBoosts(targets)
  --Another example of making a card attack under specified conditions. This is why the battle is kind of weird and I suggested learning the easier ones first, such as Main Phase.
 --[[ if HasIDNotNegated(cards,56832966) and CanWinBattle(cards[CurrentIndex],targets,true,false,DoubleUtopiaAttackTargetFilter) then 
    return Attack(IndexByID(cards,56832966))
  end]]--
 return nil
end

function RaphaelYesNo(description_id) --This comes into play when a card has resolved its effect, but has another prompt during it. An example is Wind-Witch Ice Bell.
  local result = nil
  if description_id == 30 then
    local cards = nil
    local attacker = GetAttacker()
    local attack = 0
    if attacker then
      cards = {attacker}
      ApplyATKBoosts(cards)
      attacker = cards[1]
      attack = attacker.attack
    end
    cards=OppMon()
    if #cards == 0 then
      return 1
    end
    if FilterAffected(attacker,EFFECT_DIRECT_ATTACK) then
      return 1
    end
    ApplyATKBoosts(cards)
    if CanWinBattle(attacker,cards) then 
      GlobalCurrentAttacker = attacker.cardid
      GlobalAIIsAttacking = true
      return 1
    else
      return 0
    end
  end

  
  return nil
end

function RaphaelChainOrder(cards) --Which cards do you want activating first in a chain? In this example, Wind-Witch Glass Bell always resolves first, so a Solemn Card
--negates something else like a Majespecter Raccoon.
  result = {}
  for i=1,#cards do
    local c=cards[i]
    if c.id==71007216 then
      result[1]=i
    end
  end
  for i=1,#cards do
    local c=cards[i]
    if c.id~=71007216 then
      result[#result+1]=i
    end
  end
  return result
end

--[[Grarl==47150851
elma==74367458
kayest==9633505
eatos==34022290
dreadsythe==18175965
Baou==73544866]]--


function RescuerCond(loc)
if loc == PRIO_TOGRAVE then
return HasID(AIHand(),500000051,true) 
end
return true
end



RaphaelPriorityList={
-- Priority list for your cards. You want to add all cards in your deck here,
-- or at least all cards you want to enable the Add function for.
-- I have left in an example of Majespecter Raccoon so you can see the formatting. Keep in mind, though, that all Cond functions like RaccoonCond should be kept above
--the priority list, or the AI acts extremely weird with them. From my experience, anyways. In fact, I usually put them under things like "RaphaelUnchainable"
--[] = {,,,,,,,,,,Cond},    **MAKE SURE YOU DONT FORGET COMMA IF NOT WILL NOT TALK==aka not work  
--hand,nottohand,field,nottofield,grave,nottograve,discard,discardnot,banish,baishnot


[170000207] = {8,3,8,3,0,8,0,8,0,8,nil},--backup Gardna 
[48179391] = {8,1,8,1,0,8,0,8,0,8,nil},--seal of orichalcos
[500000051] = {9,1,9,1,0,9,0,9,0,9,nil},--Guardian Treasure
[55569674] = {6,1,6,1,1,8,1,8,1,9,nil}, --sword eatos
[9633505] = {5,1,5,1,0,8,0,8,4,4,nil}, --Guardian Kay'est
[47150851] = {3,1,3,1,1,8,0,8,1,8,nil},--grarl
[74367458] = {4,1,4,1,0,8,1,8,1,8,nil},--elma
[34022290] = {8,1,8,1,0,8,0,8,1,8,nil},--eatos
[18175965] = {6,5,6,2,0,8,0,8,2,8,nil},--dread
[73544866] = {3,1,3,1,0,8,0,8,1,1,nil},--baou
[511002939] = {10,1,10,1,10,10,10,10,10,10,RescuerCond},--resucer from the grave
 }