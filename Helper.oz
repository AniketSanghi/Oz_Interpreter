\insert 'Environment.oz'
\insert 'Unify.oz'
\insert 'Closure.oz'

%==================
% Print Current State of Semantic Stack and SAS
%=================
declare
proc {PrintState Stack}
   PrintStackElem
in
   proc {PrintStackElem Stack}
      case Stack
      of nil then skip
      [] H|T then
	     {Browse H}
	     {PrintStackElem T}
      end
   end
   
   {Browse '-----Semantic Stack-----'}
   
   case Stack
   of nil then {Browse 'EMPTY'}
   else {PrintStackElem Stack}
   end
   
   {PrintSAS}
end

%==================
% Process "local X in <s>" Statement
%=================
declare
fun {CreateVariable ident(VarX) InnerBlock Environment}
   ValX = {AddKeyToSAS}
   UpdatedEnv = {Adjunction Environment env(VarX:ValX)}
in
   (InnerBlock#UpdatedEnv)
end

%==================
% Bind Variable to Variable/Literal
%=================
declare
proc {BindVariable VarX VarY Environment}
   case VarY
   of [procedure ArgList S] then {Unify VarX (VarY#{Restriction Environment {GetFreeVars VarY}}) Environment}
   else {Unify VarX VarY Environment}
   end
end

%==================
% Check if records are compatible for pattern matching
% and return new environment on a successful match
%=================
declare
fun {RecordsCompatible L1 L2 Pairs1 Pairs2 Env NewEnv}
   Canon1 = {Canonize Pairs1}
   Canon2 = {Canonize Pairs2}
   AuxEnv
   CheckUnificationError
in
   if {And (L1 == L2) ({Map Canon1 fun {$ X} X.1 end} == {Map Canon2 fun {$ X} X.1 end})} then

      fun {CheckUnificationError Canon1 Canon2 AuxEnv}
         TempEnv
         OzVar
         SASVar
      in
         case Canon1#Canon2
         of nil#nil then
            AuxEnv = env()
            true
         [] (H1|T1)#(H2|T2) then
            OzVar = H2.2.1.1
            SASVar = H1.2.1
            if {CheckUnificationError T1 T2 TempEnv} then
               if {HasFeature TempEnv OzVar} then
                  if {EqualRecursive {RetrieveFromSAS TempEnv.OzVar} {RetrieveFromSAS SASVar} nil} then
                     AuxEnv = TempEnv
                     true
                  else false
                  end   
               else
                  AuxEnv = {Adjoin TempEnv env(OzVar : SASVar)}
                  true
               end
            else false
            end
         end
      end

      if {CheckUnificationError Canon1 Canon2 AuxEnv} then
         NewEnv = {Adjunction Env AuxEnv}
         true
      else false
      end
   else false      
   end
end
