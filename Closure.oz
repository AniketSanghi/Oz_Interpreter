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
   [] X|Y then {SetDiff {List.subtract L1 X} Y}
   end
end

declare
fun {GetFreeVars S}
   case S
   of [nop] then nil
   [] [var ident(X) S] then {SetDiff {GetFreeVars S} (ident(X)| nil)}
   [] [bind ident(X) ident(Y)] then (ident(X) | ident(Y) | nil)
   [] [bind ident(X) V] then {SetUnion [ident(X)] {GetFreeVars V}}
   [] [match ident(X) Pat S1 S2] then {SetUnion {SetUnion [ident(X)] {GetFreeVars S2}} {SetDiff {GetFreeVars S1} {GetFreeVars Pat}}}
   [] [procedure ArgList S] then  {SetDiff {GetFreeVars S} ArgList}
   [] [record Lit Pairs] then {SetUnion {Map Pairs fun {$ L} L.2.1 end} nil}
   [] S1|S2 then {SetUnion {GetFreeVars S1} {GetFreeVars S2}}
   else nil
   end
end