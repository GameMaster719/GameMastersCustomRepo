--petit angel  (DOR)
--scripted by GameMaster (GM)
function c335599184.initial_effect(c)
--special summon from grave when destroyed by battle
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
e1:SetCode(EVENT_BATTLE_DESTROYED)
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetCondition(c335599184.condition5)
e1:SetTarget(c335599184.sptg)
e1:SetOperation(c335599184.spop)
c:RegisterEffect(e1)
end


function c335599184.condition5(e,tp)
local tc=e:GetHandler()
if tc and tc:IsReason(REASON_BATTLE) and tc:IsLocation(LOCATION_GRAVE) and tc:GetPreviousControler()==tp then
e:SetLabel(tc:GetPreviousSequence())
return true
end
return false
end

--block previous zone and special summon
function c335599184.regop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
if bit.band(r,REASON_BATTLE)~=0 and bit.band(c:GetPreviousLocation(),LOCATION_SZONE)~=0 then
--spsummon
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(335599184,0))
e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e1:SetRange(LOCATION_GRAVE)
e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
e1:SetCost(c335599184.spcost)
e1:SetTarget(c335599184.sptg)
e1:SetOperation(c335599184.spop)
e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
c:RegisterEffect(e1)
end
end
function c335599184.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
if chk==0 then return c:GetFlagEffect(335599184)==0 end
c:RegisterFlagEffect(335599184,nil,0,1)
end
function c335599184.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
local seq=bit.lshift(0x1,e:GetLabel())
local ch=Duel.GetCurrentChain()
e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetRange(LOCATION_GRAVE)
e1:SetCode(EFFECT_DISABLE_FIELD)
e1:SetReset(RESET_CHAIN)
e1:SetOperation(function() if Duel.GetCurrentChain()==ch then return seq else return 0 end end)
Duel.RegisterEffect(e1,tp)
end
function c335599184.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local seq=bit.lshift(0x1,e:GetLabel())
if c:IsRelateToEffect(e) then 
local e1=Effect.CreateEffect(e:GetHandler())
e1:SetType(EFFECT_TYPE_FIELD)
e1:SetRange(LOCATION_GRAVE)
e1:SetCode(EFFECT_DISABLE_FIELD)
e1:SetValue(seq)
e:GetHandler():RegisterEffect(e1)
Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
e1:Reset()
end
end