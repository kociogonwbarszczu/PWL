:- consult(zad1_prev).

% Define a program as a sequence of instructions followed by a separator ';'
program([H|R]) -->
    instruction(H),
    [sep(;)],
    !,
    program(R).

% An empty program
program([]) -->
    [].

% Define different types of instructions
instruction(assign(X, Y)) -->
    [id(X)],
    [sep(:=)],
    expression(Y).

instruction(read(X)) -->
    [key(read)],
    [id(X)].

instruction(write(Y)) -->
    [key(write)],
    expression(Y).

instruction(if(X, Y)) -->
    [key(if)],
    condition(X),
    [key(then)],
    program(Y),
    [key(fi)].

instruction(if(X, Y, Z)) -->
    [key(if)],
    condition(X),
    [key(then)],
    program(Y),
    [key(else)],
    program(Z),
    [key(fi)].

instruction(while(X, Y)) -->
    [key(while)],
    condition(X),
    [key(do)],
    program(Y),
    [key(od)].

% Define expressions with operators
expression(X + Y) -->
    term(X),
    [sep(+)],
    expression(Y).

expression(X - Y) -->
    term(X),
    [sep(-)],
    expression(Y).

expression(X) -->
    term(X).

% Define terms with operators
term(X * Y) -->
    factor(X),
    [sep(*)],
    term(Y).

term(X / Y) -->
    factor(X),
    [sep(/)],
    term(Y).

term(X mod Y) -->
    factor(X),
    [key(mod)],
    term(Y).

term(X) -->
    factor(X).

% Define factors
factor(id(X)) -->
    [id(X)].

factor(int(X)) -->
    [int(X)].

factor((X)) -->
    [sep('(')],
    expression(X),
    [sep(')')].

% Define conditions with logical operators
condition((X ; Y)) -->
    conjunction(X),
    [key(or)],
    condition(Y).

condition(X) -->
    conjunction(X).

% Define conjunctions with logical operators
conjunction((X , Y)) -->
    simple(X),
    [key(and)],
    conjunction(Y).

conjunction(X) -->
    simple(X).

% Define simple conditions with comparison operators
simple(X =:= Y) -->
    expression(X),
    [sep(=)],
    expression(Y).

simple(X =\= Y) -->
    expression(X),
    [sep(/=)],
    expression(Y).

simple(X < Y) -->
    expression(X),
    [sep(<)],
    expression(Y).

simple(X > Y) -->
    expression(X),
    [sep(>)],
    expression(Y).

simple(X >= Y) -->
    expression(X),
    [sep(>=)],
    expression(Y).

simple(X =< Y) -->
    expression(X),
    [sep(=<)],
    expression(Y).

simple((X)) -->
    [sep('(')],
    condition(X),
    [sep(')')].
