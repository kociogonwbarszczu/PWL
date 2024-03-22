middle(L, X) :-
    length(L, Length),
    Length > 0,
    Length mod 2 =:= 1,
    Middle is Length // 2,
    nth0(Middle, L, X).