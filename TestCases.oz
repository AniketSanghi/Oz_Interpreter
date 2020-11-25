\insert 'Unify.oz'
\insert 'Environment.oz'

%============== Testcase 1(Positive): SAS ==============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {PrintSAS}

%=======================================================


%============== Testcase 2(Positive): SAS ==============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {BindValueToKeyInSAS 0 literal(a)}
% {BindValueToKeyInSAS 1 literal(a)}
% {PrintSAS}

%=======================================================


%============== Testcase 3(Positive): SAS ==============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {BindRefToKeyInSAS 0 1}
% {BindRefToKeyInSAS 4 0}
% {BindRefToKeyInSAS 2 3}
% {PrintSAS}

%=======================================================


%============== Testcase 4(Positive): SAS ==============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {BindRefToKeyInSAS 0 1}
% {BindRefToKeyInSAS 4 0}
% {BindRefToKeyInSAS 2 3}
% {BindValueToKeyInSAS 4 literal(a)}
% {BindValueToKeyInSAS 3 literal(b)}
% {PrintSAS}

%=======================================================


%============== Testcase 5(Negative): SAS ==============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {BindRefToKeyInSAS 0 1}
% {BindRefToKeyInSAS 4 0}
% {BindRefToKeyInSAS 2 3}
% {BindValueToKeyInSAS 4 literal(a)}
% {BindValueToKeyInSAS 3 literal(b)}
% {BindRefToKeyInSAS 2 1}

%=======================================================


%============== Testcase 6: Environment ================

% {Browse {Adjunction env(m:x n:y o:z) env(n:d)}}
% {Browse {Restriction env(x:a y:b z:c m:p) [m x]}}

%=======================================================


%============== Testcase 7(Positive): Unify ============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Unify ident(x) ident(y) env(x:0 y:1 z:2 p:3 q:4)}
% {Unify literal(4) ident(x) env(x:0 y:1 z:2 p:3 q:4)}
% {Unify ident(z) literal(5) env(x:0 y:1 z:2 p:3 q:4)}
% {Unify ident(z) ident(p) env(x:0 y:1 z:2 p:3 q:4)}
% {Unify ident(z) ident(q) env(x:0 y:1 z:2 p:3 q:4)}
% {PrintSAS}

%=======================================================


%============== Testcase 8(Positive): Unify ============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Unify ident(z) literal(10) env(x:0 y:1 z:2)}
% {Unify [record literal(a) [[literal(b) ident(x)] [literal(c) ident(y)]]] [record literal(a) [[literal(b) ident(z)] [literal(c) ident(x)]]] env(x:0 y:1 z:2)}
% {PrintSAS}

%=======================================================

%=======================================================


%============== Testcase 9(Positive): Closure(Free Variables) ============

%{Browse {GetFreeVars [nop]}}
%{Browse {GetFreeVars [[nop] [nop]]}}   
%{Browse {GetFreeVars [[var ident(b) [[bind ident(b) ident(a)]]] [nop]]}} 
%{Browse {GetFreeVars [var ident(x) [[bind ident(x) ident(y)] [nop]]]}}
%{Browse {GetFreeVars [bind ident(z) literal(4)]}}
%{Browse {GetFreeVars [var ident(x) [[bind ident(x) [procedure [ident(y) ident(x)] [nop]]]]]}}
%{Browse {GetFreeVars  [var ident(foo)
%  [var ident(result)
%   [
%    [bind ident(foo) [record literal(bar)  [[literal(baz) literal(42)]     [literal(quux) literal(314)]] ] ]
%    [match ident(foo) [record literal(bar) [[literal(baz) ident(fortytwo)] [literal(quux) ident(pitimes100)]] ] [bind ident(result) ident(fortytwo)] [bind ident(result) literal(314)] ]
%    [bind ident(result) literal(42)]
%    [nop]
%   ]
%  ]
% ]}}

%=======================================================


%============== Interpret Code ============

% [var ident(x) [var ident(y) [[nop] [bind ident(x) ident(y)] [bind ident(x) literal(1)]]]]

%=======================================================
