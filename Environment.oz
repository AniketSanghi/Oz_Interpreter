%==================
% Take Adjunction of Env with a new binding
% Keep both Env and Binding as records with label "env"
%=================
declare
fun {Adjunction Env Binding}
   {Adjoin Env Binding}
end

%==================
% Take Adjunction of Env with a list of features
%=================
declare
fun {Restriction Env Features}
   case Features
   of nil then env()
   [] ident(H)|T then {Adjoin env(H: Env.H) {Restriction Env T}}
   end
end