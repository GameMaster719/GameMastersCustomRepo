--DOR DUEL
-- - Works with Single Duel
--original work is shad3's modified to do DOR DUEL by GameMaster
local function getID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local s_id=tonumber(string.sub(str,2))
	return scard,s_id
end

local scard,s_id=getID()

--before anything registers effect dont touch this 
if not scard.rc_ovr then
	scard.rc_ovr=true
	local d_createtoken=Duel.CreateToken
	Duel.CreateToken=function(...)
		local args={select(1,...)}
		local c=d_createtoken(table.unpack(args))
		c:RegisterFlagEffect(s_id,0,0,0)
		return c
	end
end


function scard.initial_effect(c)
	if scard.regok then return end
	scard.regok=true
	--Pre-draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetOperation(scard.op)
	Duel.RegisterEffect(e1,0)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
	e2:SetCountLimit(1)
	e2:SetCondition(scard.nt_cd)
	e2:SetOperation(scard.nt_op)
	Duel.RegisterEffect(e2,0)
	--set monsters in faceup defense
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD)
e3:SetRange(LOCATION_REMOVED)
e3:SetCode(EFFECT_DEVINE_LIGHT)
e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
e3:SetTargetRange(1,1)
Duel.RegisterEffect(e3,tp)

end

function scard.tg4(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetTurnPlayer() and Duel.GetAttacker() and Duel.GetAttackTarget() and 
Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,1,TYPE_MONSTER) end
end




--define pack
--pack[1]=BP01, [2]=BP02, [3]=BPW2, [4]=BP03
--[1]=rare, [2/3/4]=common, [5]=foil
local pack={}
	pack[1]={}
	
--Rare cards ++++	
pack[1][1]={ 
 
33589922
,33589923
,511005670--tremendous fire 
,511005702--pumpking king of ghosts
,54652250--maneater bug
,99426834--beastking of the swamps
,33599962--mimicat--MIMICAT
,83764718--monster reborn
,33569930--antimagic fragrance
,33569938--crush card
,33589932--HARPIES FEATHER DUSTER
,33569939--insect imitation
,33569953--multiply
,511005692--lord of d
,33579972--timeseal
,33579975--heavy storm
,511005672--shadow of eyes
,33569931--enchanted javlin
,33599986--magical neutralizing forcefield
--larvaofmoth
,335599169--mucus yolk
,335599170--jowls of demise
,335599171--riguarus leaver
,335599172--servant of c
,335599173--slatewarrior
,335599174--timeeater
,335599175--shapesnather
,335599176--mositercreater
,335599177--bagworm
,335599191--copycat
,511005680--seal of the ancients
,511005597--carrat idol
--pupaofmoth
--pgreat moth
,33599962--mimicat
,511005611--temple of skulls
,511005660--tree of enlightment

--**do not alter below here**
,94716515--eradication aresol
,38199696--red medicine



 }
 
--power ups +  seems the 2s are spells also
pack[1][2]={
33569925
,511005721--stop defense 
,33599986--magical neutralizing forcefield
,33569927
,33569928
,33569932
,33569939
,33569940
,511005727
,33579964
,511005728
,33579974
,33579975
,511005706
,33579989
,33589901
,33589905
,99426834--beastking of the swamps
,33589922--novax prayer
,33589923
,335599157
,511005761
,511005736
,335599191
,511005763
,511005764
,335599195
,335599196
,33599966--axe of despair
,33599967--violet crystal
,33599968--silver bow and arrow
,33599969--raise body heat
,33599970--vile germs
,33599971--dragon treasure
,33599972--kunai with chain 
,33599973--7 completed
,33599974--sword of dark destruction
,33599975--Legendary sword
,33599976--gust fan 
,33599977--beast fangs
,33599978--black pendant
,33599979--laser cannon with laser
,33599980--insect armor with laser cannon 
,33599981--buring spear 
,33599982--follow wind
,33599983--fiend castle

,33589992--invigoration
,33589999--spring of rebirth

 }

--added all in pack 3 updated to newcards ids

