--Guardian Formation
--scripted by GameMaster(GM)
function c33579957.initial_effect(c)
    --Activate 
	--Mzone
    local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33579957,0))
    e1:SetCategory(CATEGORY_POSITION)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_BE_BATTLE_TARGET)
    e1:SetCondition(c33579957.condition1)
    e1:SetTarget(c33579957.target)
    e1:SetOperation(c33579957.activate1)
    c:RegisterEffect(e1)
	--Szone
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33579957,1))
    e1:SetCategory(CATEGORY_POSITION)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_BE_BATTLE_TARGET)
    e1:SetCondition(c33579957.condition2)
    e1:SetTarget(c33579957.target)
    e1:SetOperation(c33579957.activate2)
    c:RegisterEffect(e1)
    if not c33579957.global_check then
        c33579957.global_check=true
        --check obsolete ruling
        local ge1=Effect.CreateEffect(c)
        ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
        ge1:SetCode(EVENT_DRAW)
        ge1:SetOperation(c33579957.checkop)
        Duel.RegisterEffect(ge1,0)
    end
end
function c33579957.checkop(e,tp,eg,ep,ev,re,r,rp)
    if bit.band(r,REASON_RULE)~=0 and Duel.GetTurnCount()==1 then
        --obsolete
        Duel.RegisterFlagEffect(tp,62765383,0,0,1)
        Duel.RegisterFlagEffect(1-tp,62765383,0,0,1)
    end
end

function c33579957.filter6(c)
return c:GetOriginalCode()==400001002 and c:IsFaceup()
end






function c33579957.condition1(e,tp,eg,ep,ev,re,r,rp)
if Duel.IsExistingMatchingCard(c33579957.filter6,tp,LOCATION_FZONE,0,1,nil) then return false
else
local atk=Duel.GetAttackTarget()	 
 return  Duel.GetTurnPlayer()~=tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and (atk:IsFaceup() and atk:IsSetCard(0x52))  end
end

function c33579957.condition2(e,tp,eg,ep,ev,re,r,rp)
     local atk=Duel.GetAttackTarget()
	 local tc1=Duel.GetFieldCard(tp,LOCATION_SZONE,5)	
	 return tc1 and tc1:GetOriginalCode()==400001002 and tc1:IsFaceup() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.GetTurnPlayer()~=tp and Duel.IsExistingMatchingCard(Card.IsType,tp,LOCATION_MZONE,0,2,nil,TYPE_MONSTER) and (atk:IsFaceup() and atk:IsSetCard(0x52))
end

function c33579957.filter(c,e,tp,eg,ep,ev,re,r,rp)
  return c:GetType()==TYPE_SPELL+TYPE_FIELD and (c:GetActivateEffect():IsActivatable(tp) or Duel.GetTurnPlayer()~=tp)
  
end

function c33579957.target(e,tp,eg,ep,ev,re,r,rp,chk)
    local td=Duel.GetAttackTarget()
    if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup():IsSetCard(0x52) end
    if chk==0 then return Duel.IsExistingTarget(c33579957.filter440,tp,LOCATION_MZONE,0,1,nil) and (Duel.GetLocationCount(tp,LOCATION_MZONE)>0 or Duel.GetLocationCount(tp,LOCATION_SZONE)>0) end
    Duel.SetTargetCard(td)
end

function c33579957.filter440(c)
    return c:IsType(TYPE_MONSTER) and (c:IsFaceup() and c:IsSetCard(0x52))
  end

function c33579957.activate1(e,tp,eg,ep,ev,re,r,rp)
   local tc1=Duel.GetFieldCard(tp,LOCATION_SZONE,5)					
if tc1==nil or not tc1:GetOriginalCode()==400001002 then 
 local td=Duel.GetAttackTarget()
