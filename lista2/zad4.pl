checkIndexes(Value, List) :-
    nth0(Index1, List, Value),
    nth0(Index2, List, Value),
    Index1 < Index2,
    (Index2 - Index1) mod 2 =:= 1,
    MinIndex is Value - 1,
    MaxIndex is 2 * MinIndex,
    between(MinIndex, MaxIndex, Index1).

check(1, List) :-
    checkIndexes(1, List).
check(N, List) :-
    NewN is N - 1,
    checkIndexes(N, List),
    check(NewN, List).

list(N, List) :-
    Len is N * 2,
    length(List, Len),    
    check(N, List).