--thinking all races?
pack[1][3]={ 
33559910
,511005717
,511005718
,33559920
,33559921
,33559930
,511005719
,33569900
,511005739
,33569905
,33569910
,33569911
,33569913
,33569916
,33569917
,511005720
,511005740
,33569924
,33569926
,33569929
,511005722
,33569934
,511005703

,33569944
,33569945
,511005741
,511005724
,511005742
,511005743

,33569961
,511005725
,511005704
,33579928
,511005744
,33579930
,33579931
,511005726
,33579933
511005745
,511005705
,33579970
,511005765
,511005746
,511005747
,33579978
,33579979
,511005748
,511005749
,33579982
,511005750
,33579984
,33579988
,33579990
,511005729
,33579992
,33579993
,511005751
,511005752
,33579999
,33589900
,33589903
,511005753
,33589907
,33589908
,511005755
,33589912
,33589915
,33589917
,33589918

,511005730
,33589969
,33589980
,511005757
,33589990
,33599903
,33599923
,33599943
,33599944
,33599946
,33599948

,511005758
,33599952
,33599955
,511005707
,335599151
,335599152
,511005760
,511005708
,335599158
,335599160
,335599161

,335599169
,335599170

,335599172
,335599173
,335599174
,335599175
,335599176
,335599177
,511005762
,335599182
,511005734
,511005735
,335599188
,335599198
,335599199
,511004312
,511004316
,511004319
,511004321
,511004324
,511004329
,511004330
,511004332
,511004333
,511004334
,511004338
,511004342
,511004344
,511005597
,511005602
,511005607
,511005608

,511005610
,511005611
,511005612
,511005613
,511005614
,511005615
,511005616
,511005617
,511005618
,511005619
,511005620
,511005621
,511005622
,511005626

,511005632
,511005651
,511005652
,511005658
,511005659

,511005663
,511005665
,511005666
,511005667
,511005669
,511005673
,511005674
,511005675
,511005676
,511005677
,511005678
,511005681
,511005683
,511005684
,511005685
,511005687
,511005689
,511005690
,511005691
,511005692
,511005693
,511005694
,511005696
,511005698
,511005699
,511005700

--**race Beast warrior**
,14977074--garoozis
,76184692--hestome giant
,5053103--battle ox
,32452818--beaver warrior
,49791927--tiger ax
,45121025--ogre of the black shadow
,26378150--rude kaiser
,511005724--pantherwarrior
,56369281--wolf axwielder

--end
--**Race Pyro**
--dragon piper
,92944626--wigs of wicked flame
--chuburan the flame knight N2MN
,88435542--fire eye
--hinotama soul
,71407486--fireyaru
--vermillian sparrow need make normal N2MN
,2830619--flame viper
,60862676--flame cerberus
--end
--**Race Zombie
,511005702--pumpking king of ghosts
--shadow spector 
--skull servant
--zombie warrior N2MN
--snake hair 
,20277860--armored zombie
,66672569--dragon zombie
,92667214--clown zombie
--graveyard hand of invitation
,32864--the 13th grave
--fiends hand
--blue eyes sliver zombie
--temple of skulls
--dororzio the grim reaper
--fire reaper
--mech mole zombie
,61201220--phantom ghosts
--flame ghost DOR N2M
,41949033--dark assialiant
,71280811--yaranzo
,33734439--three legged zombie
--shadow ghoul
,46474915--magical ghost
,34290067--corroding shark
--skelgon N2MN
--bone mouse
,93788854--the wandering doomed
--great mammoth of goldfine N2MN
,95265975--ghoul with an appetite
--practioner of darkness N2MN
--end
--**Race Fiend**
,68339286--metal guardian 
,13945283--wall of illusion
,62121--castle of dark illusions
,13723605--man-eatting tresure chest
--end
--**Race Dinosaur**
,13069066--sword arm of dragon 
,94119974--twoheaded king rex
,40374923--mammoth graveyard
,75390004--megazowler
,1784619--uraby
,38289717--crawling dragon #2
,46457856--Tomozaurus
,57305373--twomouth dark ruler
,89904598--Anthrosaurus
,42348802--trakodon
,42625254--little d
--end
--Race BEAST**
,5818798--gazelle king of mystical beasts
,99261403--dark rabbit




	}
	
--required /rituals
pack[1][4]={ 511005745--mystical elf
,511005722--dark elf
,33589924--construct of mask
,33589928--black luster ritual
,33589925--Revived Serpent Night Dragon
,511005603--pgreat moth
,511005719--mask of darkness
,2964201--eggs start
,42418084
,36121917
,98582704
,11793047--eggs end
,511002500--c.e piller cards start
,58192742
,81179446
,511005754--needle worm 
,77568553--cocoon evolution piller cards end
,24311372--zoa
,511005652--kuriboh
,52040216--harpies pet dragon
,74677422--red eyes black dragon
,511005730--darkfire dragon
,6368038--gaia the fierce knight
,58192742--petit moth
,4179849--queen of autm leaves
,51371017--princess of tsurgai
,511002508--kazijin
,511002507--suijin
,511002508--kazin
,46986416--dark magician
,511005730--darkfire dragon
,6368038--gaia the fierce knight
,58192742--petit moth
,4179849--queen of autm leaves
,51371017--princess of tsurgai
,54098121--mysterious puppetier
,47986555--millennium golem
,11714098--30,00 year old white turtle
,50259460--versago the destroyer
,52584282--herculues beetle
,89631141--blue eyes white dragon
,69455834--king of yamikai
,10538007--leogun
,68870276--fiend reflection #1
,18246479--battle steer
,95744531--griggle
,7670542--bio plant
,41392891--feral imp
,67724379--kourmori dragon
,511005626--curse of dragon 
,70781052--summoned skull
,64271667--meteor dragon
,99426834--beastking of the swamps

--turtle shell list
,55784832--Morinphen 
,23659124--Sea King Dragon 
,45042329--Tripwire Beast 
,12146024--Bolt Escargot 
,9540040--Boulder Tortoise  
,33599990--catapult turtle 
,15820147--Monsturtle
,37313348--Turtle Tiger
--Psychic Kappa
,11714098--30,000-Year White Turtle
,48109103--Kappa Avenger 
,17441953--Turtle Raccoon
,72929454--Turtle Bird 
,96981563--Giant Turtle Who Feeds on Flames 
,2118022--Hyosube 
,511005720--mukamuka
--end

	}

--Rares	??think had it at traps at one pont aka adjust
pack[1][5]={ 
33569923
,33589913
,33589914
,99426834--beastking of the swamps
,33589919
,33589933
,33589938
,33589994
,33589995
,33589996
,33589997
,33589998--gorgons eye
,33599921
,33599922
,511005650
,511005653
,511005664
,511005671
,511005672

,511005695

 }
	for _,v in ipairs(pack[1][1]) do table.insert(pack[1][5],v) end
	for _,v in ipairs(pack[1][2]) do table.insert(pack[1][5],v) end
	for _,v in ipairs(pack[1][3]) do table.insert(pack[1][5],v) end
	for _,v in ipairs(pack[1][4]) do table.insert(pack[1][5],v) end
		
pack[2]={}
 pack[2][1]={
33589922
,33589923
,511005670--tremendous fire 
,33599901--Labrynth wall
,511005702--pumpking 
,54652250--maneater bug

--pgreat moth
,99426834--beastking of the swamps
,83764718--monster reborn
,33589938--call of the grave
,33569930--antimagic fragrance
,33569931--enchanted javlin
,33589932--harpies featherduster
,33569939--insect imitation
,33569953--multiply
,511005692--lord of d
,33579972--timeseal
,33579975--heavy storm
,511005672--shadow of eyes
,33589932--HARPIES FEATHER DUSTER
--larvaofmoth
,335599191--copycat
,511005680--seal of the ancients
--pupaofmoth
,511005660--tree of enlightment
 
 } 
 
 
