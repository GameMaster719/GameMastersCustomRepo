--Steel Shell (DOR)
--scripted by GameMaster (GM)
function c33589959.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33589959.target)
	e1:SetOperation(c33589959.activate)
	c:RegisterEffect(e1)
end

--[[Morinphen--55784832
Sea King Dragon--23659124
Tripwire Beast--45042329
Bolt Escargot--12146024
Boulder Tortoise--9540040
Catapult Turtle--95727991
Monsturtle--15820147
Turtle Tiger--37313348
Psychic Kappa--7892180
30,000-Year White Turtle--11714098
Kappa Avenger--48109103
Turtle Raccoon--17441953
Turtle Bird--72929454
Crab Turtle--91782219
Giant Turtle Who Feeds on Flames--96981563
Hyosube--2118022
Muka Muka--46657337  ]]--

c33589959.collection={ [55784832]=true; [23659124]=true; [45042329]=true; [12146024]=true; [9540040]=true;  [95727991]=true; [15820147]=true;
 [37313348]=true; [7892180]=true; [11714098]=true; [48109103]=true; [17441953]=true; [72929454]=true; [91782219]=true; [96981563]=true; [2118022]=true; [46657337]=true; }


function c33589959.filter(c)
	return  c33589959.collection[c:GetCode()]
end

function c33589959.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if chk==0 then return Duel.IsExistingTarget(c33589959.filter,tp,LOCATION_MZONE,0,1,tc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33589959.filter,tp,LOCATION_MZONE,0,1,1,tc)
end

function c33589959.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(500)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	tc:RegisterEffect(e2)
		end
end
