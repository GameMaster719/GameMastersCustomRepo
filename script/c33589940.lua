--Toon World (DOR)
--scripted by GameMaster(GM)
function c33589940.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	-- atk up by 500
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(c33589940.tg)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	-- minus 500 for non toon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c33589940.tg2)
	e4:SetValue(-500)
	c:RegisterEffect(e4)
	--Def
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
end

--niwatori==[7805359]
--stuffed animal==[71068263]
--genin==[49370026]
--parrot dragon==[62762898]
--hungry burger==[30243636]
--dark rabbit==[99261403]
--saggi the dark clown==[66602787]
--Burcuribox==[25655502] 
--Manga RyuRan==[38369349]

--Strong in toon world DOR cards 
c33589940.collection={ [7805359]=true; [71068263]=true; [49370026]=true; [62762898]=true;
 [30243636]=true; [99261403]=true; [66602787]=true; [25655502]=true;  [38369349]=true; }

 
 function c33589940.tg(e,c)
	return  c:IsSetCard(0x62)  or  c33589940.collection[c:GetCode()] or c:IsType(TYPE_TOON)
end
 
function c33589940.tg2(e,c)
	return not c:IsSetCard(0x62) and not c:IsType(TYPE_TOON)  and not c33589940.collection[c:GetCode()]
end