pack[2][2]={ 
33569913
,511005721--stop defense
,33599986--magical neutralizing forcefield
,33569925
,33569927
,33569928
,33569932
,33569939
,33569940
,511005727
,33579964

,511005728
,33579974
,33579975
,511005706
,33579989
,33589901
,33589905

,33589921
,33589922
,33589923

,33589930
,33589932
,33589935
,33589937
,33589939


,33589953
,33589959
,33589963
,33589964
,33589965
,33589966
,33589967
,33589968
,33589970
,33589971
,33589972
,33589973
,33589974
,33589976
,33589977
,33589978
,511005756
,33589988
,33589991
,33599900

,33599902
,335599157
,511005761
,511005736
,335599191
,511005763
,511005764
,335599195
,335599196


} 
--monsters
pack[2][3]={ 
33559910
,511005717
,511005718
,33559920
,33559921
,33559930
,511005719
,33569900
,511005739
,33569905
,33569910
,33569911
,33569913
,33569916
,33569917
,511005720
,511005740
,33569924
,33569926
,33569929
,511005722
,33569934
,511005703

,33569944
,33569945
,511005741
,511005724
,511005742
,511005743

,33569961
,511005725
,511005704
,33579928
,511005744
,33579930
,33579931
,511005726
,33579933
511005745
,511005705
,33579970
,511005765
,511005746
,511005747
,33579978
,33579979
,511005748
,511005749
,33579982
,511005750
,33579984
,33579988
,33579990
,511005729
,33579992
,33579993
,511005751
,511005752
,33579999
,33589900
,33589903
,511005753
,33589907
,33589908
,511005755
,33589912
,33589915
,33589917
,33589918

,511005730
,33589969
,33589980
,511005757
,33589990
,33599903
,33599923
,33599943
,33599944
,33599946
,33599948

,511005758
,33599952
,33599955
,511005707
,335599151
,335599152
,511005760
,511005708
,335599158
,335599160
,335599161

,335599169
,335599170

,335599172
,335599173
,335599174
,335599175
,335599176
,335599177
,511005762
,335599182
,511005734
,511005735
,335599188
,335599198
,335599199
,511004312
,511004316
,511004319
,511004321
,511004324
,511004329
,511004330
,511004332
,511004333
,511004334
,511004338
,511004342
,511004344
,511005597
,511005602
,511005607
,511005608

,511005610
,511005611
,511005612
,511005613
,511005614
,511005615
,511005616
,511005617
,511005618
,511005619
,511005620
,511005621
,511005622
,511005626

,511005632
,511005651
,511005652
,511005658
,511005659

,511005663
,511005665
,511005666
,511005667
,511005669
,511005673
,511005674
,511005675
,511005676
,511005677
,511005678
,511005681
,511005683
,511005684
,511005685
,511005687
,511005689
,511005690
,511005691
,511005692
,511005693
,511005694
,511005696
,511005698
,511005699
,511005700

--**race Beast warrior**
,14977074--garoozis
,76184692--hestome giant
,5053103--battle ox
,32452818--beaver warrior
,49791927--tiger ax
,45121025--ogre of the black shadow
,26378150--rude kaiser
,511005724--pantherwarrior
,56369281--wolf axwielder
--end
--**Race Pyro**
--dragon piper
,92944626--wigs of wicked flame
--chuburan the flame knight N2MN
,88435542--fire eye
--hinotama soul
,71407486--fireyaru
--vermillian sparrow need make normal N2MN
,2830619--flame viper
,60862676--flame cerberus
--end
--**Race Zombie
,511005702--pumpking king of ghosts
--shadow spector 
--skull servant
--zombie warrior N2MN
--snake hair 
,20277860--armored zombie
,66672569--dragon zombie
,92667214--clown zombie
--graveyard hand of invitation
,32864--the 13th grave
--fiends hand
--blue eyes sliver zombie
--temple of skulls
--dororzio the grim reaper
--fire reaper
--mech mole zombie
,61201220--phantom ghosts
--flame ghost DOR N2M
,41949033--dark assialiant
,71280811--yaranzo
,33734439--three legged zombie
--shadow ghoul
,46474915--magical ghost
,34290067--corroding shark
--skelgon N2MN
--bone mouse
,93788854--the wandering doomed
--great mammoth of goldfine N2MN
,95265975--ghoul with an appetite
--practioner of darkness N2MN
--end
--**Race Fiend**
,68339286--metal guardian 
,13945283--wall of illusion
,62121--castle of dark illusions
,13723605--man-eatting tresure chest

--**Race Dinosaur**
,13069066--sword arm of dragon 
,94119974--twoheaded king rex
,40374923--mammoth graveyard
,75390004--megazowler
,1784619--uraby
,38289717--crawling dragon #2
,46457856--Tomozaurus
,57305373--twomouth dark ruler
,89904598--Anthrosaurus
,42348802--trakodon
,42625254--little d
--end
--Race BEAST**
,5818798--gazelle king of mystical beasts
,99261403--dark rabbit




} 

