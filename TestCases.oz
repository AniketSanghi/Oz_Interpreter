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

%============== Interpret Code ============

% [var ident(x) [var ident(y) [[nop] [bind ident(x) ident(y)] [bind ident(x) literal(1)]]]]

%=======================================================
