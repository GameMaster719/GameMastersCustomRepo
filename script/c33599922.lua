--Wide Spread ruin (DOR)
--scripted by GameMaster(GM)
function c33599922.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c33599922.condition)
	e1:SetOperation(c33599922.op)
	c:RegisterEffect(e1)
end

function c33599922.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end

 

   
function c33599922.op(e,tp,eg,ep,ev,re,r,rp)
   local seq=e:GetHandler():GetSequence()
    local g=Group.CreateGroup()
	--3x3 area
	--3area spells/traps mine
	 local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,seq)
        if tc  then g:AddCard(tc) end
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,seq+1)
  if tc then g:AddCard(tc) end
  local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,seq-1)
       if tc then g:AddCard(tc) end
	   	  --3area monsters mine 
	 local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
        if tc  then g:AddCard(tc) end	  
	local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq+1)
  if tc then g:AddCard(tc) end
   	 local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq-1)
       if tc then g:AddCard(tc) end	  
	 	 --3area monsters opponents 
 local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,seq)
       if tc  then g:AddCard(tc) end 
	local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,seq+1)
  if tc then g:AddCard(tc) end
      local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,seq-1)
       if tc then g:AddCard(tc) end	  
	 if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT) end
  end
  
  --mirroring!
function desop2(e,tp,eg,ep,ev,re,r,rp)
    local seq=e:GetLabel()
    local g=Group.CreateGroup()
    if seq>0 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,5-seq)
       if tc  then g:AddCard(tc) end
    end
    if seq<4 then
        local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,3-seq)
        if tc then g:AddCard(tc) end
  local tc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,seq)
  if tc then g:AddCard(tc) end
    end
    local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
   if tc  then g:AddCard(tc) end
    if g:GetCount()>0 then Duel.Destroy(g,REASON_EFFECT)
end
end
  