pack[2][4]={ 
511005745--mystical elf
,511005722--dark elf
--pgreat moth
,511005719--mask of darkness
,33589925--Revived Serpent Night Dragon
,2964201--eggs start
,42418084
,36121917
,98582704
,11793047--eggs end
,511002500--c.e piller cards start
,58192742
,81179446
,511005754--needle worm 
,77568553--cocoon evolution piller cards end
,24311372--zoa
,511005652--kuriboh
,52040216--harpies pet dragon
,74677422--red eyes black dragon
,46986416--dark magician
,511005730--darkfire dragon
,6368038--gaia the fierce knight
,58192742--petit moth
,4179849--queen of autm leaves
,51371017--princess of tsurgai
,50176820--mech bass
,54098121--mysterious puppteer
,47986555--millennium golem
,11714098--30,00 year old white turtle
,50259460--versago the destroyer
,52584282--herculues beetle
,89631141--blue eyes white dragon
,69455834--king of yamikai
,10538007--leogun
,68870276--fiend reflection #1
,18246479--battle steer
,95744531--griggle
,7670542--bio plant
,41392891--feral imp
,67724379--kourmori dragon
,511005626--curse of dragon 
--turtle shell list
,55784832--Morinphen 
,23659124--Sea King Dragon 
,45042329--Tripwire Beast 
,12146024--Bolt Escargot 
,9540040--Boulder Tortoise  
,33599990--catapult turtle
,15820147--Monsturtle
,37313348--Turtle Tiger
--Psychic Kappa
,11714098--30,000-Year White Turtle
,48109103--Kappa Avenger 
,17441953--Turtle Raccoon
,72929454--Turtle Bird 
,96981563--Giant Turtle Who Feeds on Flames 
,2118022--Hyosube 
,511005720--mukamuka
--end

}

 pack[2][5]={ 
 33569923
,33589913
,33589914
,99426834--beastking of the swamps
,33589919
,33589933
,33589938

,33589994
,33589995
,33589996
,33589997

,33599921
,33599922
,511005650
,511005653
,511005664
,511005671
,511005672

,511005695
 
}
 		
pack[3]={}
 pack[3][1]={  
33589922
,33589923
,33599901--Labrynth wall
,511005702--pumpking
,54652250--maneater bug
--pgreat moth
,83764718--monster reborn
,33589932--HARPIES FEATHER DUSTER
,33569930--antimagic fragrance
,33569931--enchanted javlin
,33569938--crush card
,33569939--insect imitation
,33569953--multiply
,511005692--lord of d
,33579972--timeseal
,33579975--heavy storm
,511005672--shadow of eyes
--larvaofmoth
,335599191--copycat
,511005680--seal of the ancients
--pupaofmoth
,511005660--tree of enlightment

}

 pack[3][2]={ 
33569913
,511005721--stop defense
,33599986--magical neutralizing forcefield
,33569925
,33569927
,33569928
,33569932
,33569939
,33569940
,511005727
,33579964

,511005728
,33579974
,33579975
,511005706
,33579989
,33589901
,33589905
,511005731--ookazi
,511005732--hinotama
,511005733--sparks
,33589921
,33589922
,33589923

,33589930
,33589932
,33589935
,33589937
,33589939


,33589953
,33589959
,33589963
,33589964
,33589965
,33589966
,33589967
,33589968
,33589970
,33589971
,33589972
,33589973
,33589974
,33589976
,33589977
,33589978
,511005756
,33589988
,33589991
,33599900

,33599902
,335599157
,511005761
,511005736
,335599191
,511005763
,511005764
,335599195
,335599196
,33599966--axe of despair
,33599967--violet crystal
,33599968--silver bow and arrow
,33599969--raise body heat
,33599970--vile germs
,33599971--dragon treasure
,33599972--kunai with chain 
,33599973--7 completed
,33599974--sword of dark destruction
,33599975--Legendary sword
,33599976--gust fan 
,33599977--beast fangs
,33599978--black pendant
,33599979--laser cannon with laser
,33599980--insect armor with laser cannon 
,33599981--buring spear 
,33599982--follow wind
,33599983--fiend castle



,33589992--invigoration
,33589999--spring of rebirth


 
}

--monsters 
 pack[3][3]={ 
 33559910
,511005717
,511005718
,33559920
,33559921
,33559930
,511005719
,33569900
,511005739
,33569905
,33569910
,33569911
,33569913
,33569916
,33569917
,511005720
,511005740
,33569924
,33569926
,33569929
,511005722
,33569934
,511005703

,33569944
,33569945
,511005741
,511005724
,511005742
,511005743

,33569961
,511005725
,511005704
,33579928
,511005744
,33579930
,33579931
,511005726
,33579933
511005745
,511005705
,33579970
,511005765
,511005746
,511005747
,33579978
,33579979
,511005748
,511005749
,33579982
,511005750
,33579984
,33579988
,33579990
,511005729
,33579992
,33579993
,511005751
,511005752
,33579999
,33589900
,33589903
,511005753
,33589907
,33589908
,511005755
,33589912
,33589915
,33589917
,33589918

,511005730
,33589969
,33589980
,511005757
,33589990
,33599903
,33599923
,33599943
,33599944
,33599946
,33599948

,511005758
,33599952
,33599955
,511005707
,335599151
,335599152
,511005760
,511005708
,335599158
,335599160
,335599161

,335599169
,335599170

,335599172
,335599173
,335599174
,335599175
,335599176
,335599177
,511005762
,335599182
,511005734
,511005735
,335599188
,335599198
,335599199
,511004312
,511004316
,511004319
,511004321
,511004324
,511004329
,511004330
,511004332
,511004333
,511004334
,511004338
,511004342
,511004344
,511005597
,511005602
,511005607
,511005608

,511005610
,511005611
,511005612
,511005613
,511005614
,511005615
,511005616
,511005617
,511005618
,511005619
,511005620
,511005621
,511005622
,511005626

,511005632
,511005651
,511005652
,511005658
,511005659

,511005663
,511005665
,511005666
,511005667
,511005669
,511005673
,511005674
,511005675
,511005676
,511005677
,511005678
,511005681
,511005683
,511005684
,511005685
,511005687
,511005689
,511005690
,511005691
,511005692
,511005693
,511005694
,511005696
,511005698
,511005699
,511005700

,511005694--Yashinoki (DOR)

--**race Beast warrior**
,14977074--garoozis
,76184692--hestome giant
,5053103--battle ox
,32452818--beaver warrior
,49791927--tiger ax
,45121025--ogre of the black shadow
,26378150--rude kaiser
,511005724--pantherwarrior
,56369281--wolf axwielder

--end
--**Race Pyro**
--dragon piper
,92944626--wigs of wicked flame
--chuburan the flame knight N2MN
,88435542--fire eye
--hinotama soul
,71407486--fireyaru
--vermillian sparrow need make normal N2MN
,2830619--flame viper
,60862676--flame cerberus
--end
--**Race Zombie
,511005702--pumpking king of ghosts
--shadow spector 
--skull servant
--zombie warrior N2MN
--snake hair 
,20277860--armored zombie
,66672569--dragon zombie
,92667214--clown zombie
--graveyard hand of invitation
,32864--the 13th grave
--fiends hand
--blue eyes sliver zombie
--temple of skulls
--dororzio the grim reaper
--fire reaper
--mech mole zombie
,61201220--phantom ghosts
--flame ghost DOR N2M
,41949033--dark assialiant
,71280811--yaranzo
,33734439--three legged zombie
--shadow ghoul
,46474915--magical ghost
,34290067--corroding shark
--skelgon N2MN
--bone mouse
,93788854--the wandering doomed
--great mammoth of goldfine N2MN
,95265975--ghoul with an appetite
--practioner of darkness N2MN
--end
--**Race Fiend**
,68339286--metal guardian 
,13945283--wall of illusion
,62121--castle of dark illusions
,13723605--man-eatting tresure chest

--**Race Dinosaur**
,13069066--sword arm of dragon 
,94119974--twoheaded king rex
,40374923--mammoth graveyard
,75390004--megazowler
,1784619--uraby
,38289717--crawling dragon #2
,46457856--Tomozaurus
,57305373--twomouth dark ruler
,89904598--Anthrosaurus
,42348802--trakodon
,42625254--little d
--end
--Race BEAST**
,5818798--gazelle king of mystical beasts
,99261403--dark rabbit



}



