function RarehunterStringsStartup(deck)
  -- function called at the start of the duel, if the AI was detected playing your deck.
  --AI.Chat("Startup functions loaded.")
  AI.Chat("You are now playing against AI_RarehunterStrings by GameMaster.")
   -- Your links to the important AI functions. If you don't specify a function,
  -- or your function returns nil, the default logic will be used as a fallback.
  deck.Init                 = RarehunterStringsInit
  deck.Card                 = RarehunterStringsCard
  deck.Chain                = RarehunterStringsChain
  deck.EffectYesNo          = RarehunterStringsEffectYesNo
  deck.Position             = RarehunterStringsPosition
  deck.ActivateBlacklist    = RarehunterStringsActivateBlacklist
  deck.SummonBlacklist      = RarehunterStringsSummonBlacklist
  deck.SetBlacklist         = RarehunterStringsSetBlacklist
  deck.RepositionBlacklist  = RarehunterStringsRepoBlacklist
  deck.Unchainable          = RarehunterStringsUnchainable
  deck.PriorityList         = RarehunterStringsPriorityList
  deck.BattleCommand        = RarehunterStringsBattleCommand
  deck.AttackTarget         = RarehunterStringsAttackTarget
  deck.YesNo                = RarehunterStringsYesNo
  deck.ChainOrder           = RarehunterStringsChainOrder
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

DECK_RarehunterStrings = NewDeck("RarehunterStrings",{10000020,31709826,94163677,57953380,21558682},RarehunterStringsStartup) -- 
-- BlueEyes White Dragon and BlueEyes Maiden. BEWD is used in the Exodia deck as well,
-- so we use a 2nd card to identify the deck 100%. Could just use Maiden as well.

RarehunterStringsActivateBlacklist={
21770260,--jam breeding machine
34646691,--stumbling
94163677,--Infinte cards
58775978,--nightmares steelcage

}
RarehunterStringsSummonBlacklist={
-- Blacklist of cards to never be normal summoned or set by the default AI logic (apparently this includes special summoning?)
}
RarehunterStringsSetBlacklist={
-- Blacklist for cards to never set to the S/T Zone to chain or as a bluff
}
RarehunterStringsRepoBlacklist={
-- Blacklist for cards to never be repositioned
}
RarehunterStringsUnchainable={
26905245,--metal reflect slime
511001203,--slime ball

}



---------------------USE---------------------------
--Jam Breeding Machine
function UseJamBreeder()
  return HasID(AIMon(),31709826,true) or HasWetlands()
end

--Infinte cards
function UseInfiniteCards()
  return Duel.GetCurrentPhase()==PHASE_MAIN1 
end

--Stumbling
function UseStumbling()
  return  Duel.GetCurrentPhase()==PHASE_MAIN1
end

--nightmares steelcage
function UseSteelcage()
  return Duel.GetCurrentPhase()==PHASE_MAIN1
end



-------------------------------------------------------



-------------------------------SUMMON------------------------------------------


function SummonSlifer()
   return #AIMon()>=3
 end

-----------------------------------------------------------------------------------



function RarehunterStringsInit(cards) --Main Phase logic
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
  --set jam defender
  if HasID(AIHand(),21558682,true) and #AIST()<5 then
    for i=1,#SetST do
      if SetST[i].location == LOCATION_HAND and id == 21558682  then
       return COMMAND_SET_ST,i
      end
    end
  end 
    if HasIDNotNegated(Sum,31709826,SummonRevivalJam) then --summon revival jam
    return COMMAND_SUMMON,CurrentIndex
  end 
  if HasIDNotNegated(Sum,10000020,SummonSlifer) then --summon Slifer
    return COMMAND_SUMMON,CurrentIndex
  end
   if HasIDNotNegated(Act,34646691,UseStumbling) and HasJamBreeder() and not HasWetlandsSetup() then -- stumbling
      return COMMAND_ACTIVATE,CurrentIndex
    end
  if HasIDNotNegated(Act,94163677,UseInfiniteCards) and not HasInfiniteCards() then -- Infinite cards
      return COMMAND_ACTIVATE,CurrentIndex
    end
  if HasIDNotNegated(Act,58775978,UseSteelcage) and HasJamBreeder() then -- steelcage
      return COMMAND_ACTIVATE,CurrentIndex
    end	
	
end

function RarehunterStringsCard(cards,min,max,id,c,minTargets,maxTargets,triggeringID,triggeringCard) --Card targeting
  if triggeringID == 0 and not triggeringCard
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetCurrentPhase()==PHASE_END 
  and minTargets==maxTargets and minTargets == #AIHand()-6
  and LocCheck(cards,LOCATION_HAND,true)
  then
    --probably end phase discard
   return Add(cards,PRIO_TOGRAVE,minTargets,ExcludeID,10000020)
  end
   if id == 57839750 then --mother grizzly search
    return MotherGrizzlyTarget(cards)
  end
  
  
  return nil
end