if td and Duel.NegateAttack() and td:IsFaceup() and td:IsRelateToEffect(e) then	
        local s=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
        local nseq=0
        if s==1 then nseq=0
        elseif s==2 then nseq=1
        elseif s==4 then nseq=2
        elseif s==8 then nseq=3
        else nseq=4 end
        Duel.MoveSequence(td,nseq)
        local acg=Duel.GetMatchingGroup(c33579957.filter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,e,tp,eg,ep,ev,re,r,rp)
        if acg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(28265983,0)) then
            local tc=acg:Select(tp,1,1,nil):GetFirst()
            local tpe=tc:GetType()
            local te=tc:GetActivateEffect()
            local tg=te:GetTarget()
            local co=te:GetCost()
            local op=te:GetOperation()
            e:SetCategory(te:GetCategory())
            e:SetProperty(te:GetProperty())
            Duel.ClearTargetCard()
            if bit.band(tpe,TYPE_FIELD)~=0 then
                local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
                if Duel.GetFlagEffect(tp,62765383)>0 then
                    if fc then Duel.Destroy(fc,REASON_RULE) end
                    of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
                    if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
                else
                    Duel.GetFieldCard(tp,LOCATION_SZONE,5)
                    if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
                end
            end
            Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
            Duel.Hint(HINT_CARD,0,tc:GetCode())
            tc:CreateEffectRelation(te)
            if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
                tc:CancelToGrave(false)
            end
            if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
            if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
            Duel.BreakEffect()
            local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
            if g then
                local etc=g:GetFirst()
                while etc do
                    etc:CreateEffectRelation(te)
                    etc=g:GetNext()
                end
            end
            if op then op(te,tp,eg,ep,ev,re,r,rp) end
            tc:ReleaseEffectRelation(te)
            if etc then 
                etc=g:GetFirst()
                while etc do
                    etc:ReleaseEffectRelation(te)
                    etc=g:GetNext()
					end

                end
            end
        end
    end
end  
  
  
  
function c33579957.activate2(e,tp,eg,ep,ev,re,r,rp)
    local td=Duel.GetAttackTarget()
 if td and Duel.NegateAttack() and td:IsFaceup() and td:IsRelateToEffect(e) then
local tc1=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
if tc1 and tc1:IsFaceup() and tc1:GetOriginalCode()==400001002 then
 local mon=Duel.GetFirstTarget()
    local dest=LOCATION_MZONE
if mon:GetLocation()==LOCATION_MZONE then dest=LOCATION_SZONE end
    local pos=POS_FACEUP
    Duel.MoveToField(mon,tp,tp,dest,pos,true)
local acg=Duel.GetMatchingGroup(c33579957.filter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,e,tp,eg,ep,ev,re,r,rp)
        if acg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(28265983,0)) then
            local tc=acg:Select(tp,1,1,nil):GetFirst()
            local tpe=tc:GetType()
            local te=tc:GetActivateEffect()
            local tg=te:GetTarget()
            local co=te:GetCost()
            local op=te:GetOperation()
            e:SetCategory(te:GetCategory())
            e:SetProperty(te:GetProperty())
            Duel.ClearTargetCard()
            if bit.band(tpe,TYPE_FIELD)~=0 then
                local fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
                if Duel.GetFlagEffect(tp,62765383)>0 then
                    if fc then Duel.Destroy(fc,REASON_RULE) end
                    of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
                    if fc and Duel.Destroy(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
                else
                    Duel.GetFieldCard(tp,LOCATION_SZONE,5)
                    if fc and Duel.SendtoGrave(fc,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
                end
            end
            Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
            Duel.Hint(HINT_CARD,0,tc:GetCode())
            tc:CreateEffectRelation(te)
            if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
                tc:CancelToGrave(false)
            end
            if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
            if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
            Duel.BreakEffect()
            local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
            if g then
                local etc=g:GetFirst()
                while etc do
                    etc:CreateEffectRelation(te)
                    etc=g:GetNext()
                end
            end
            if op then op(te,tp,eg,ep,ev,re,r,rp) end
            tc:ReleaseEffectRelation(te)
            if etc then 
                etc=g:GetFirst()
                while etc do
                    etc:ReleaseEffectRelation(te)
                    etc=g:GetNext()
				end
			end

                end
            end
        end
 end





