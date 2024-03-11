prime(LO, HI, N) :-
    between(LO, HI, N),
    N > 1,
    \+ composite(N).

composite(N) :-
    between(2, N, X),
    X > 1,
    X * X =< N,
    N mod X =:= 0.