--required card pack
 pack[3][4]={ 511005745--mystical elf
,511005722--dark elf
,511005603--pgreat moth
,511005719--mask of darkness
,2964201--eggs start
,42418084
,36121917
,98582704
,11793047--eggs end
,511002500--c.e piller cards start
,58192742
,81179446
,511005754--needle worm 
,3797883--slot machine
,511005652--kuriboh
,77568553--cocoon evolution piller cards end
,24311372--zoa
,52040216--harpies pet dragon
,74677422--red eyes black dragon
,46986416--dark magician
,511005730--darkfire dragon
,6368038--gaia the fierce knight
,58192742--petit moth
,4179849--queen of autm leaves
,51371017--princess of tsurgai
,54098121--mysterious puppetier
,47986555--millennium golem
,11714098--30,00 year old white turtle
,50259460--versago the destroyer
,52584282--herculues beetle
,89631141--blue eyes white dragon
,69455834--king of yamikai
,10538007--leogun
,68870276--fiend reflection #1
,18246479--battle steer
,95744531--griggle
,7670542--bio plant
,41392891--feral imp
,67724379--kourmori dragon
,511005626--curse of dragon 
,70781052--summoned skull
,64271667--meteor dragon
,99426834--beastking of the swamps

}

 pack[3][5]={ 33569923
,33589913
,33589914
,33589919
,33589933
,99426834--beastking of the swamps
,33589938
,33589993
,33589994
,33589995
,33589996
,33589997
,33589998
,33599921
,33599922
,511005650
,511005653
,511005664
,511005671
,511005672

,511005695
  
}  		

pack[4]={}

--Rare
 pack[4][1]={  
 33589922
,33589923
,99426834--beastking of the swamps
,511005702--pumpking
--pgreat moth
,33599962--mimicat
,83764718--monster reborn
,33599986--magical neutralizing forcefield
,511002501--greatmoth
,33569930--antimagic fragrance
,33569931--enchanted javlin
,33589932--HARPIES FEATHER DUSTER
,33569939--insect imitation
,33569953--multiply
,511005692--lord of d
,33579972--timeseal
,33579975--heavy storm
,511005672--shadow of eyes
,54652250--maneater bug
--toonworld
--larvaofmoth
,335599191--copycat
,511005680--seal of the ancients
--pupaofmoth
,511005611--temple of skulls
,511005660--tree of enlightment
 
}

