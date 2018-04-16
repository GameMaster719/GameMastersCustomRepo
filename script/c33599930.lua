--split soul baboon
function c33599930.initial_effect(c)
--fusion material
c:EnableReviveLimit()
--fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c33599930.fscon)
	e1:SetOperation(c33599930.fsop)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c33599930.atklimit)
	c:RegisterEffect(e2)
	--double attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end

function c33599930.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetCondition(c33599930.con)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end

function c33599930.con(e,c)
local c=e:GetHandler()
	return not c:IsHasEffect(33599931)
end

function c33599930.filter(c,fc)
	return c:IsType(TYPE_MONSTER) and not c:IsHasEffect(6205579) and c:IsCanBeFusionMaterial(fc)
end
function c33599930.spfilter(c,mg)
	return mg:IsExists(c33599930.spfilter2,1,c,c)
end
function c33599930.spfilter2(c,mc)
	return c:IsFusionCode(mc:GetFusionCode())
end
function c33599930.fscon(e,g,gc)
	if g==nil then return true end
	local mg=g:Filter(c33599930.filter,gc,e:GetHandler())
	if gc then return c33599930.filter(gc,e:GetHandler()) and c33599930.spfilter(gc,mg) end
	return mg:IsExists(c33599930.spfilter,1,nil,mg)
end
function c33599930.fsop(e,tp,eg,ep,ev,re,r,rp,gc)
	local mg=eg:Filter(c33599930.filter,gc,e:GetHandler())
	local g1=nil
	local mc=gc
	if not gc then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
		g1=mg:FilterSelect(tp,c33599930.spfilter,1,1,nil,mg)
		mc=g1:GetFirst()
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=mg:FilterSelect(tp,c33599930.spfilter2,1,1,mc,mc)
	if g1 then g2:Merge(g1) end
	Duel.SetFusionMaterial(g2)
end