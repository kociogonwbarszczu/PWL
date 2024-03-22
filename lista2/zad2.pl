once(X, L) :-
    select(X, L, L1),
    \+ member(X, L1).

twice(X,L) :- 
    append(B1,[X|A1],L),        % divides list L on 2 parts: B1 - before first occurrence of X and A1 after first occurrence of X
    \+ member(X,B1),            % chceck if there is no occurrence of X in B1
    append(B2,[X|A2],A1),       % divides list A1 (so after first occurrence of X) on 2 parts: B2 - before second occurrence of X and A2 after second occurrence of X
    \+ member(X,B2),            % chceck if there is no occurrence of X in B2
    \+ member(X,A2).            % chceck if there is no occurrence of X in A2