--Power ups No rituals 
 pack[4][2]={ 
33569913
,511005721--stop defense
,33569925
,33599986--magical neutralizing forcefield
,33569927
,33569928
,33569932
,33569939
,33569940
,511005727
,33579964

,511005728
,33579974
,33579975
,511005706
,33579989
,33589901
,33589905
,511005731--ookazi
,511005732--hinotama
,511005733--sparks
,33599966--axe of despair
,33599967--violet crystal
,33599968--silver bow and arrow
,33599969--raise body heat
,33599970--vile germs
,33599971--dragon treasure
,33599972--kunai with chain 
,33599973--7 completed
,33599974--sword of dark destruction
,33599975--Legendary sword
,33599976--gust fan 
,33599977--beast fangs
,33599978--black pendant
,33599979--laser cannon with laser
,33599980--insect armor with laser cannon 
,33599981--buring spear 
,33599982--follow wind
,33599983--fiend castle


,33589992--invigoration
,33589999--spring of rebirth
,33589923
,33589930
,33589932
,33589935
,33589937
,33589939


,33589953
,33589959
,33589963
,33589964
,33589965
,33589966
,33589967
,33589968
,33589970
,33589971
,33589972
,33589973
,33589974
,33589976
,33589977
,33589978
,511005756
,33589988
,33589991
,33599900
,33599902
,335599157
,511005761
,511005736
,335599191
,511005763
,511005764
,335599195
,335599196

  
}

 pack[4][3]={
 33559910
,511005717
,511005718
,33559920
,33559921
,33559930
,511005719
,33569900
,511005739
,33569905
,33569910
,33569911
,33569913
,33569916
,33569917
,511005720
,511005740
,33569924
,33569926
,33569929
,511005722
,33569934
,511005703
,33569944
,33569945
,511005741
,511005724
,511005742
,511005743
,33569961
,511005725
,511005704
,33579928
,511005744
,33579930
,33579931
,511005726
,33579933
511005745
,511005705
,33579970
,511005765
,511005746
,511005747
,33579978
,33579979
,511005748
,511005749
,33579982
,511005750
,33579984
,33579988
,33579990
,511005729
,33579992
,33579993
,511005751
,511005752
,33579999
,33589900
,33589903
,511005753
,33589907
,33589908
,511005755
,33589912
,33589915
,33589917
,33589918
,511005730
,33589969
,33589980
,511005757
,33589990
,33599903
,33599923
,33599943
,33599944
,33599946
,33599948
,511005758
,33599952
,33599955
,511005707
,335599151
,335599152
,511005760
,511005708
,335599158
,335599160
,335599161
,335599169
,335599170
,335599172
,335599173
,335599174
,335599175
,335599176
,335599177
,511005762
,335599182
,511005734
,511005735
,335599188
,335599198
,335599199
,511004312
,511004316
,511004319
,511004321
,511004324
,511004329
,511004330
,511004332
,511004333
,511004334
,511004338
,511004342
,511004344
,511005597
,511005602
,511005607
,511005608

,511005610
,511005611
,511005612
,511005613
,511005614
,511005615
,511005616
,511005617
,511005618
,511005619
,511005620
,511005621
,511005622
,511005626

,511005632
,511005651
,511005652
,511005658
,511005659
,511005663
,511005665
,511005666
,511005667
,511005669
,511005673
,511005674
,511005675
,511005676
,511005677
,511005678
,511005681
,511005683
,511005684
,511005685
,511005687
,511005689
,511005690
,511005691
,511005692
,511005693
,511005694
,511005696
,511005698
,511005699
,511005700

--**race Beast warrior**
,14977074--garoozis
,76184692--hestome giant
,5053103--battle ox
,32452818--beaver warrior
,49791927--tiger ax
,45121025--ogre of the black shadow
,26378150--rude kaiser
,511005724--pantherwarrior
,56369281--wolf axwielder
--end
--**Race Pyro**
--dragon piper
,92944626--wigs of wicked flame
--chuburan the flame knight N2MN
,88435542--fire eye
--hinotama soul
,71407486--fireyaru
--vermillian sparrow need make normal N2MN
,2830619--flame viper
,60862676--flame cerberus
--end
--**Race Zombie
,511005702--pumpking king of ghosts
--shadow spector 
--skull servant
--zombie warrior N2MN
--snake hair 
,20277860--armored zombie
,66672569--dragon zombie
,92667214--clown zombie
--graveyard hand of invitation
,32864--the 13th grave
--fiends hand
--blue eyes sliver zombie
--temple of skulls
--dororzio the grim reaper
--fire reaper
--mech mole zombie
,61201220--phantom ghosts
--flame ghost DOR N2M
,41949033--dark assialiant
,71280811--yaranzo
,33734439--three legged zombie
--shadow ghoul
,46474915--magical ghost
,34290067--corroding shark
--skelgon N2MN
--bone mouse
,93788854--the wandering doomed
--great mammoth of goldfine N2MN
,95265975--ghoul with an appetite
--practioner of darkness N2MN
--end
--**Race Fiend**
,68339286--metal guardian 
,13945283--wall of illusion
,62121--castle of dark illusions
,13723605--man-eatting tresure chest

--**Race Dinosaur**
,13069066--sword arm of dragon 
,94119974--twoheaded king rex
,40374923--mammoth graveyard
,75390004--megazowler
,1784619--uraby
,38289717--crawling dragon #2
,46457856--Tomozaurus
,57305373--twomouth dark ruler
,89904598--Anthrosaurus
,42348802--trakodon
,42625254--little d
--end
--Race BEAST**
,5818798--gazelle king of mystical beasts
,99261403--dark rabbit


}

 pack[4][4]={ 511005745--mystical elf
,511005722--dark elf
,511005603--pgreat moth
,511005719--mask of darkness
,31786629--thunder dragon
,2964201--eggs start
,42418084
,36121917
,98582704
,11793047--eggs end
,511002500--c.e piller cards start
,58192742
,81179446
,511005754--needle worm 
,77568553--cocoon evolution piller cards end
,24311372--zoa
,52040216--harpies pet dragon
,74677422--red eyes black dragon
,511005652--kuriboh
,46986416--dark magician
,511005730--darkfire dragon
,6368038--gaia the fierce knight
,58192742--petit moth
,4179849--queen of autm leaves
,51371017--princess of tsurgai
,54098121--mysterious puppetier
,47986555--millennium golem
,11714098--30,00 year old white turtle
,50259460--versago the destroyer
,52584282--herculues beetle
,89631141--blue eyes white dragon
,69455834--king of yamikai
,10538007--leogun
,68870276--fiend reflection #1
,18246479--battle steer
,95744531--griggle
,7670542--bio plant
,41392891--feral imp
,67724379--kourmori dragon
,511005626--curse of dragon 
,70781052--summoned skull
,64271667--meteor dragon
,99426834--beastking of the swamps
}


--traps/rituals?
 pack[4][5]={ 
 33569923
,33589913
,33589914
,33589919
,33589933
,33589938
,33589993
,33589994
,33589995
,99426834--beastking of the swamps
,33589996
,33589997
,33589998
,33599921
,33599922
,511005650
,511005653
,511005664
,511005671
,511005672

,511005695
 
}  		
		
local packopen=false
local handnum={[0]=7;[1]=7}

--DangerZone

local side={[0]={};[1]={}}
local function _prepSide(p,g)
	local c=g:GetFirst()
	while c do
		table.insert(side[p],c:GetOriginalCode())
		c=g:GetNext()
	end
end

