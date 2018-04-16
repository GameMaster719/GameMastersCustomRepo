function MarikStartup(deck)
-- function called at the start of the duel, if the AI was detected playing your deck.
--AI.Chat("Startup functions loaded.")
AI.Chat("You are now playing against AI_Marik by Gamemaster, Special thanks to Xaddgx & Snarky.")
AI.Chat("Let the Shadow Duel Begin!")
-- Your links to the important AI functions. If you don't specify a function,
-- or your function returns nil, the default logic will be used as a fallback.
deck.Init                 = MarikInit
deck.Card                 = MarikCard
deck.Chain                = MarikChain
deck.EffectYesNo          = MarikEffectYesNo
deck.Position             = MarikPosition
deck.ActivateBlacklist    = MarikActivateBlacklist
deck.SummonBlacklist      = MarikSummonBlacklist
deck.SetBlacklist         = MarikSetBlacklist
deck.RepositionBlacklist  = MarikRepoBlacklist
deck.Unchainable          = MarikUnchainable
deck.PriorityList         = MarikPriorityList
deck.BattleCommand        = MarikBattleCommand
deck.AttackTarget         = MarikAttackTarget
deck.YesNo                = MarikYesNo
deck.ChainOrder           = MarikChainOrder
deck.Option            	  = MarikOption
deck.DeclareCard          = MarikDeclare
deck.Tribute              =MarikTribute
--  deck.SkipLethalCheck      = true

  --[[
  Other, more obscure functions, in case you need them. Same as before,
  not defining a function or returning nil causes default logic to take over
 
  deck.Sum
 
  
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
GlobalStartingLP = AI.GetPlayerLP(1) 
GlobalHalvedLP = GlobalStartingLP/2

end

-- Your deck. The startup function must be on top of this line.
-- 3 required parameters.
-- First one: Your deck's name, as a string. Will be displayed in debug mode.
-- 2nd: The deck identifier. Can be a card ID (as a number) or a list of IDs.
--   Use a card or a combination of cards, that identifies your deck from others.
-- 3rd: The Startup function. Must be defined here, so it can be called at the start of the duel.
--  Technically not required, but doesn't make a lot of sense to leave it out, it would prevent
--  you from setting up all your functions and blacklists.

DECK_Marik = NewDeck("Marik",{10000010,95220856,21770260},MarikStartup) -- ra, Vengeful
-- ra and Vengeful.
-- we use a 2nd card to identify the deck 100%. Could just use a single card, but that is risky.

MarikActivateBlacklist={95220856,--vengeful bog spirit
21770260,--jam breeding machine
80230510,--Tribute burial
810000002,--Dark spell regeneration
10000010,--RA
511000237,--phnx mode
70828912,--premature burial
44095762,--mirror force
83764718,--monster reborn
76714458,--spell of pain
51482758,--remove trap
511000180,--surprise attack frm beyond
21558682,--jam defender
511000167,--dark wall of wind
98494543,--magical stone / mining for magical stones
26905245,--metal reflect slime
7165085,--bait doll
1224927,--Malevolent Catastrophe
511000163,--plasma eel
511000424,--Nightmare Mirror
42664989,--card of sancitiy
54704216,--nightmare wheel



-- Anything you add here should be handled by your script, otherwise the cards will never activate
}

-- [[NOTE Blacklisting a monster seems to affect the ai from setting it also even if you make with command...  ]] --

MarikSummonBlacklist={
43730887,--holding arms?
70124586,--holding legs
90980792,--dark jeroid
40320754,--lord poison
86569121,--Melchid the 4 Face Beast
21593977,--Makyura the Destructor
59546797,--juregado
56043446,--viser des

17597059,--byser shock
511000173,--vamperic leech
-- Blacklist of cards to never be normal summoned or set by the default AI logic (apparently this includes special summoning?)
}
MarikSetBlacklist={
83764718,--monster reborn
95220856,--vengeful bog
511000180,--surprise attack frm beyond
98494543,--magical stone / mining for magical stones
-- Blacklist for cards to never set to the S/T Zone to chain or as a bluff
}
MarikRepoBlacklist={
511000173,--vamperic leech
43730887,--holding arms
70124586,--holding legs
511000163,--plasma eel
99050989,--drillago
38445524,--gil garth
 
-- Blacklist for cards to never be repositioned
}
MarikUnchainable={44095762,--mirror force
86541496,--left arm offering

1224927,--malevolent catstopre
33589961,--malevolent manga
511000376,--anime ^^
51482758,--remove trap
76714458,--spell of pain
511000167,--dark wall of wind
511000170,--zombie's Jewel
54704216,--Nightmare Wheel
26905245,--Metal Reflect Slime
511000424,--nightmare mirror
511000170,--zombie Jewel
63995093,--machine duplication
511000163,--plasma eel
65830223,--coffin seller
2047519,--hidden soldiers
21558682,--JamDefender
33599995,--^^
37507488,--Relieve monster
511000237,--RA phnx mode
10000010,--ra
66600,
-- Blacklist for cards to not chain in the same chain
}



MarikTributeBlacklist={

10000010,--ra
66600,
43730887,--holding arms
70124586,--holding legs


}


GlobalUsedTributeBurial = nil
function UseTributeBurial()
  if HasTributeMonster()  then
    GlobalUsedTributeBurial = true
    return true
  end
end


function MarikTribute(cards,min,max)
  return Add(cards,PRIO_TOGRAVE,min)
end


------------------------------FIRST TURN/RA STUFF-------------------------
--Vamperic leech
function SummonVampLeech()
  return Duel.GetTurnCount()>1 and (#OppMon()==0 and Duel.GetCurrentPhase()==PHASE_MAIN1)
end

function UseVampLeech()
  return Duel.GetCurrentPhase()==PHASE_MAIN2
end





--Grandora/Spiked tail Lizard
function GranadoraToDef()
  return LPHalfCheck()
end
function LPHalfCheck()
return AI.GetPlayerLP(1)<=GlobalHalvedLP
end

--revival jam to def
function RevivalJamToDef()
  return AI.GetPlayerLP(1) < AI.GetPlayerLP(2)
end


--The Winged Dragon Of RA
-- sphere mode
function SummonSphereMode()
  return (#OppMon()>=3 or #AIMon()>=3) 
end

function SummonRa()
   return #AIMon()>=3
 end


--Use RA Incinerate
function UseRaIncinerate(c)
  return  AI.GetPlayerLP(1)>1200  and  #OppMon()>0 and not FilterStatus(c,STATUS_CHAINING)
end

function UseRaP2P(c)
  return  (AI.GetPlayerLP(1) > AI.GetPlayerLP(2)) or c.attack<4000
end

function UseRa(c)
   return   c.description == 1065600 and  (c.attack<c.defense or c.attack==0)
end
-----------------------------------------------------------------------------------------------------------------

-----------------USE-----------------------------------

--Suprise attack from beyond
function UseSurprise()
  return Duel.GetCurrentPhase()==PHASE_MAIN2 and CardsMatchingFilter(AIGrave(),FilterType,TYPE_MONSTER)>0
end

--Plama eel
function UsePlasmaEel()
  return #AIMon()>3 and  (#AIMon()>=3 or HasLavaGolem())
end





--vengeful bog
function UseVengeful()
  return Duel.GetCurrentPhase()==PHASE_MAIN2 
end

--Tribute Burial
function UseTributeBurial()
  return HasID(AIHand(),99747800,true) or HasID(AIHand(),76052811,true) or HasID(AIHand(),17597059,true)
end

--Jam Breeding Machine
function UseJamBreeder()
  return HasID(AIMon(),31709826,true)
end

--Card of Sanctity
function UseCardofSanctity()
  return #AIHand()<4
end

--bait doll
function UseBaitDoll()
  return CardsMatchingFilter(OppST(),BaitDollFilter)>0 
end

--remove trap
function UseRemoveTrap()
  return CardsMatchingFilter(OppST(),RemoveTrapFilter)>0 
end

--mining for magical stones
function UseMiningforMs()
  return HasID(AIGrave(),83764718,true) or HasID(AIHand(),10000010,true)
end

--monster reborn
function UseMonsterReborn()
  return HasID(AIGrave(),10000010,true) and Duel.GetCurrentPhase()==PHASE_MAIN1
end

function UsePrematureBurial()
  return HasID(AIGrave(),10000010,true) and AI.GetPlayerLP(1)>1800 and Duel.GetCurrentPhase()==PHASE_MAIN1
end

function UseJamDefender()
  return HasID(AIMon(),31709826,true)
end

function UseMetalReflect()
  return HasID(AIMon(),31709826,true) or HasLavaGolem()
end



------------------------Monster summons----------------------------


--Revival Jam
function SummonRevivalJam()
  return Duel.GetCurrentPhase()==PHASE_MAIN1
end




--Melchid the 4 face beast
function SummonMelchid()
  return  HasID(AIHand(),48948935,true) 
end

--Makyura the Destructor
function SummonMakyura()
  return CardsMatchingFilter(AIHand(),FilterType,TYPE_TRAP)>0  or (#AIMon()<1 or #OppMon()>0 or (#OppMon() > #AIMon()) )
end

--Gil Garth
function GilGarthFilter(c)
  return  OppGetStrongestAttack()<1800 
end

function SummonGilGarth()
  return CardsMatchingFilter(OppMon(),GilGarthFilter)>0 or #AIMon()<1 or #OppMon()>0
end

--Drillago
function DrillagoFilter(c)
  return OppGetStrongestAttack()<1600 
end

function SummonDrillago()
  return  CardsMatchingFilter(OppMon(),DrillagoFilter)>0 or #AIMon()<1
end


--Byser Shock
function SummonByserShock()
  return (CardsMatchingFilter(OppST(),ByserShockFilter)>2 or #OppMon()==0 )
end
function ByserShockFilter(c)
  return FilterPosition(c,POS_FACEDOWN)
end


--lord poison
function SummonLordPoison()
  return HasID(AIGrave(),62543393,true) or (#OppMon() > #AIMon())
end


--Viser Shock
function ViserFilter(c)
  return FilterPosition(c,POS_FACEUP)
end

function SummonViserDes()
  return CardsMatchingFilter(OppMon(),ViserFilter)>0
end


--Holding Arms
function SummonHoldingArms()
  return #OppMon()>0
end

--Holding Legs
function LegsFilter(c)
  return FilterPosition(c,POS_FACEDOWN)
end

function SummonHoldingLegs()
  return CardsMatchingFilter(OppST(),LegsFilter)>0
end


--Darkjeroid
function SummonDarkJeroid()
  return #OppMon()>0 
end




--tribute monsters
function IsTributeMonster(c)  
  return c.id == 99747800 or c.id == 76052811 or c.id == 17597059
end

-----------------------------------------------



function MonsterGraveyardCheck()
  return CardsMatchingFilter(AIGrave(),MonsterGraveyardCheck)>0
end



function MarikDeclare(triggeringCard)
     return 10000010
end



function MarikOption(options)
    if options[1] == 1065601 and  (AI.GetPlayerLP(1) > AI.GetPlayerLP(2) or AI.GetPlayerLP(1)>=4000 and #OppMon() < #AIMon())  then 
    return 1
  elseif options[2] == 1065605 and (AI.GetPlayerLP(1) >= 1500 and #OppMon() > #AIMon())  then 
    return 2
  end
  
end



GlobalTargetList = {
56043446,--viser des 


}

-- function to prevent multiple cards to target the same card in the same chain
function TargetCheck(card)
  for i=1,#GlobalTargetList do
    if card and GlobalTargetList[i].cardid==card.cardid then
      return false
    end
  end
  return true
end

function TargetSet(card)
  GlobalTargetList[#GlobalTargetList+1]=card
end



function MarikInit(cards) --MAINPHASE1 AND 2 ONLY!!
  local Act = cards.activatable_cards
  local Sum = cards.summonable_cards
  local SpSum = cards.spsummonable_cards
  local Rep = cards.repositionable_cards
  local SetMon = cards.monster_setable_cards
  local SetST = cards.st_setable_cards
 
 --makyura no set
 if HasID(AIMon(),21593977,true) and #AIST()<5 and #SetST > 0 and CardsMatchingFilter(AIHand(),FilterType,TYPE_TRAP)>0  then
 if #cards.st_setable_cards > 0 and AI.GetCurrentPhase() == PHASE_MAIN1  then
		local setCards = cards.st_setable_cards
		for i=1,#setCards do
			if bit32.band(setCards[i].type,TYPE_SPELL) > 0 then
				return COMMAND_SET_ST,i
			end
		end
	end
 end
    --set plasma eel
if HasID(SetMon,511000163) then
  return COMMAND_SET_MON,CurrentIndex
end
   --set jam defender
   if HasID(AIHand(),21558682,true) and #AIST()<5 then
    for i=1,#SetST do
      if SetST[i].location == LOCATION_HAND and id == 21558682  then
       return COMMAND_SET_ST,i
      end
    end
  end
      --set premature burial
   if HasID(AIHand(),70828912,true) and #AIST()<5 then
    for i=1,#SetST do
      if SetST[i].location == LOCATION_HAND and id == 70828912  then
       return COMMAND_SET_ST,i
      end
    end
  end 
  --set cards/summon before activating left arm offering
  if HasID(AIST(),86541496,true) and #AIHand()>1 then
    for i=1,#SetST do
      if SetST[i].location == LOCATION_HAND then
       return COMMAND_SET_ST,i
      end
    end
	for i=1,#Sum do
      if Sum[i].location == LOCATION_HAND then
       return COMMAND_SUMMON,i
      end
    end
  end
  --set cards before activing card or santitiy
  if HasID(AIHand(),42664989,true) and #AIST()<5 then
    for i=1,#SetST do
      if SetST[i].location == LOCATION_HAND then
       return COMMAND_SET_ST,i
      end
    end
  end
  --set cards max if has card of last will
if HasID(AIHand(),450000130,true) and #AIST()<5 then
    for i=1,#SetST do
      if SetST[i].location == LOCATION_HAND then
       return COMMAND_SET_ST,i
      end
    end
  end
 if HasIDNotNegated(Act,80230510,UseTributeBurial) and Duel.GetActivityCount(player_ai,ACTIVITY_NORMALSUMMON)==0  then -- Tribute Burial
      return COMMAND_ACTIVATE,CurrentIndex
    end	
  for i,c in pairs(Sum) do
  if IsTributeMonster(c) and GlobalUsedTributeBurial then
    GlobalUsedTributeBurial = false -- reset the global variable
    return COMMAND_SUMMON,i
  end
end 
 if HasIDNotNegated(Act,511000163,UsePlasmaEel) then -- Plasma EEl
      return COMMAND_ACTIVATE,CurrentIndex
    end
    if HasIDNotNegated(Sum,511000173,SummonVampLeech)   and not HasJamSetup() then --summon leech 
    return COMMAND_SUMMON,CurrentIndex
  end
   if HasIDNotNegated(Sum,31709826,SummonRevivalJam) then --summon revival jam
    return COMMAND_SUMMON,CurrentIndex
  end 
 if HasIDNotNegated(Sum,86569121,SummonMelchid) and not HasJamSetup() then --summon Melchid
    return COMMAND_SUMMON,CurrentIndex
  end 
   if HasIDNotNegated(Sum,21593977,SummonMakyura) and not HasJamSetup() then --summon Makyura
    return COMMAND_SUMMON,CurrentIndex
  end
   if HasIDNotNegated(Sum,38445524,SummonGilGarth) and not HasJamSetup() then --summon Gil garth
    return COMMAND_SUMMON,CurrentIndex
  end
      if HasIDNotNegated(Sum,99050989,SummonDrillago) and not HasJamSetup() then --summon Drillago
    return COMMAND_SUMMON,CurrentIndex
  end
 if HasID(Rep,13944422,GranadoraToDef,nil,LOCATION_MZONE,POS_FACEUP_ATTACK) then --change spiked tail lizard aka Grandora to DEF if lp is less than half
    return COMMAND_CHANGE_POS,CurrentIndex
  end  
  if HasID(Rep,31709826,RevivalJamToDef,nil,LOCATION_MZONE,POS_FACEUP_ATTACK) then --change revival jam to DEF if lp is less than opponents
    return COMMAND_CHANGE_POS,CurrentIndex
  end 
   if HasIDNotNegated(Sum,17597059,SummonByserShock) and not HasJamSetup() and not HasHolding() then -- summon Byser Shock
    return COMMAND_SUMMON,CurrentIndex
  end
   if HasIDNotNegated(Sum,90980792,SummonDarkJeroid) and not HasJamSetup() then --summon Darkjeroid
    return COMMAND_SUMMON,CurrentIndex
  end 
     if HasIDNotNegated(Sum,40320754,SummonLordPoison) and not HasJamSetup() then --summon Lord Poison
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,10000080,SummonSphereMode) and not HasRA() then --sphere mode
    return COMMAND_SUMMON,CurrentIndex
  end 
 if HasIDNotNegated(Act,511000173,UseVampLeech) then -- vamperic leech discard
      return COMMAND_ACTIVATE,CurrentIndex
    end
if HasIDNotNegated(Act,511000237,UseRaIncinerate,1065606) then --Ra Incinerate
      return COMMAND_ACTIVATE,CurrentIndex
    end
if HasIDNotNegated(Act,10000010,UseRaP2P,1065601) then --Ra P2P transfer 
      return COMMAND_ACTIVATE,CurrentIndex
    end	
if HasIDNotNegated(Act,10000010,UseRa,0) then -- Invincable Mode RA
      return COMMAND_ACTIVATE,CurrentIndex
    end	
   if HasIDNotNegated(Act,95220856,UseVengeful) then -- vengeful bog sprit
      return COMMAND_ACTIVATE,CurrentIndex
    end
	 if HasIDNotNegated(Act,511000180,UseSurprise) and #AIMon()<5  and not HasJamSetup() then --Surprise attack from beyond
      return COMMAND_ACTIVATE,CurrentIndex
    end
	  if HasIDNotNegated(Act,7165085,UseBaitDoll) then -- Bait Doll
      return COMMAND_ACTIVATE,CurrentIndex
    end
	if HasIDNotNegated(Act,51482758,UseRemoveTrap) then -- Remove Trap
      return COMMAND_ACTIVATE,CurrentIndex
    end
	if HasIDNotNegated(Act,42664989,UseCardofSanctity) then -- Card of Sanctity
      return COMMAND_ACTIVATE,CurrentIndex
    end
 if HasIDNotNegated(Act,98494543,UseMiningforMs) then -- mining for magicalstones/magical stone excavation
      return COMMAND_ACTIVATE,CurrentIndex
    end	
 if HasIDNotNegated(Act,70828912,UsePrematureBurial) then --PreMature burial
      return COMMAND_ACTIVATE,CurrentIndex
    end	
if HasIDNotNegated(Act,83764718,UseMonsterReborn) then --Monster reborn
      return COMMAND_ACTIVATE,CurrentIndex
    end		
if HasID(Act,26905245,UseMetalReflect) then --Metal Reflect slime
    return COMMAND_ACTIVATE,CurrentIndex
    end	
  if HasID(Act,21558682,UseJamDefender) then --jam defender
    return COMMAND_ACTIVATE,CurrentIndex
    end		
    if HasID(Act,21770260,UseJamBreeder) then --jam breeder
    return COMMAND_ACTIVATE,CurrentIndex
    end
 if HasIDNotNegated(Sum,10000010,SummonRa) then --summon ra
    return COMMAND_SUMMON,CurrentIndex
  end
 if HasIDNotNegated(Sum,56043446,SummonViserDes) and not HasJamSetup() then --summon viser des
    return COMMAND_SUMMON,CurrentIndex
  end
 if HasIDNotNegated(Sum,43730887,SummonHoldingArms) and not HasJamSetup()  then --summon holding arms
    return COMMAND_SUMMON,CurrentIndex
  end
  if HasIDNotNegated(Sum,70124586,SummonHoldingLegs) and not HasJamSetup() then --summon holding legs
    return COMMAND_SUMMON,CurrentIndex
  end  
if AI.GetPlayerLP(1)<AI.GetPlayerLP(2) then 
for i=1,#Rep do
if Rep[i] and Rep[i].location == LOCATION_MZONE and bit32.band(Rep[i].position,POS_ATTACK)>0 and not (AIGetStrongestAttack() >= OppGetStrongestAttack())then
       return COMMAND_CHANGE_POS,i
      end
    end
end  
if AI.GetPlayerLP(1)<500 and HasFearfulEarthbound() or HasBlackPendant() then 
if #Sum> 0 then
return COMMAND_SUMMON,1
end
	return COMMAND_TO_END_PHASE,1
end  
end

  

  
  
function MarikCard(cards,min,max,id,c,minTargets,maxTargets,triggeringID,triggeringCard) --Card targeting
 if triggeringID == 0 and not triggeringCard
  and Duel.GetTurnPlayer()==player_ai
  and Duel.GetCurrentPhase()==PHASE_END 
  and minTargets==maxTargets and minTargets == #AIHand()-6
  and LocCheck(cards,LOCATION_HAND,true)
  then
    --probably end phase discard
   return Add(cards,PRIO_TOGRAVE,minTargets,ExcludeID,10000010)
  end
 
  if id == 98494543 then
    return MiningforMsTarget(cards)
  end
   if id == 86541496 then
    return LeftarmTarget(cards)
  end
  if id == 83764718 then
    return RebornTarget(cards)
  end
   if id == 70828912 then
    return RebornTarget(cards)
  end 
   if id == 810000002 then
    return DarkSpellRTarget(cards)
  end
if id == 90980792 then
    return JeroidTarget(cards)
  end
  if id == 511000170 then
    return ZombieJewelTarget(cards)
  end
 if id == 7165085 then
    return BaitDollTarget(cards)
  end
  if id == 51482758 then
    return RemoveTrapTarget(cards)
  end
  if id == 511000424 then
    return NightmareMirrorTarget(cards)
  end
  if id == 511000173 then
    return LeechTarget(cards)
  end
  if id == 37507488 then
    return RelieveMonsterTarget(cards)
  end
 if id == 54704216 then
    return WheelTarget(cards)
  end
  
end

--------------------TARGETS-----------------------------------


--vamperic leech
function LeechTarget(cards)
  if HasID(AIHand(),10000010,true) then
   return FindID(10000010,cards,true)
  else
   return Add(cards,PRIO_TOGRAVE)
 end
end





--relieve monster
function RelieveMonsterTarget(cards)
  if LocCheck(cards,LOCATION_HAND) then -- special summon handling
    if HasID(cards,56043446,true)  then
     return FindID(56043446,cards,true)
    end
    if HasID(cards,511000163,true)  then
     return FindID(511000163,cards,true) 
    end
    return Add(cards,PRIO_TOFIELD)
  else -- return to hand handling
    if HasID(cards,56043446,true)  then
     return FindID(56043446,cards,true)
    end
    if HasID(cards,511000163,true)  then
     return FindID(511000163,cards,true) 
    end
    for i,c in pairs(cards) do
      if CardsEqual(c,Duel.GetAttackTarget()) then
        return {i}
      end
    end
    return Add(cards,PRIO_TOHAND)
  end
end



--nightmare mirror
function NightmareMirrorTarget(cards)
  if HasID(AIHand(),10000010,true) then
   return FindID(10000010,cards,true)
  else
   return Add(cards,PRIO_TOGRAVE)
 end
end


--mining for magical stones
function MiningforMsTarget(cards)
 if HasID(AIHand(),10000010,true) then
   return Add(cards,PRIO_TOGRAVE,2,FilterID,10000010)
end
  if HasID(AIGrave(),83764718,true) then
   return FindID(83764718,cards,true) 
  else
   return Add(cards,PRIO_TOHAND)
 end
end 

--zombie jewel 
 function ZombieJewelTarget(cards)
  if HasID(OppGrave(),83764718,true) then
   return FindID(83764718,cards,true) 
  else
   return Add(cards,PRIO_TOHAND)
 end
end 

--bait doll
function BaitDollTarget(cards)
 if CardsMatchingFilter(OppST(),BaitDollFilter)>0 then
    return BestTargets(cards,1,TARGET_DESTROY,BaitDollFilter)
  end
 end
function BaitDollFilter(c)
  return FilterPosition(c,POS_FACEDOWN)
  and Targetable(c,TYPE_TRAP) or Targetable(c,TYPE_SPELL)
end

--Remove trap
function RemoveTrapTarget(cards)
    return BestTargets(cards,1,TARGET_DESTROY,RemoveTrapFilter)
  end
function RemoveTrapFilter(c)
  return FilterPosition(c,POS_FACEUP)
  and Targetable(c,TYPE_TRAP) 
end


--dark jeroid
function JeroidTarget(cards)
  if HasID(AIST(),513000037,true) and HasID(AIMon(),90980792,true) then
    return FindID(90980792,cards,true)
  elseif not HasID(AIST(),513000037,true) and CardsMatchingFilter(OppMon(),JeroidFilter)>0 then
    return BestTargets(cards,1,TARGET_OTHER,JeroidFilter)
  end
 return Add(cards,PRIO_TOGRAVE)
end
function JeroidFilter(c)
  return FilterPosition(c,POS_FACEUP)
  and Targetable(c,TYPE_MONSTER,4)
  and Affected(c,TYPE_MONSTER,4)
end
 
 
 function DarkSpellRTarget(cards)
  if HasID(AIGrave(),83764718,true) then
   return FindID(83764718,cards,true)
  end
end
 
 
function RebornTarget(cards)
  if HasID(AIGrave(),10000010,true) then
   return FindID(10000010,cards,true)
  else
   return Add(cards,PRIO_TOFIELD)
 end
end
 
 
function LeftarmTarget(cards)
 if HasID(AIGrave(),10000010,true) and HasID(AIDeck(),83764718,true) then
  return FindID(83764718,cards,true)
 elseif not HasID(AIDeck(),83764718,true) and not HasID(AIGrave(),10000010,true) then
 return FindID(42664989,cards,true)
else 
return Add(cards,PRIO_TOHAND)
end
end


--nightmare wheel
function WheelTarget(cards)
return OppMon(c.attack)>=2000
end

--------------------------------------------------------------------------------
 
 LightAtt={
10000010
,31709826--revival jam
,43730887--holding arms
}
LightDef={
56043446,
}

 

--List cards that you want the AI to choose to put in attack mode when having to decide the position of a summon.
MarikAtt={
99747800
,38445524
,10000010--the winged dragon of ra
,66600
,31709826--revival jam
,511000285--egypitian god slime
,99050989--drillago
,21593977--makyura the destructor
,43730887--holding arms?
,70124586--holding legs
,62543393
,40320754
,13944422--Grandora/Spiked tail Lizard
,59546797--juregado
,33589962
,90980792
,76052811--helpoemer
}


--List cards that you want the AI to choose to put in defense mode when having to decide the position of a summon.
MarikDef={
511000163,--plasma eel
17597059,--byser shock
511000173,--vamperic leech
511000166,--sacred stone of ujat
33559938,--s.stone of ujat mine

56043446,--viser des
}

---------------------SETUPS------------------------------------------------------

function HasJamSetup()
return HasID(AIMon(),31709826,true)  and  HasID(AIST(),21770260,true)
end

function HasBog()
return  HasID(OppST(),95220856,true)
end

function HasRA()
return HasID(AIMon(),10000010,true) 
end

function HasHolding()
return HasID(AIMon(),43730887,true) or HasID(AIMon(),70124586,true) 
end


function HasBlackPendant()
return HasID(OppST(),65169794,true)
end


function HasLavaGolem()
return HasID(AIMon(),102380,true) 
end

function HasFearfulEarthbound()
return HasID(OppST(),511000412,true)
end

function HasTributeMonster()
return HasID(AIHand(),99747800,true) or HasID(AIHand(),76052811,true) or HasID(AIHand(),17597059,true) 
end

------------------------------------------------------------------------------------

function MarikPosition(id,available)
  local result
  if (HasIDNotNegated(UseLists({AIST(),OppST()}),62867251,true,nil,nil,POS_FACEUP)
  or HasIDNotNegated(UseLists({AIST(),OppST()}),33559907,true,nil,nil,POS_FACEUP)) then
    for i=1,#LightAtt do
      if LightAtt[i]==id then
        result=POS_FACEUP_ATTACK
      end
         end
    for i=1,#LightDef do
      if LightDef[i]==id then
        result=POS_FACEUP_DEFENSE
      end
         end
	end	 
for i=1,#MarikAtt do
if MarikAtt[i]==id and not HasJamSetup()
then
result=POS_FACEUP_ATTACK
end
end
for i=1,#MarikDef do
if MarikDef[i]==id or HasJamSetup()
then
result=POS_FACEUP_DEFENSE
end
end
return result
end





function MarikEffectYesNo(id,card) --"Do you want to use the effect of [card]?"
  local result
 return result
end
-----------------------CHAIN CARDS--------------------------------------
function JoyfulFilter(c)
  return FilterStatus(c,STATUS_SUMMONING)==10000010
end

function JoyfulVariableSetup()
  if CardsMatchingFilter(OppMon(),JoyfulFilter)>0
  and HasIDNotNegated(AIST(),511002093,true) then
    ActivateJoyful=true
  end
end

function ChainJoyful()
  if ActivateJoyful then
    return true
  end
 return false
end

function ChainRA(c)
  return  AI.GetPlayerLP(1)>1200  and  #OppMon()>0 and not FilterStatus(c,STATUS_CHAINING)
end


function ChainRemoveTrap(c)
  return  (IsBattlePhase() and UseRemoveTrap())
end


function ChainMonsterReborn(c)
  return  (IsBattlePhase() and HasID(AIGrave(),10000010,true) )
end

function ChainDarkSpellRegneration(c)
  return  (IsBattlePhase() and HasID(AIGrave(),83764718,true) )
end


function ChainSpellofPain(c)
aimon, oppmon = GetBattlingMons()
if  IsBattlePhase() and oppmon  -- we are in a battle phase, and the opponent has an attacking monster
then -- probably attack damage
print("incoming attack damage detected")
if aimon then 
print("on a monster")
damage = BattleDamage(aimon,oppmon)
else
print("direct")
damage = oppmon:GetAttack()
end
print(damage)
else -- probably not attack damage
damage = GetBurnDamage(player_ai,Duel.GetCurrentChain(),Duel.GetCurrentChain())
print("incoming effect damage detected")
print(damage)
end
if  damage >= AI.GetPlayerLP(2) or damage >= AI.GetPlayerLP(1)/2 or damage > 1500 then 
return true 
end
return false 
end


--Dark Wall of WInd
function ChainDarkWall()
  if (IsBattlePhase() and Duel.GetTurnPlayer()~=player_ai and Duel.GetAttacker()~=nil and #AIMon()==0 and #OppMon()>0) then
    return true
  end
 return false
end

--Malevolent Catastrophe
function ChainMalevolent()
  if IsBattlePhase() and #OppMon()>1 or #OppST()>1 then
    return true
  end
 return false
end


--Mirror Force
function ChainMirrorForce()
aimon, oppmon = GetBattlingMons()
  if IsBattlePhase() and (#OppMon()>1 or oppmon:GetAttack()>=2000) then
    return true
  end
 return false
end


--nightmare wheel
function ChainNightmareWheel()
  if IsBattlePhase() then
    return true
  end
 return false
end


--NightmareMirror
function ChainNightmareMirror()
  if IsBattlePhase() and HasID(AIHand(),10000010,true)then
    return true
  end
 return false
end


function MarikChain(cards) --Chains cards. This applies to all phases the card can be used in.
 if HasIDNotNegated(cards,511002093,ChainJoyful) then  -- still here
    ActivateJoyful = nil
    return {1,CurrentIndex}
  end
 if HasIDNotNegated(cards,511000167,ChainDarkWall) then  -- Dark wall of wind
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,1224927,ChainMalevolent) then  -- Malevolent Catastrophe
    return {1,CurrentIndex}
  end
 if HasIDNotNegated(cards,44095762,ChainMirrorForce) then  -- Mirror force
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,511000424,ChainNightmareMirror) then  -- Nightmare mirror
    return {1,CurrentIndex}
  end
   if HasIDNotNegated(cards,511000237,ChainRA) then  -- Ra incinerate again if monster >0
    return {1,CurrentIndex}
  end
   if HasIDNotNegated(cards,51482758,ChainRemoveTrap) then  -- Remove Trap
    return {1,CurrentIndex}
  end
     if HasIDNotNegated(cards,76714458,ChainSpellofPain) then  -- spell of pain
    return {1,CurrentIndex}
  end
   if HasIDNotNegated(cards,810000002,ChainDarkSpellRegneration) then  -- dark spell regeneration
    return {1,CurrentIndex}
  end
  if HasIDNotNegated(cards,10000010,ChainMonsterReborn) then  --monster reborn 
    return {1,CurrentIndex}
  end
    if HasIDNotNegated(cards,54704216,ChainNightmareWheel) then  --nightmare wheel
    return {1,CurrentIndex}
  end
 

  return nil
end

---------------------------------------------------------------------------------------------------------

function MarikAttackTarget(cards,attacker) --You can choose what a card attacks. Would probably be useful for that Revival Jam thing if you don't want to use best targets.
  local id = attacker.id
  local result ={attacker}
  ApplyATKBoosts(result)
  ApplyATKBoosts(cards)
  result = {}
  local atk = attacker.attack
 if NotNegated(attacker) then
    if id == 43730887 then
      return BestTargets(cards,1,TARGET_DESTROY,DestroyFilter)
    end
  
  --I will leave an example below of how I utilized this, with some stuff omitted. Check attacker ID, check what it can fight
    --and win, and if it matches conditions of what you want to hit, then return a targeting function.
    --[[if id == 56832966 and CanWinBattle(attacker,cards,true,false,DoubleUtopiaAttackTargetFilter) then
      return SpecterLightningAttackTarget(cards,attacker,false,DoubleUtopiaAttackTargetFilter)
    end]]
  end
 return nil
end

function MarikBattleCommand(cards,activatable)
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
  --[[if HasIDNotNegated(cards,56832966) and CanWinBattle(cards[CurrentIndex],targets,true,false,DoubleUtopiaAttackTargetFilter) then 
    return Attack(IndexByID(cards,56832966))
  end]]--
if HasIDNotNegated(cards,43730887) then 
    return Attack(IndexByID(cards,43730887))
  end
   return nil
end

function MarikYesNo(description_id) --This comes into play when a card has resolved its effect, but has another prompt during it. An example is Wind-Witch Ice Bell.
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




function MarikChainOrder(cards) --Which cards do you want activating first in a chain? In this example, Wind-Witch Glass Bell always resolves first, so a Solemn Card
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

--[[function RaccoonCond(loc) --See below for why this is here. Feel free to remove, just an example of things.
  if loc == PRIO_TOHAND then
    return Duel.GetCurrentPhase() == PHASE_END
  end
  if loc == PRIO_TOFIELD then
    return OPTCheck(31991800) and not (HasScales() and HasID(AIExtra(),31991800,true))
	and (not HasID(AIHand(),31991800,true) or (HasID(AIHand(),31991800,true) and NormalSummonCheck(player_ai)))
  end
  if loc == PRIO_BANISH then
    return CardsMatchingFilter(AIMon(),LevelFourFieldCheck)>0 or not HasID(AIExtra(),31991800,true)
  end
 return true
end]]

function RaCond(loc)
   if loc == PRIO_TOFIELD then
    return #AIMon()>=3
  end
  if loc == PRIO_TOGRAVE then
    return  HasID(AIHand(),83764718,true) or  HasID(AIHand(),70828912,true) 
	or HasID(AIMon(),511000173,true) or HasID(AIST(),86541496,true)
  end
 return true
end

function ArmsCond(loc)
   if loc == PRIO_TOFIELD then
    return #AIMon(70124586)>=1
  end
return true
end

function LegsCond(loc)
   if loc == PRIO_TOFIELD then
    return #AIMon(43730887)>=1
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

function MetalRSCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIMon(),31709826,true) 
end
return true
end

function JamBreederCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIMon(),31709826,true) 
end
return true
end


function PolyCond(loc)
if loc == PRIO_TOHAND then
return HasID(AIMon(),31709826,true) 
end
return true
end

function COFSCond(loc)
if loc == PRIO_TOHAND then
return #AIHand()<3
end
return true
end



function CoffinCond(loc)
if loc == PRIO_TOHAND then
return HasID(AIST(),1224927,true) 
end
if loc == PRIO_TOFIELD then
return HasID(AIST(),1224927,true) 
end
return true
end



function MonsterRebornCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIGrave(),10000010,true) 
end
if loc == PRIO_TOHAND then
return HasID(AIGrave(),10000010,true) 
end
return true
end

function PBCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIGrave(),10000010,true) 
end
if loc == PRIO_TOHAND then
return HasID(AIGrave(),10000010,true) 
end
return true
end

function LavaCond(loc)
   if loc == PRIO_TOFIELD then
    return #OppMon()>=2
  end
if loc == PRIO_TOGRAVE then
    return #AIMon(102380)>=1
  end
return true
end

function M4MSCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIGrave(),83764718,true) 
end
if loc == PRIO_TOHAND then
return HasID(AIGrave(),83764718,true) 
end
return true
end


function MaskedBeastCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIMon(),86569121,true) 
end
if loc == PRIO_TOHAND then
return HasID(AIHand(),86569121,true) or HasID(AIMon(),86569121,true) 
end
return true
end


function PlasmaEelCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIHand(),63995093,true) 
end
if loc == PRIO_TOHAND then
return HasID(AIHand(),63995093,true) 
end
return true
end


function DarkSpellRCond(loc)
if loc == PRIO_TOFIELD then
return HasID(UseLists({AIGrave(),OppGrave()}),83764718,true) 
end
if loc == PRIO_TOHAND then
return HasID(UseLists({AIGrave(),OppGrave()}),83764718,true) 
end
return true
end

function SurpriseCond(loc)
if loc == PRIO_TOFIELD then
return HasID(AIGrave(),10000010,true) 
end
if loc == PRIO_TOHAND then
return HasID(AIGrave(),10000010,true) 
end
return true
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

function ZombieJewelCond(loc)
if loc == PRIO_TOFIELD then
return HasID(OppGrave(),83764718,true) 
end
if loc == PRIO_TOHAND then
return HasID(OppGrave(),83764718,true) 
end
return true
end


function NewdoriaCond(loc)
if loc == PRIO_TOFIELD then
return #OppMon()>1
end
if loc == PRIO_TOHAND then
return#OppMon()>2
end
return true
end



MarikPriorityList={
-- Priority list for your cards. You want to add all cards in your deck here,
-- or at least all cards you want to enable the Add function for.
-- I have left in an example of Majespecter Raccoon so you can see the formatting. Keep in mind, though, that all Cond functions like RaccoonCond should be kept above
--the priority list, or the AI acts extremely weird with them. From my experience, anyways. In fact, I usually put them under things like "MarikUnchainable"
--Lower numbers = lower priority, which means if something has a higher priority for going to the grave, it would be sacrificed.

--PRIO_HAND = 1
--PRIO_FIELD = 3
--PRIO_GRAVE = 5
--PRIO_SOMETHING = 7
--PRIO_BANISH = 9
-- [31991800] = {7,1,8,2,0,0,1,1,9,3,RaccoonCond},          --Majespecter Raccoon
--[] = {,,,,,,,,,,Cond},    **MAKE SURE YOU DONT FORGET COMMA IF NOT WILL NOT TALK==aka not work
-- hand,handcond,field,fieldcond,grave,gravecond,discard,discardcond,banish,baishcond  
--[[the first number is used by default, usage for the second number is determined by the condition RaCond
if the condition doesn't exist or returns true, first number is used. if it returns false, second number
(and if the condition returns a number, that number is used instead, in case you need more than 2 options)
higher = more likely
]]--

[10000010] = {7,1,9,1,5,5,10,5,1,1,RaCond},  --winged dragon of ra
[43730887] = {6,1,10,1,1,7,1,1,1,1,ArmsCond}, --holding arms 
[70124586] = {6,1,10,1,1,7,1,1,1,1,LegsCond}, --holding legs
[102380]   = {5,2,7,2,10,10,1,1,5,5,LavaCond}, --lava golem 
[24094653] = {7,2,8,1,0,9,1,8,1,1,PolyCond},--polymeriztion
[83764718] = {7,1,6,1,4,4,1,4,1,1,MonsterRebornCond}, --monster reborn 
[70828912] = {6,1,6,1,1,8,1,8,1,1,PBCond}, --premature burial
[511000180] ={5,1,6,1,1,8,1,8,1,1,SurpriseCond}, --surprise atack from beyond
[98494543] = {4,1,5,1,1,8,1,8,1,1,M4MSCond}, --magical stone excavation
[810000002] ={4,1,5,1,1,8,1,8,1,1,DarkSpellRCond}, --dark spell regeneration
[42664989] = {8,1,5,1,1,6,1,6,1,1,COFSCond}, --card of sancitiy
[26905245] = {7,1,9,2,3,8,1,1,1,1,MetalRSCond}, --metal reflect slime
[48948935] = {5,2,6,2,3,3,0,0,1,1,MaskedBeastCond}, --mask beast des guardius
[511000163] ={8,3,6,2,1,1,1,3,1,1,PlasmaEelCond}, --plasma eel
[21770260] = {6,1,5,1,1,8,1,8,1,1,JamBreederCond}, --jam breeder
[31709826] = {7,1,10,1,1,7,1,8,1,1,RJamCond},--revival jam
[21558682] = {9,1,9,1,1,3,1,3,1,1,JamDefenderCond}, --jam defender
[511000170] ={4,1,4,1,2,3,1,4,1,1,ZombieJewelCond}, --zombie jewel
[4335645]  = {4,3,3,1,4,4,4,4,4,1,NewdoriaCond}, --newdoria
[65830223] = {8,2,2,1,1,7,1,8,1,1,CoffinCond},--coffin seller

 }