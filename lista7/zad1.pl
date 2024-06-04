merge(IN1, IN2, OUT) :-
    freeze(IN1, freeze(IN2, 
        (IN1 = [H1 | T1] -> 
            (IN2 = [H2 | T2] -> 
                (H1 < H2 ->
                    OUT = [H1 | T], merge(T1, IN2, T)
                    ; OUT = [H2 | T], merge(IN1, T2, T))
                ; OUT = IN1)
            ; OUT = IN2))).
