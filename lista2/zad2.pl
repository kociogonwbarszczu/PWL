once(X, L) :-
    select(X, L, L1),
    \+ member(X, L1).

twice(X,L) :- 
    append(B1,[X|A1],L),
    \+ member(X,B1),
    append(B2,[X|A2],A1),
    \+ member(X,B2),
    \+ member(X,A2).