--Elfs light(DOR)
--scripted by GameMaster (GM)
function c33589901.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c33589901.target)
	e1:SetOperation(c33589901.activate)
	c:RegisterEffect(e1)
end

--[[
● Mystical Elf==15025844
● Ancient Elf==93221206
● Wing Egg Elf==98582704
● Dark Elf==21417692
● Dancing Elf==59983499 
● Gemini Elf==69140098
]]--


c33589901.collection={ [15025844]=true; [21417692]=true; [59983499]=true; [69140098]=true; [93221206]=true; [98582704]=true; }


function c33589901.filter(c)
	return  c33589901.collection[c:GetCode()]
end



function c33589901.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	if chk==0 then return Duel.IsExistingTarget(c33589901.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,tc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c33589901.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc)
end

function c33589901.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e)  then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(700)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	tc:RegisterEffect(e2)
		end
end
