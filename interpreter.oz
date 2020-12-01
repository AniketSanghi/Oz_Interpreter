\insert 'Helper.oz'


declare Interpret ApplyProc
%==================
% ApplyProc implements the apply procedure semantics
% for the interpeter
%=================
proc {ApplyProc STop Env Stack}
   local F OzVar in
   OzVar = (STop.2.1).1
   F = {RetrieveFromSAS Env.OzVar}
   case F 
   of (procedure | ArgList | S)#Closure then
         if {Length ArgList} \= {Length STop.2.2} then raise Error end
         else
            local NewEnv in
               NewEnv = {Adjoin {GenEnv ArgList STop.2.2 Env} Closure}
               {Interpret (S.1#NewEnv)| Stack}
            end
         end
   else {Delay 1000000} %todo: find a better way to suspend
   end
   end
end

%==================
% Interpret the Oz Language
%=================
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
      [] apply  then
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


declare InterpretCode
proc {InterpretCode Code}
   SemStack = [Code#env()]
in
   {Interpret SemStack}
end

% {InterpretCode [var ident(record)
%                   [var ident(h)
%                      [var ident(t)
%                         [var ident(x)
%                            [var ident(y)
%                               [[bind ident(record) [record literal(label) 
%                                                       [[literal(feature1) ident(t)] [literal(feature2) ident(h)]]]]
%                                [bind ident(h) literal(1)]
%                                [bind ident(y) literal(2)]
%                                [bind ident(t) literal(3)]
%                                [match ident(record) [record literal(label)
%                                     [[literal(feature1) ident(h)] [literal(feature2) ident(t)]]]
%                                     [bind ident(x) ident(h)]
%                                     [bind ident(x) ident(t)]]]]]]]]}
