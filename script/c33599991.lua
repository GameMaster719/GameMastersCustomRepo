--Dungeon worm (DOR)
--scripted by GameMaster(GM)
function c33599991.initial_effect(c)
--attach to lab.wall
local e1=Effect.CreateEffect(c)
e1:SetDescription(aux.Stringid(22222231,2))
e1:SetType(EFFECT_TYPE_QUICK_O)
e1:SetCode(EVENT_FREE_CHAIN)
e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
e1:SetRange(LOCATION_ONFIELD)
e1:SetTarget(c33599991.mattg)
e1:SetOperation(c33599991.matop)
c:RegisterEffect(e1)
   --summon eff 
local e2=Effect.CreateEffect(c)
e2:SetType(EFFECT_TYPE_IGNITION+EFFECT_TYPE_XMATERIAL)
e2:SetCode(EVENT_FREE_CHAIN)
e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
e2:SetCondition(c33599991.con)
e2:SetRange(LOCATION_OVERLAY)
e2:SetTarget(c33599991.mttarget)
e2:SetOperation(c33599991.op)
c:RegisterEffect(e2)
end
--------------
function c33599991.filter2(c)
return c:GetOriginalCode()==33599901
end

function c33599991.mttarget(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chk==0 then return e:GetHandler()
	and Duel.IsExistingTarget(Card.GetOriginalCodeCode,tp,LOCATION_MZONE,0,1,nil,33599901) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,Card.IsCode,tp,LOCATION_MZONE,0,1,1,nil,33599901)
end

function c33599991.con(e,c)
return Duel.IsExistingMatchingCard(c33599991.filter2,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil,33599901)
end
function c33599991.op(e,tp,eg,ep,ev,re,r,rp,chk)	
local g=Duel.GetOverlayGroup(tp,1,1)
if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,nil,tp,tp,true,false,POS_FACEUP)
	local tc=sg:GetFirst()
	end
end		

-------------

function c33599991.matfilter(c)
return c:IsFaceup() and c:GetOriginalCode()==33599901
end

function c33599991.mattg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_ONFIELD) and chkc:IsControler(tp) and c33599991.matfilter(chkc) end
if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
	and Duel.IsExistingTarget(c33599991.matfilter,tp,LOCATION_ONFIELD,0,1,nil) end
Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
Duel.SelectTarget(tp,c33599991.matfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
end

function c33599991.matop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local tc=Duel.GetFirstTarget()
if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e)  then
Duel.Overlay(tc,Group.FromCards(c))
if Duel.GetControl(tc,tp) and c:IsLocation(0x80) then 
local c=e:GetHandler()
--get effect
local e2=Effect.CreateEffect(e:GetHandler())
e2:SetDescription(aux.Stringid(31755044,1))
e2:SetType(EFFECT_TYPE_XMATERIAL)
e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
e2:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
e2:SetRange(LOCATION_OVERLAY)
c:RegisterEffect(e2)	
	end
end
end
