declare
fun {SetUnion L1 L2} % L1 U L2
   local SetUnionAux in
      fun {SetUnionAux L1 L2}  
         case L1
         of nil then L2
         [] X|Y then
            if {List.member X L2} then {SetUnionAux Y L2}
            else {SetUnionAux Y X|L2}
            end
         end
      end
      {SetUnionAux {SetUnionAux L1 L2} nil}
   end
end

declare
fun {SetDiff L1 L2} % L1\L2
   case L2
   of nil then L1
   [] X|Y then {SetDiff Y {List.subtract L1 X}}
   end
end

declare
fun {GetFreeVars S}
   case S
   of [nop] then nil  
   [] (S1|S2) then {SetUnion {GetFreeVars (S1)} {GetFreeVars S2}}
   [] [var ident(X) S] then {SetDiff {GetFreeVars S} [ident(X)]}
   [] [bind ident(X) ident(Y)] then (ident(X) | ident(Y) | nil)
   [] [bind ident(X) V] then {SetUnion [ident(X)] {GetFreeVars V}}
   [] [match ident(X) Pat S1 S2] then {SetDiff {SetUnion {SetUnion [ident(X)] {GetFreeVars S1}} {GetFreeVars S2}} {GetFreeVars Pat}}
   [] [procedure ArgList S] then  {SetDiff {GetFreeVars S} ArgList}
   [] [record L Pairs] then {SetUnion {Map Pairs fun {$ X} X.2.1 end} nil}
   else nil
   end
end
