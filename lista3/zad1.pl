sum([], 0).
sum([Head|Tail], Sum) :-
    sum(Tail, TailSum),
    Sum is Head + TailSum.

average(List, Average) :-
    sum(List, Sum),
    length(List, Length),
    Length > 0,
    Average is Sum / Length.

square(Average, Value, Square) :-
    Square is (Value - Average)*(Value - Average).

listSquares([], _, []).
listSquares([Head|Tail], Average, [ResultHead|ResultTail]) :-
    square(Average, Head, ResultHead),
    listSquares(Tail, Average, ResultTail).

variance(List, Var) :-
    average(List, Average),
    listSquares(List, Average, NewList),
    average(NewList, Var).