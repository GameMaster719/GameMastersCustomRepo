--Insect Imitation (DOR)
--scripted by GameMaster (GM)+ Shad3
function c33569939.initial_effect(c)
	--Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c33569939.cost)
    e1:SetTarget(c33569939.target)
    e1:SetOperation(c33569939.activate)
    c:RegisterEffect(e1)
	--elf egg
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetCost(c33569939.cost2)
    e1:SetTarget(c33569939.target2)
    e1:SetOperation(c33569939.activate2)
    c:RegisterEffect(e1)
end

--[[
*Ryu-ran==2964201
*monster egg==36121917
*Gorgon egg==11793047


]]--
c33569939.collection={ [2964201]=true;  [36121917]=true;  [11793047]=true;  }

function c33569939.filter(c)
    return c:IsFaceup() and c33569939.collection[c:GetCode()]
end
----------------------------

function c33569939.filter2(c)
    return c:IsFaceup() and c:IsCode(98582704)
end


c33569939.collection3={ 15025844,
93221206,
21417692,
59983499, 
69140098
}



function c33569939.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroup(tp,c33569939.filter2,1,nil) end
    local g=Duel.SelectReleaseGroup(tp,c33569939.filter2,1,1,nil)
    Duel.Release(g,REASON_COST)
end

function c33569939.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=0
		and Duel.IsPlayerCanSpecialSummon(tp) end
	
end
function c33569939.activate2(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
    if Duel.GetLocationCount(tp,LOCATION_MZONE)>=0
        and Duel.IsPlayerCanSpecialSummon(tp) then
        for i=1,1 do
            local token=Duel.CreateToken(tp,c33569939.collection3[math.random(#c33569939.collection3)])
					  --SUMMON CHANGE TO FACEDOWN
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_SPSUMMON_SUCCESS)
			e1:SetOperation(c33569939.op)
			token:RegisterEffect(e1)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)
		    end
        Duel.SpecialSummonComplete()
    end
end



----------------------------
function c33569939.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.CheckReleaseGroup(tp,c33569939.filter,1,nil) end
    local g=Duel.SelectReleaseGroup(tp,c33569939.filter,1,1,nil)
    Duel.Release(g,REASON_COST)
end

function c33569939.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>=0
		and Duel.IsPlayerCanSpecialSummon(tp) end
	
end
function c33569939.activate(e,tp,eg,ep,ev,re,r,rp)
    if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
    if Duel.GetLocationCount(tp,LOCATION_MZONE)>=0
        and Duel.IsPlayerCanSpecialSummon(tp) then
        for i=1,1 do
            local token=Duel.CreateToken(tp,c33569939.collection2[math.random(#c33569939.collection2)])
					  --SUMMON CHANGE TO FACEDOWN
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_SPSUMMON_SUCCESS)
			e1:SetOperation(c33569939.op)
			token:RegisterEffect(e1)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK+POS_FACEDOWN_DEFENSE)
		    end
        Duel.SpecialSummonComplete()
    end
end

function c33569939.op(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
local e1=Effect.CreateEffect(c)
e1:SetCategory(CATEGORY_POSITION)
e1:SetType(EFFECT_TYPE_IGNITION)
e1:SetRange(LOCATION_MZONE)
e1:SetCondition(c33569939.con)
e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
e1:SetReset(RESET_PHASE+PHASE_END)
e1:SetOperation(c33569939.flipop)
c:RegisterEffect(e1)
--to defense
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(33569939,0))
e2:SetCategory(CATEGORY_POSITION)
e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
e2:SetCode(EVENT_FLIP)
e2:SetTarget(c33569939.potg)
e2:SetOperation(c33569939.poop)
e2:SetReset(RESET_PHASE+PHASE_END)
c:RegisterEffect(e2)
end 

function c33569939.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c33569939.poop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
	c:SetTurnCounter(0)
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end

function c33569939.con(e)
	return e:GetHandler():IsDefensePos()
end

function c33569939.flipop(e)
local c=e:GetHandler()
if c:IsRelateToEffect(e) and c:IsFacedown() then
Duel.ChangePosition(c,POS_FACEUP_ATTACK)
end
end

c33569939.collection2={ 91782219--crabturtle
,74677422--redeyes
,46986416--darkmagician
,33569900
,33569901
,33569903
,33569904
,33569905
,33569907
,33569908
,33569909
,33569910
,33569911
,33569912
,33569916
,33569917
,33569918
,33569921
,33569922
,33569923
,33569924
,33569926
,33569929
,33569934
,33569935
,33569936
,33569941
,33569942
,33569943
,33569944
,33569945
,33569946
,33569947
,33569948
,33569949
,33569950
,33569951
,33569954
,33569955
,33569956
,33569961
,33569962
,33569963
,33569997
,33579928
,33579929
,33579930
,33579931
,33579932
,33579933
,33579935
,33579936
,33579938
,33579939
,33579965
,33579970
,33579971
,33579976
,33579977
,33579978
,33579979
,33579980
,33579981
,33579982
,33579983
,33579984
,33579988
,33579990
,33579991
,33579992
,33579993
,33579994
,33579995
,33579997
,33579998
,33579999
,33589900
,33589902
,33589903
,33589906
,33589907
,33589908
,33589909
,33589912
,335599148
,335599149
,335599150
,335599151
,335599152
,335599153
,335599154
,335599155
,335599156
,335599158
,335599160
,335599161
,335599162
,335599163
,335599164
,335599165
,335599166
,335599167
,335599168
,335599169
,335599170
,335599171
,335599172
,335599173
,335599174
,335599175
,335599176
,335599177
,335599180
,335599181
,335599182
,335599183
,335599184
,335599186
,335599187
,335599188
,335599198
,335599199
,511004312
,511004314
,511004316
,511004319
,511004320
,511004321
,511004324
,511004329
,511004330
,511004332
,511004333
,511004334
,511004338
,511004342
,511005597
,511005602
,511005606
,511005607
,511005608
,511005609
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
,511005625
,511005626
,511005627 }