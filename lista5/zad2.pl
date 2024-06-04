% Auxiliary predicates
even_number(N) :-
    N mod 2 =:= 0.
odd_number(N) :-
    N mod 2 =:= 1.
%---------------------------------------------------------------------------
% Checking for queens
queens(N, P):-
    length(P, N),
    numlist(1, N, L),
    permutation(L,P),
    good(P).

bad(P) :-
    append(_, [Wi | L1], P),
    append(L2, [Wj | _ ], L1),
    length(L2, K),
    abs(Wi - Wj) =:= K + 1.
    
good(P) :-
    \+ bad(P).
%---------------------------------------------------------------------------        
% Drawing horizontal borders +-----+
draw_dashed(0) :- !.
draw_dashed(Size) :-
    write('+'),
    Size1 is Size - 1,
    draw_lines(Size1),
    nl.

draw_lines(0) :- write('-----+').
draw_lines(N) :-
    write('-----+'),
    N1 is N - 1,
    draw_lines(N1).
%---------------------------------------------------------------------------      
% Drawing fields
% Row number, column number, array of queens, size of array
draw_row(RowNum,_,_,Size):-
    Size =:= RowNum - 1,
    write('|'),
    nl,
    !.
draw_row(RowNum,ColNum,Board,Size):-
    nth1(RowNum,Board,ColNum),
    (   ((even_number(RowNum), even_number(ColNum)) 
    	;
    	(odd_number(RowNum), odd_number(ColNum)) 
        ) -> write('|:###:') ; write('| ### ')
    ),
    RowNum1 is RowNum + 1,
    draw_row(RowNum1,ColNum,Board,Size),
    !.
draw_row(RowNum,ColNum,Board,Size):-
    (   ((even_number(RowNum), even_number(ColNum)) 
    	;
    	(odd_number(RowNum), odd_number(ColNum)) 
        ) -> write('|:::::') ; write('|     ')
    ),
    RowNum1 is RowNum + 1,
    draw_row(RowNum1,ColNum,Board,Size),
    !.
%---------------------------------------------------------------------------        
% Drawing the chessboard
% Array of queens, current column, size of array
draw(_,ColNum,Size):-
    ColNum > Size,
    draw_dashed(Size),
    nl,
    !.
draw(Board,ColNum,Size):-
    draw_dashed(Size),
    Y is Size - ColNum + 1,
    draw_row(1,Y,Board,Size),
    draw_row(1,Y,Board,Size),
    ColNum1 is ColNum +1,
    draw(Board,ColNum1,Size),
    !.  
        
board(X):-
    length(X,L),
    draw(X,1,L).
%---------------------------------------------------------------------------
% Drawing all options    
draw_all_options(X):-
    queens(_,X),
    board(X).
