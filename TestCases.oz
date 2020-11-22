\insert 'SingleAssignmentStore.oz'

%============== Testcase 1(Positive) ==============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}

%==================================================


%============== Testcase 2(Positive) ==============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {RetrieveFromSAS 1}}

%==================================================


%============== Testcase 3(Positive) ==============

% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {Browse {AddKeyToSAS}}
% {BindRefToKeyInSAS 0 1}
% {BindRefToKeyInSAS 4 0}
% {BindRefToKeyInSAS 2 3}
% {Browse {RetrieveFromSAS 4}}
% {Browse {RetrieveFromSAS 3}}

%==================================================


%============== Testcase 4(Positive) ==============

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
% {Browse {RetrieveFromSAS 0}}
% {Browse {RetrieveFromSAS 2}}

%==================================================


%============== Testcase 5(Negative) ==============

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

%==================================================

%============== Testcase Environment ==============

% {Browse {Adjunction env(m:x n:y o:z) env(n:d)}}
% {Browse {Restriction env(x:a y:b z:c m:p) [m x]}}

%==================================================