function MotherGrizzlyTarget(cards)
  if HasID(AIDeck(),31709826,true) then
   return FindID(31709826,cards,true)
  else
   return Add(cards,PRIO_TOFIELD)
 end
end

----------------------HAS-----------------------------------------

function HasWetlands()
return HasID(AIST(),2084239,true)  
end

function HasInfiniteCards()
return  HasID(OppST(),94163677,true) or HasID(AIST(),94163677,true)
end

function HasJamBreeder()
return HasID(AIST(),21770260,true)  
end

function HasWetlandsSetup()
return HasID(AIST(),2084239,true)  and HasID(AIST(),14342283,true)
end



function HasGod5cardcombo()
return HasID(AIMon(),10000020,true)  and HasID(AIMon(),31709826,true)  
and HasID(AIST(),94163677,true) and HasID(AIST(),57953380,true) and HasID(AIST(),21558682,true)
end


-----------------------------------------------------------------------------------


--List cards that you want the AI to choose to put in attack mode when having to decide the position of a summon.
RarehunterStringsAtt={

}
--Dragonpulse, Azathoth, Rebellion XYZ
--Utopia, Utopia Lightning, Heartlanddraco
--Phantom XYZ, Totem Bird, Temtempo, Abyss Dweller,
--Peasant, Joker, Baguska

--List cards that you want the AI to choose to put in defense mode when having to decide the position of a summon.
RarehunterStringsDef={

}
--Dragonpit, Cat, Fader,
--Ptolemaeus, Granpulse, Rhapsody,
--Cowboy, Snow Bell
function RarehunterStringsPosition(id,available) --References above.
  local result
  for i=1,#RarehunterStringsAtt do
    if RarehunterStringsAtt[i]==id
    then
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#RarehunterStringsDef do
    if RarehunterStringsDef[i]==id
    then
      result=POS_FACEUP_DEFENSE
    end
  end
 return result
end

function RarehunterStringsEffectYesNo(id,card) --"Do you want to use the effect of [card]?"
  local result
 return result
end

function RarehunterStringsChain(cards) --Chains cards. This applies to all phases the card can be used in.
  return nil
end

function RarehunterStringsAttackTarget(cards,attacker) --You can choose what a card attacks. Would probably be useful for that Revival Jam thing if you don't want to use best targets.
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

function RarehunterStringsBattleCommand(cards,activatable)
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
  if HasIDNotNegated(cards,56832966) and CanWinBattle(cards[CurrentIndex],targets,true,false,DoubleUtopiaAttackTargetFilter) then 
    return Attack(IndexByID(cards,56832966))
  end
 return nil
end

function RarehunterStringsYesNo(description_id) --This comes into play when a card has resolved its effect, but has another prompt during it. An example is Wind-Witch Ice Bell.
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

function RarehunterStringsChainOrder(cards) --Which cards do you want activating first in a chain? In this example, Wind-Witch Glass Bell always resolves first, so a Solemn Card
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

function JamDefenderCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIMon(),31709826,true) 
end
if loc == PRIO_TOHAND then
return HasID(AIHand(),31709826,true) 
end
return true
end


function JamBreederCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIMon(),31709826,true) 
end
return true
end


function RJamCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIMon(),26905245,true) or #AIMon()<1
end
if loc == PRIO_TOFIELD then
return #AIMon()<1
end
return true
end

function PolyCond(loc)
if loc == PRIO_TOHAND then
return HasID(AIMon(),31709826,true) 
end
return true
end


function SliferCond(loc)
if loc == PRIO_TOFIELD then
return  HasID(AIMon(),31709826,true)  
or HasID(AIST(),94163677,true) or HasID(AIST(),57953380,true) or HasID(AIST(),21558682,true)
end
return true
end


RarehunterStringsPriorityList={
-- Priority list for your cards. You want to add all cards in your deck here,
-- or at least all cards you want to enable the Add function for.
-- I have left in an example of Majespecter Raccoon so you can see the formatting. Keep in mind, though, that all Cond functions like RaccoonCond should be kept above
--the priority list, or the AI acts extremely weird with them. From my experience, anyways. In fact, I usually put them under things like "RarehunterStringsUnchainable"
--[] = {,,,,,,,,,,Cond},    **MAKE SURE YOU DONT FORGET COMMA IF NOT WILL NOT TALK==aka not work  
--hand,nottohand,field,nottofield,grave,nottograve,discard,discardnot,banish,baishnot

[10000020] = {7,1,9,1,2,2,1,8,2,2,SliferCond},  --slifer
[24094653] = {7,2,8,1,0,9,1,8,1,5,PolyCond},--polymeriztion
[21770260] = {6,1,8,1,1,8,1,8,1,7,JamBreederCond}, --jam breeder
[31709826] = {7,1,10,1,1,7,1,8,1,8,RJamCond},--revival jam
[21558682] = {9,1,9,1,1,3,1,3,1,3,JamDefenderCond}, --jam defender
 }