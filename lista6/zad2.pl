:- consult(zad1), consult(interpreter).

execute(FileName) :-
    open(FileName, read, X),
    scanner(X, Y),
    close(X),
    phrase(program(Z), Y),
    interpreter(Z).
