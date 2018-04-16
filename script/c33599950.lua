--Fire Kraken DOR
function c33599950.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_AQUA),aux.FilterBoolFunction(Card.IsRace,RACE_PYRO),true)
end
	
	