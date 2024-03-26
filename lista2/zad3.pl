arc(a, b).
arc(b, a).
arc(b, c).
arc(c, d).

reachable(X, X).
reachable(X, Y) :- reachable(X, Y, [X]).

reachable(X, Y, Visited) :-
    arc(X, Z),
    \+ member(Z, Visited),
    (
        Y=Z
        ;
        reachable(Z, Y, [Z | Visited])
    ).