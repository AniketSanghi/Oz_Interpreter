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
% Helpers used for Procedure Application
%=================

declare
fun {GetVar V}
   case V 
   of ident(X) then X
   else nil
   end
end

declare
fun {Get Env X}
   case Env
   of nil then nil
   [] H|T then 
      if H.1==X then H.2.1
      else {Get T X} end
   end
end

declare
fun {GenEnv X Y Env}
    case X#Y
    of nil#nil then nil
    [] (H1|T1)#(H2|T2) then [H1 {Get Env H2}]|{GenEnv T1 T2 Env}
    else raise Error end
    end
end
