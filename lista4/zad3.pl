square(_, 0, []).

% 1 Large square
square(large, 1, [1, 2, 3, 4, 7, 11, 14, 18, 21, 22, 23, 24]).

% 4 medium squares
square(medium, 1, [1, 2, 4, 6, 11, 13, 15, 16]).
square(medium, 1, [2,  3, 5,  7, 12, 14, 16, 17]). 
square(medium, 1, [8,  9, 11, 13, 18, 20, 22, 23]).
square(medium, 1, [9, 10, 12, 14, 19, 21, 23, 24]).

% 9 small squares
square(small, 1, [1, 4, 5, 8]).
square(small, 1, [2, 5, 6, 9]).
square(small, 1, [3, 6, 7, 10]).
square(small, 1, [8, 11, 12, 15]).
square(small, 1, [9, 12, 13, 16]).
square(small, 1, [10, 13, 14, 17]).
square(small, 1, [15, 18, 19, 22]).
square(small, 1, [16, 19, 20, 23]).
square(small, 1, [17, 20, 21, 24]).

square(S, N, R) :-
    N > 1,
    square(S, 1, X),
    N1 is N - 1,
    square(S, N1, Y),
    min_list(X, SX),
    min_list(Y, SY),
    SX < SY,
    union(X, Y, R),
    R \= Y.
    
generate_chars(W, L, X) :-
    member(X, L) ->
    write(W), !;
    atom_length(W, N), tab(N).

horizontal(L, N1, N2, N3) :-
    write(+), generate_chars(---, L, N1),
    write(+), generate_chars(---, L, N2),
    write(+), generate_chars(---, L, N3),
    write(+), nl.

vertical(L, N1, N2, N3, N4) :-
    generate_chars("|", L, N1), tab(3),
    generate_chars("|", L, N2), tab(3),
    generate_chars("|", L, N3), tab(3),
    generate_chars("|", L, N4), nl.

draw(X):-
    horizontal(X, 1, 2, 3),
    vertical(X, 4, 5, 6, 7),
    horizontal(X, 8, 9, 10),
    vertical(X, 11, 12, 13, 14),
    horizontal(X, 15, 16, 17),
    vertical(X, 18, 19, 20, 21),
    horizontal(X, 22, 23, 24).

matches(C, L, M, S) :-
    square(large, L, S3),
    square(medium, M, S2),
    square(small, S, S1),
    union(S1, S2, U),
    union(U, S3, R),
    length(R, N),
    C is 24 - N,
    draw(R).


% matches(number of matches to remove, number of big squares, number of medium squares, number of small squares)

% for example: matches(4, 1, 2, 3)