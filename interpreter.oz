\insert 'Helper.oz'

%==================
% Interpret the Oz Language
%=================
declare Interpret ApplyProc

proc {ApplyProc STop Env Stack}
   local F in
   F = {RetrieveFromSAS Env.{GetVar STop.2.1}}
   case F 
   of (procedure | ArgList | S)#Closure then
         if {Length ArgList} \= {Length STop.2.2} then raise Error end
         else
            local NewEnv in
               NewEnv = {Adjoin {Adjoin {GenEnv F.1.2.1 STop.2 Env} Closure} [STop.1 {Get Env STop.1}]}
               {Interpret (S#NewEnv)|Stack}
            end
         end
   else raise Error end
   end
   end
end


proc {Interpret SemanticStack}
   AddStatement ValueInSAS NewEnv
in
   {PrintState SemanticStack}

   case SemanticStack
   of nil then {Browse '---Interpretation Completed!---'}
   [] (STop#Env)|Stack then
      case STop.1
      of nil then skip
      [] nop then
         {Interpret Stack}
      [] var then
         AddStatement = {CreateVariable STop.2.1 STop.2.2.1 Env}
         {Interpret AddStatement|Stack}
      [] bind then
         {BindVariable STop.2.1 STop.2.2.1 Env}
         {Interpret Stack}
      [] apply then
         {ApplyProc STop Env Stack}
      [] match then
         ValueInSAS = {RetrieveFromSAS Env.(STop.2.1.1)}
         case ValueInSAS
         of equivalence(_) then {Delay 1000000} %todo: find a better way to suspend 
         [] record | L1 | Pairs1 | nil then
            case STop.2.2.1
            of record | L2 | Pairs2 | nil then
               if {RecordsCompatible L1 L2 Pairs1 Pairs2 Env NewEnv} then
                  {Interpret ((STop.2.2.2.1)#NewEnv) | Stack}
               else {Interpret ({List.last STop}#Env) | Stack}
               end
            else raise 'Pattern Matching should be with a record' end
            end
         else {Interpret ({List.last STop}#Env) | Stack}
         end
      else
         case STop.2.2
         of nil then {Interpret (STop.1#Env) | (STop.2.1#Env) | Stack}
         else {Interpret (STop.1#Env) | (STop.2#Env) | Stack}
         end
      end
   end
end


declare OzCode SemanticStack

OzCode = [var ident(x) 
            [var ident(y) 
               [var ident(p) 
                  [var ident(q) 
                     [[nop] 
                      [bind ident(p) literal(1)]
                      [bind ident(q) literal(2)]
                      [bind ident(x) [record literal(a) 
                                       [[literal(b) ident(p)] 
                                        [literal(c) ident(q)]]]]
                      [match ident(x) [record literal(a) 
                                       [[literal(c) ident(a)] 
                                        [literal(b) ident(a)]]] 
                                       [bind ident(p) ident(y)]
                                       [bind ident(y) ident(q)]]]]]]]
SemanticStack = [OzCode#env()]
{Interpret SemanticStack}

