\insert 'Environment.oz'
\insert 'Unify.oz'

declare
proc {Print Semantic_Stack}
   {Browse '-----Semantic Stack-----'}
   {Browse Semantic_Stack}
end

declare
fun {HandleVariableDeclaration Statement Env}
   X X_Val InnerStatement NewEnv
in
   ident(X) = Statement.2.1
   X_Val = {AddKeyToSAS}
   InnerStatement = Statement.2.2.1
   NewEnv = {Adjunction Env env(X:X_Val)}

   (InnerStatement#NewEnv)
end

declare
proc {Interpret SemanticStack}
   NewStatement
in
   {Print SemanticStack}
   {PrintSAS}
   case SemanticStack
   of nil then skip
   [] (S#Env)|SStack then
      case S.1
      of nil then skip
      [] nop then
	      {Interpret SStack}
      [] var then
   	    NewStatement = {HandleVariableDeclaration S Env}
   	    {Interpret NewStatement|SStack}
      else
	      if S.2.2 == nil then
	         {Interpret (S.1#Env) | (S.2.1#Env) | SStack}
	      else
	         {Interpret (S.1#Env) | (S.2#Env) | SStack}
	      end
      end
   end
end


declare OzCode SemanticStack

OzCode = [[nop] [var ident(x) [[nop] [nop]]] [nop]]

SemanticStack = [OzCode#env()]
{Interpret SemanticStack}