consult(zad1).

split(IN, OUT1, OUT2) :-
    freeze(IN, 
        (IN = [H | T] ->
            (OUT1 = [H | T1], split(T, OUT2, T1))
            ;(OUT1 = [], OUT2 = []))).


merge_sort(IN, OUT) :-
   freeze(IN,
      (IN = [H | T] ->
         (freeze(T,
            (T = [] ->
                OUT = [H];
                split(IN, O1, O2),
                merge_sort(O1, OUT1),
                merge_sort(O2, OUT2),
                merge(OUT1, OUT2, OUT)
             )
          ))
          ; OUT = []
      )
   ), !.
