on_left(X,Y,[X,Y|_]).
on_left(X,Y,[_|Z]):-
    on_left(X,Y,Z).

next_to(X,Y,Houses):-
    on_left(X,Y,Houses).
next_to(X,Y,Houses):-
    on_left(Y,X,Houses).

fish(Who):-
    Houses = [[1,_,norwegian,_,_,_],[2,_,_,_,_,_],[3,_,_,_,milk,_],[4,_,_,_,_,_],[5,_,_,_,_,_]],
    member([_,red,englishman,_,_,_],Houses),
    on_left([_,green,_,_,_,_],[_,white,_,_,_,_],Houses),
    member([_,_,danish,_,tea,_],Houses),
    next_to([_,_,_,_,_,light_cigarettes],[_,_,_,cats,_,_],Houses),
    member([_,yellow,_,_,_,cigar],Houses),
    member([_,_,german,_,_,pipe],Houses),
    next_to([_,_,_,_,_,light_cigarettes],[_,_,_,_,water,_],Houses),
    member([_,_,_,birds,_,cigarettes_without_filter],Houses),
    member([_,_,swede,dogs,_,_],Houses),
    next_to([_,_,norwegian,_,_,_],[_,blue,_,_,_,_],Houses),
    next_to([_,_,_,horses,_,_],[_,yellow,_,_,_,_],Houses),
    member([_,_,_,_,beer,mentol_cigarettes],Houses),
    member([_,green,_,_,coffee,_],Houses),
    member([_,_,Who,fish,_,_],Houses).


% fish(Who).