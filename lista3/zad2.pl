max_sum(Lista, MaxSum) :-
    max_sum(Lista, 0, 0, MaxSum).

max_sum([], _, TempMaxSum, TempMaxSum).
max_sum([Head|Tail], TempSum, TempMaxSum, MaxSum) :-
    NewTempSum is max(Head, TempSum + Head),
    NewTempMaxSum is max(NewTempSum, TempMaxSum),
    max_sum(Tail, NewTempSum, NewTempMaxSum, MaxSum).