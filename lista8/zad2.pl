:- use_module(library(clpfd)).


backpack(Value, Weight, Capacity, Choosen, Possible_value):-
    length(Value, L),
    length(Choosen, L),
    Choosen ins 0..1,
    scalar_product(Value, Choosen, #= ,Possible_value),
    scalar_product(Weight, Choosen, #=<, Capacity),
    once(labeling([max(Possible_value)], Choosen)).