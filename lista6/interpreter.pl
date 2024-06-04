% substitute(+Old, +ID, +Value, -New)
substitute([], ID, N, [ID = N]).
substitute([ID=_ | AS], ID, N, [ID=N | AS]) :-
    !.
substitute([ID1=W1 | AS1], ID, N, [ID1=W1 | AS2]) :-
    substitute(AS1, ID, N, AS2).

% fetch(+Associations, +ID, -Value)
fetch([ID=N | _], ID, N) :-
    !.
fetch([_ | AS], ID, N) :-
    fetch(AS, ID, N).

% value(+Expression, +Associations, -Value)
value(int(N), _, N).
value(id(ID), AS, N) :-
    fetch(AS, ID, N).
value(W1 + W2, AS, N) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N is N1 + N2.
value(W1 - W2, AS, N) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N is N1 - N2.
value(W1 * W2, AS, N) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N is N1 * N2.
value(W1 / W2, AS, N) :-
    value(W1, AS, N1),
    value(W2, AS, N2), N2 =\= 0,
    N is N1 div N2.
value(W1 mod W2, AS, N) :-
    value(W1, AS, N1),
    value(W2, AS, N2), N2 =\= 0,
    N is N1 mod N2.

% truth(+Condition, +Associations)
truth(W1 =:= W2, AS) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N1 =:= N2.
truth(W1 =\= W2, AS) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N1 =\= N2.
truth(W1 < W2, AS) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N1 < N2.
truth(W1 > W2, AS) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N1 > N2.
truth(W1 >= W2, AS) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N1 >= N2.
truth(W1 =< W2, AS) :-
    value(W1, AS, N1),
    value(W2, AS, N2),
    N1 =< N2.
truth((W1, W2), AS) :-
    truth(W1, AS),
    truth(W2, AS).
truth((W1; W2), AS) :-
    (   truth(W1, AS),
    !
    ;   truth(W2, AS)).

% interpreter(+Program, +Associations)
interpreter([], _).
interpreter([read(ID) | PGM], ASSOC) :-
    !,
    read(N),
    integer(N),
    substitute(ASSOC, ID, N, ASSOC1),
    interpreter(PGM, ASSOC1).
interpreter([write(W) | PGM], ASSOC) :-
    !,
    value(W, ASSOC, VAL),
    write(VAL),
    nl,
    interpreter(PGM, ASSOC).
interpreter([assign(ID, W) | PGM], ASSOC) :-
    !,
    value(W, ASSOC, VAL),
    substitute(ASSOC, ID, VAL, ASSOC1),
    interpreter(PGM, ASSOC1).
interpreter([if(C, P) | PGM], ASSOC) :- !,
    interpreter([if(C, P, []) | PGM], ASSOC).
interpreter([if(C, P1, P2) | PGM], ASSOC) :-
    !,
    (   truth(C, ASSOC) -> append(P1, PGM, NEXT)
    ;   append(P2, PGM, NEXT)
    ),
    interpreter(NEXT, ASSOC).
interpreter([while(C, P) | PGM], ASSOC) :-
    !,
    append(P, [while(C, P)], NEXT),
    interpreter([if(C, NEXT) | PGM], ASSOC).

% interpreter(+Program)
interpreter(PROGRAM) :-
    interpreter(PROGRAM, []).
