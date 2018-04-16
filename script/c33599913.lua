--Limit Tribute (Anime)
--scripted by GameMaster(GM)
function c33599913.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)
    --Restrict summon of monsters needing 2 tributes or more
    local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTarget(c33599913.sumtg)
	e2:SetTargetRange(1,1)
   	c:RegisterEffect(e2)
    local e3=e2:Clone()
    e3:SetCode(EFFECT_CANNOT_MSET)
    c:RegisterEffect(e3)
    --Responding-if a monster is triubted
    local e4=Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_RELEASE)
	e4:SetRange(LOCATION_SZONE)
    e4:SetCondition(c33599913.con4)
	e4:SetOperation(c33599913.relimit)
	c:RegisterEffect(e4)
	  --Restrict Release
    local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EFFECT_CANNOT_RELEASE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
    e5:SetCondition(c33599913.conA)
	c:RegisterEffect(e5)
    local e6=e5:Clone()
    e6:SetTargetRange(0,1)
    e6:SetCondition(c33599913.conB)
    c:RegisterEffect(e6)
	
end

function c33599913.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsReason(REASON_RELEASE)
end

function c33599913.con4(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c33599913.filter,1,nil,tp)
end

function c33599913.conA(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
    return e:GetHandler():GetFlagEffect(33599913)~=0 
end
function c33599913.conB(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
    return e:GetHandler():GetFlagEffect(33599913)~=0 
end





function c33599913.sumtg(e,c,tp,sumtp)
	return bit.band(sumtp,SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE and c:GetLevel()>6  
end

function c33599913.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsReason(REASON_RELEASE)
end

function c33599913.relimit(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp then
        e:GetHandler():RegisterFlagEffect(33599913,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,0,1)
    else
        e:GetHandler():RegisterFlagEffect(33599913,RESET_EVENT+0x3ff0000+RESET_PHASE+PHASE_END,0,1)
    end
end




