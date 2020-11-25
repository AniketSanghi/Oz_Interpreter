\insert 'Helper.oz'

%==================
% Interpret the Oz Language
%=================
declare
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