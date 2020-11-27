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
   AddStatement
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
      else
         case STop.2.2
         of nil then {Interpret (STop.1#Env) | (STop.2.1#Env) | Stack}
         else {Interpret (STop.1#Env) | (STop.2#Env) | Stack}
         end
      end
   end
end


declare OzCode SemanticStack

OzCode = [var ident(x) [var ident(y) [[nop] [bind ident(x) ident(y)] [bind ident(x) literal(1)]]]]

SemanticStack = [OzCode#env()]
{Interpret SemanticStack}