local function _printDeck()
	local io=require("io")
	for p=0,1 do
		local f=io.open("./deck/sealedpack"..p..".ydk","w+")
		f:write("#created by ...\n#main\n")
		local g=Duel.GetFieldGroup(p,LOCATION_DECK+LOCATION_HAND,0)
		local c=g:GetFirst()
		while c do
			f:write(c:GetOriginalCode().."\n")
			c=g:GetNext()
		end
		f:write("#extra\n")
		g=Duel.GetFieldGroup(p,LOCATION_EXTRA,0)
		c=g:GetFirst()
		while c do
			f:write(c:GetOriginalCode().."\n")
			c=g:GetNext()
		end
		f:write("!side\n")
		for _,i in ipairs(side[p]) do
			f:write(i.."\n")
		end
		f:close()
	end
end

scard.collection2={ 
[33599941]=true;--red rose
[33599942]=true;--white rose
[33589934]=true;--dor draw 
[scard]=true;--rose duel 
[33589936]=true;-- destiny draw

}

function scard.filter(c)
return scard.collection2 and c:IsFaceup() or (c:IsCode(33589936) and c:IsLocation(LOCATION_HAND))
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	if packopen then e:Reset() return end
	packopen=true
	Duel.DisableShuffleCheck()
	local c=e:GetHandler()
	if not Duel.SelectYesNo(1-tp,aux.Stringid(4359,1)) or not Duel.SelectYesNo(tp,aux.Stringid(4359,1)) then
	--remove rose cards and dor draw
   local sg=Duel.GetMatchingGroup(scard.filter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED+LOCATION_ONFIELD,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED+LOCATION_ONFIELD,nil)
	local tc=sg:GetFirst()
	sg:RemoveCard(e:GetHandler())
	if sg:GetCount()==0 then return end
    Duel.SendtoDeck(sg,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
    sg:KeepAlive()	
	--vanish rose duel if no
	local c=e:GetHandler()
    Duel.Remove(c,POS_FACEUP,REASON_EFFECT,tp)
    Duel.SendtoDeck(c,nil,-2,REASON_EFFECT+REASON_TEMPORARY)
        return
    end
	--Hint
	Duel.Hint(HINT_CARD,0,s_id)
	for p=0,1 do
	--token zone
		local c=Duel.CreateToken(p,s_id)
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		Duel.Hint(HINT_CODE,p,s_id)
		
		--protection (steal Boss Duel xD)
		local e10=Effect.CreateEffect(c)
		e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e10:SetType(EFFECT_TYPE_SINGLE)
		e10:SetCode(EFFECT_CANNOT_TO_GRAVE)
		c:RegisterEffect(e10)
		local e11=e10:Clone()
		e11:SetCode(EFFECT_CANNOT_TO_HAND)
		c:RegisterEffect(e11)
		local e12=e10:Clone()
		e12:SetCode(EFFECT_CANNOT_TO_DECK) 
		c:RegisterEffect(e12)
		local e13=e10:Clone()
		e13:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
		c:RegisterEffect(e13)
	end
	--note hand card
	handnum[0]=7 --Duel.GetFieldGroupCount(0,LOCATION_HAND,0)
	handnum[1]=7 --Duel.GetFieldGroupCount(1,LOCATION_HAND,0)
	--SetLP
	Duel.SetLP(0,4000)
	Duel.SetLP(1,4000)
	--FOR RANDOOM
	local rseed=0
	for i=1,6 do
		local r={Duel.TossCoin(i%2,5)}
		for n=1,5 do
			rseed=bit.lshift(rseed,1)+r[n]
		end
	end
	math.randomseed(rseed)
	local fg=Duel.GetFieldGroup(0,0x43,0x43)
	--remove all cards
	Duel.SendtoDeck(fg,nil,-2,REASON_RULE)
	--Open packs (let's keep it at 10 for now)
	local numpack=10
	for np=1,numpack do
		for p=0,1 do
			local n=math.random(4)
			Duel.Hint(HINT_OPSELECTED,p,aux.Stringid(4002,2+n))
			local g=Group.CreateGroup()
			for i=1,5 do
				local cpack=pack[n][i]
				local c=cpack[math.random(#cpack)]
				g:AddCard(Duel.CreateToken(p,c))
			end
			local ga=g:Filter(Card.IsAbleToHand,nil)
			Duel.SendtoHand(g,nil,REASON_RULE)
			Duel.ConfirmCards(p,g:Filter(Card.IsLocation,nil,LOCATION_EXTRA))
			Duel.SendtoDeck(g:Filter(Card.IsLocation,nil,LOCATION_HAND),nil,2,REASON_RULE)
		end
	end
	--next step
	--Players remove from each deck until card=40 
	local rg=Group.CreateGroup()
	for p=0,1 do
		Duel.ConfirmCards(p,Duel.GetFieldGroup(p,LOCATION_DECK+LOCATION_EXTRA,0))
		local num=Duel.GetFieldGroupCount(p,LOCATION_DECK,0)-40
		if num>0  then
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_REMOVE)
			local g=Duel.GetFieldGroup(p,LOCATION_DECK,0):Select(p,10,num,nil)
			_prepSide(p,g)
			rg:Merge(g)
		end
	end
	
	if rg:GetCount()>0 then Duel.SendtoDeck(rg,nil,-2,REASON_RULE) end
	--next step
	--Shuffle deck and add card

	for p=0,1 do
		Duel.ShuffleDeck(p)
	end
	--before duel starts
	local c=e:GetHandler()
	local tp=c:GetControler()
	local token=Duel.CreateToken(tp,33599941)
	Duel.SendtoDeck(token,tp,POS_FACEDOWN,REASON_EFFECT)
	local token2=Duel.CreateToken(1-tp,33599942)
	Duel.SendtoDeck(token2,1-tp,POS_FACEDOWN,REASON_EFFECT)
	local token3=Duel.CreateToken(tp,33589934)
	Duel.SendtoHand(token3,tp,2,REASON_EFFECT)
	Duel.Remove(token3,POS_FACEUP,REASON_RULE)
	local token4=Duel.CreateToken(1-tp,33589934)
	Duel.SendtoHand(token4,1-tp,2,REASON_EFFECT)
	Duel.Remove(token4,POS_FACEUP,REASON_RULE)
	local token5=Duel.CreateToken(tp,33599949)
	Duel.SendtoHand(token5,tp,2,REASON_EFFECT)
	Duel.MoveToField(token5,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	
	for p=0,1 do
		Duel.SendtoHand(Duel.GetDecktopGroup(p,handnum[p]),nil,REASON_RULE)
	end
	e:Reset()
	--if someone wants/needs a deck listing (local hosting only), the function itself can be uncommented
	_printDeck()
	-- exicute add destiny draw and generate fusion extra deck
	for p=0,1 do
	local token5=Duel.CreateToken(p,33589936)
	Duel.SendtoDeck(token5,p,POS_FACEDOWN,REASON_EFFECT)
	local token6=Duel.CreateToken(p,511000477)
	Duel.SendtoDeck(token6,p,POS_FACEDOWN,REASON_EFFECT)
	local token7=Duel.CreateToken(p,33599950)
	Duel.SendtoDeck(token7,p,POS_FACEDOWN,REASON_EFFECT)
	local token8=Duel.CreateToken(p,90660762)
	Duel.SendtoDeck(token8,p,POS_FACEDOWN,REASON_EFFECT)
	local token9=Duel.CreateToken(p,94905343)
	Duel.SendtoDeck(token9,p,POS_FACEDOWN,REASON_EFFECT)
	local token10=Duel.CreateToken(p,11901678)
	Duel.SendtoDeck(token10,p,POS_FACEDOWN,REASON_EFFECT)
	local token11=Duel.CreateToken(p,66889139)
	Duel.SendtoDeck(token11,p,POS_FACEDOWN,REASON_EFFECT)
	local token12=Duel.CreateToken(p,16507828)
	Duel.SendtoDeck(token12,p,POS_FACEDOWN,REASON_EFFECT)
	local token13=Duel.CreateToken(p,54752875)
	Duel.SendtoDeck(token13,p,POS_FACEDOWN,REASON_EFFECT)
	local token14=Duel.CreateToken(p,89112729)
	Duel.SendtoDeck(token14,p,POS_FACEDOWN,REASON_EFFECT)
	local token15=Duel.CreateToken(p,54622031)
	Duel.SendtoDeck(token15,p,POS_FACEDOWN,REASON_EFFECT)
	local token16=Duel.CreateToken(p,32485271)
	Duel.SendtoDeck(token16,p,POS_FACEDOWN,REASON_EFFECT)
	local token17=Duel.CreateToken(p,4796100)
	Duel.SendtoDeck(token17,p,POS_FACEDOWN,REASON_EFFECT)
	
	end
end


	--fusion list
	--[[11901678--b.skull dragon ==summoned skull + redeyes black dragon
94905343--rabid horseman== battle ox + mystical horseman
90660762--Meteor Dragon == redeyes black dragon + meteor dragon 
33599950--fire kraken
16507828--Bracchio-raidus
66889139--gaia the dragon champian
511000477--wall shadow
54752875--twin headed thunder dragon
89112729--cyber sarus
54622031--golden mammoth of goldfine
32485271--rose specture of dune
4796100--chimera king of mystical beasts
]]--
	

	


--Nocheat zone

function scard.flag_chk(c)
	return c:GetFlagEffect(s_id)==0 
end

function scard.nt_cd(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()>1 and Duel.IsExistingMatchingCard(scard.flag_chk,Duel.GetTurnPlayer(),0x43,0,1,nil)
end

function scard.nt_op(e,tp,eg,ep,ev,re,r,rp)
if e:GetHandler():IsLocation(LOCATION_REMOVED)	then return true
else return false end
	Duel.DisableShuffleCheck()
	--Hint
	local p=Duel.GetTurnPlayer()
	Duel.Hint(HINT_CARD,p,s_id)
	Duel.Hint(HINT_CODE,p,s_id)
	--note hand card
	local hn=5 --Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	local fg=Duel.GetMatchingGroup(scard.flag_chk,p,0x43,0,nil)
	--remove all cards
	Duel.SendtoDeck(fg,nil,-2,REASON_RULE)
	--Open packs (let's keep it at 10 for now)
	local numpack=10
	for np=1,numpack do
		local n=math.random(4)
		Duel.Hint(HINT_OPSELECTED,p,aux.Stringid(4002,2+n))
		local g=Group.CreateGroup()
		for i=1,5 do
			local cpack=pack[n][i]
			local c=cpack[math.random(#cpack)]
			g:AddCard(Duel.CreateToken(p,c))
		end
		local ga=g:Filter(Card.IsAbleToHand,nil)
		Duel.SendtoHand(g,nil,REASON_RULE)
		Duel.ConfirmCards(p,g:Filter(Card.IsLocation,nil,LOCATION_EXTRA))
		Duel.SendtoDeck(g:Filter(Card.IsLocation,nil,LOCATION_HAND),nil,2,REASON_RULE)
	end
	--next step
	--Players remove from each deck until card>=40 (optional)
	local rg=Group.CreateGroup()
	Duel.ConfirmCards(p,Duel.GetFieldGroup(p,LOCATION_DECK+LOCATION_EXTRA,0))
	local num=Duel.GetFieldGroupCount(p,LOCATION_DECK,0)-40
	if num>0 and Duel.SelectYesNo(p,aux.Stringid(4002,7)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_REMOVE)
		local g=Duel.GetFieldGroup(p,LOCATION_DECK,0):Select(p,1,num,nil)
		rg:Merge(g)
	end
	if rg:GetCount()>0 then Duel.SendtoDeck(rg,nil,-2,REASON_RULE) end
	--next step
	--Shuffle deck and add card
	Duel.ShuffleDeck(p)
	Duel.SendtoHand(Duel.GetDecktopGroup(p,hn),nil,REASON_RULE)
		end
