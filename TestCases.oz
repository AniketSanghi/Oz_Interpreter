\insert 'interpreter.oz'

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

% OzCode = [var ident(x) [var ident(y) [[nop] [bind ident(x) ident(y)] [bind ident(x) literal(1)]]]]
% OzCode = [var ident(x) 
%             [var ident(y) 
%                [var ident(p) 
%                   [var ident(q) 
%                      [[nop] 
%                       [bind ident(x) [record literal(a) 
%                                        [[literal(b) ident(p)] 
%                                         [literal(c) ident(q)]]]]
%                       [bind ident(y) [record literal(a) 
%                                        [[literal(b) ident(q)] 
%                                         [literal(c) ident(p)]]]]
%                       [bind ident(x) ident(y)]]]]]]
% OzCode = [var ident(x) 
%             [var ident(y) 
%                [var ident(p) 
%                   [var ident(q) 
%                      [[nop] 
%                       [bind ident(p) literal(1)]
%                       [bind ident(q) literal(2)]
%                       [bind ident(x) [record literal(a) 
%                                        [[literal(b) ident(p)] 
%                                         [literal(c) ident(q)]]]]
%                       [match ident(x) [record literal(a) 
%                                        [[literal(c) ident(a)] 
%                                         [literal(b) ident(b)]]] 
%                                        [bind ident(b) ident(y)]
%                                        [bind ident(y) ident(a)]]]]]]]
% OzCode = [var ident(x) 
%             [var ident(y) 
%                [var ident(p) 
%                   [var ident(q) 
%                      [[nop] 
%                       [bind ident(p) literal(1)]
%                       [bind ident(q) literal(2)]
%                       [bind ident(x) [record literal(a) 
%                                        [[literal(b) ident(p)] 
%                                         [literal(c) ident(q)]]]]
%                       [match ident(x) [record literal(a) 
%                                        [[literal(c) ident(a)] 
%                                         [literal(b) ident(a)]]] 
%                                        [bind ident(p) ident(y)]
%                                        [bind ident(y) ident(q)]]]]]]]

%OzCode = [var ident(x) [
%                       [var ident(y) [
%                                      [bind ident(y) literal(10)]
%                                      [bind ident(x) [procedure [ident(x1)] [
%                                                                         [var ident(y) [bind ident(x1) ident(y)]]
%                                                                         [bind ident(x1) ident(y)]
%                                                                        ]
%                                                     ]]
%                                     ]]
%                       [var ident(z) [apply ident(x) ident(z)]]
%                      ]]

% {InterpretCode [var ident(x) 
%                            [[bind ident(x) literal(1)]
%                            [var ident(x)
%                               [[bind ident(x) literal(2)]
%                                [nop]]]
%                            [nop]]]}

% {InterpretCode [var ident(copy)
%                   [var ident(a)
%                      [var ident(b)
%                         [[bind ident(copy) [procedure [ident(x) ident(y)] [bind ident(x) ident(y)]]]
%                          [bind ident(b) literal(1)]
%                          [apply ident(copy) ident(b) ident(a)]
%                          [nop]]]]]}

% {InterpretCode [var ident(x)
%                   [var ident(foo)
%                      [[var ident(x)
%                         [[bind ident(foo) [procedure [ident(y)] [bind ident(x) ident(y)]]]
%                          [bind ident(x) literal(2)]]]
%                      [apply ident(foo) ident(x)]]]]}

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

%=======================================================
