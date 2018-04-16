function YamiYugiStartup(deck)
  -- function called at the start of the duel, if the AI was detected playing your deck.
  --AI.Chat("Startup functions loaded.")
  AI.Chat("You are now playing against AI_YamiYugi by GameMaster")
  AI.Chat("ITS TIME TO DUEL!")
  -- Your links to the important AI functions. If you don't specify a function,
  -- or your function returns nil, the default logic will be used as a fallback.
  deck.Init                 = YamiYugiInit
  deck.Card                 = YamiYugiCard
  deck.Chain                = YamiYugiChain
  deck.EffectYesNo          = YamiYugiEffectYesNo
  deck.Position             = YamiYugiPosition
  deck.ActivateBlacklist    = YamiYugiActivateBlacklist
  deck.SummonBlacklist      = YamiYugiSummonBlacklist
  deck.SetBlacklist         = YamiYugiSetBlacklist
  deck.RepositionBlacklist  = YamiYugiRepoBlacklist
  deck.Unchainable          = YamiYugiUnchainable
  deck.PriorityList         = YamiYugiPriorityList
  deck.BattleCommand        = YamiYugiBattleCommand
  deck.AttackTarget         = YamiYugiAttackTarget
  deck.YesNo                = YamiYugiYesNo
  deck.ChainOrder           = YamiYugiChainOrder
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

DECK_YamiYugi = NewDeck("YamiYugi",{46986414,100000535},YamiYugiStartup) --Dark Magician, Ragnarock
-- so we use a 2nd card to identify the deck 100%. 

YamiYugiActivateBlacklist={
42664989,--card of Sanctity

-- Blacklist of cards to never activate or chain their effects by the default AI logic
-- Anything you add here should be handled by your script, otherwise the cards will never activate
}
YamiYugiSummonBlacklist={


-- Blacklist of cards to never be normal summoned or set by the default AI logic (apparently this includes special summoning?)
}
YamiYugiSetBlacklist={
24874630,--fiend's sanctuary
39913299,--the true name
-- Blacklist for cards to never set to the S/T Zone to chain or as a bluff
}
YamiYugiRepoBlacklist={


-- Blacklist for cards to never be repositioned
}
YamiYugiUnchainable={


-- Blacklist for cards to not chain in the same chain
}

function SummonSlifer()
  return #AIMon()>=3
end


function SummonObelisk()
  return #AIMon()>=3
end

function SummonRa()
  return #AIMon()>=3
end

function UseCardofSanctity()
  return #AIHand()<4
end


function YamiYugiInit(cards) --Main Phase logic
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
 if HasID(AIST(),42664989,true) and #AIST()<5 then
    for i=1,#SetST do
      if SetST[i].location == LOCATION_HAND then
       return COMMAND_SET_ST,i
      end
    end
  end  
  if HasIDNotNegated(Sum,10000020,SummonSlifer) then --summon Slifer
    return COMMAND_SUMMON,CurrentIndex
  end
 if HasIDNotNegated(Sum,10000000,SummonObelisk) then --summon Obelisk
    return COMMAND_SUMMON,CurrentIndex
  end
 if HasIDNotNegated(Sum,10000010,SummonRa) then --summon Ra
    return COMMAND_SUMMON,CurrentIndex
  end
if HasIDNotNegated(Act,42664989,UseCardofSanctity) then -- Card of Sanctity
      return COMMAND_ACTIVATE,CurrentIndex
    end
end

function YamiYugiCard(cards,min,max,id,c,minTargets,maxTargets,triggeringID,triggeringCard) --Card targeting
  return nil
end

--List cards that you want the AI to choose to put in attack mode when having to decide the position of a summon.
YamiYugiAtt={
25652259,--queens knight
64788463,--kings knight
90876561,--jacks knight
46986414,--Dark Magician
10000010,--the winged dragon of ra



}


--List cards that you want the AI to choose to put in defense mode when having to decide the position of a summon.
YamiYugiDef={

}




function YamiYugiPosition(id,available) --References above.
  local result
  for i=1,#YamiYugiAtt do
    if YamiYugiAtt[i]==id
    then
      result=POS_FACEUP_ATTACK
    end
  end
  for i=1,#YamiYugiDef do
    if YamiYugiDef[i]==id
    then
      result=POS_FACEUP_DEFENSE
    end
  end
 return result
end

function YamiYugiEffectYesNo(id,card) --"Do you want to use the effect of [card]?"
  local result
 return result
end

function YamiYugiChain(cards) --Chains cards. This applies to all phases the card can be used in.
  return nil
end

function YamiYugiAttackTarget(cards,attacker) --You can choose what a card attacks. Would probably be useful for that Revival Jam thing if you don't want to use best targets.
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

function YamiYugiBattleCommand(cards,activatable)
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

function YamiYugiYesNo(description_id) --This comes into play when a card has resolved its effect, but has another prompt during it. An example is Wind-Witch Ice Bell.
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

function YamiYugiChainOrder(cards) --Which cards do you want activating first in a chain? In this example, Wind-Witch Glass Bell always resolves first, so a Solemn Card
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

function FiendSanCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIHand(),40703222,true) 
end
if loc == PRIO_TOHAND then
return HasID(AIHand(),40703222,true) 
end
return true
end

YamiYugiPriorityList={
-- Priority list for your cards. You want to add all cards in your deck here,
-- or at least all cards you want to enable the Add function for.
-- I have left in an example of Majespecter Raccoon so you can see the formatting. Keep in mind, though, that all Cond functions like RaccoonCond should be kept above
--the priority list, or the AI acts extremely weird with them. From my experience, anyways. In fact, I usually put them under things like "YamiYugiUnchainable"

--PRIO_HAND = 1
--PRIO_FIELD = 3
--PRIO_GRAVE = 5
--PRIO_SOMETHING = 7
--PRIO_BANISH = 9
-- [31991800] = {7,1,8,2,0,0,1,1,9,3,RaccoonCond},             --Majespecter Raccoon
 --hand,nottohand,field,nottofield,grave,nottograve,discard,discardnot,banish,baishnot         
--[] = {,,,,,,,,,,Cond},    **MAKE SURE YOU DONT FORGET COMMA IF NOT WILL NOT TALK==aka not work also when making new deck make sure to adjust the ai file to require/require optionaldeck==name

[24874630] = {8,1,8,1,1,5,1,5,1,5,FiendSanCond}, --fiends sanctuary


 }