% Main scanner function that reads input and converts it to tokens
scanner(X, Y) :-
    read_input(X, R),
    to_tokens(R, Y).

% Converts a list of strings into a list of tokens
to_tokens([], []).
to_tokens([H | R], W) :-
    to_tokens(R, W1),
    splitter(H, W2),
    append(W2, W1, W).

% Determines the type of token and converts it accordingly
token_type(X, [key(X)]) :-
    key(X),
    !.
token_type(X, [sep(X)]) :-
    sep(X),
    !.
token_type(X, [int(R)]) :-
    atom_number(X, R),
    !.
token_type(X, [Z]) :-
    \+ (sub_atom(X, _, 1, _, C),
        \+ char_type(C, upper)),
    Z =.. [id, X],
    !.

% Splits a string into tokens
splitter(S, R) :-
    atom_chars(S, Sl),
    split_chars(Sl, '', 0, [], R).

% Determines the category type of a character
char_type_category(H, T1) :-
    (   (char_type(H, digit), T1 = 4)
    ;   (char_type(H, lower), T1 = 2)
    ;   (char_type(H, upper), T1 = 1)
    ;   (char_type(H, prolog_symbol), T1 = 3)
    ;   (H = ';', T1 = 3)),
    !.

% word, buffer, type (0-unknown, 1-id, 2-key, 3-sep, 4-int), list, result
% Splits a list of characters into a list of tokens
split_chars([], B, _, L, W) :-
    (   B = '' -> L = W; (token_type(B, R), append(L, R, W))),
    !.

split_chars([H | R], _, 0, L, W) :-
    char_type_category(H, T1),
    split_chars(R, H, T1, L, W),
    !.
split_chars([H | R], B, T, L, W) :-
    char_type_category(H, T1),
    T1 = T,
    atom_concat(B, H, B1),
    split_chars(R, B1, T, L, W),
    !.
split_chars([H | R], B, _, L, W) :-
    char_type_category(H, T1),
    token_type(B, B1),
    append(L, B1, L1),
    split_chars(R, H, T1, L1, W).

% Reads the input stream into a list of strings
read_input(Str, R) :-
    get_char(Str, C),
    read_input(Str, C, R).
read_input(_, end_of_file, []) :- !.
read_input(Str, C, R) :-
    end_char(C),
    get_char(Str, C1),
    read_input(Str, C1, R),
    !.
read_input(Str, C, R) :-
    read_word(Str, C, '', X),
    read_input(Str, R1),
    append(X, R1, R),
    !.

% Reads a single word from the input stream
read_word(end_of_file, _, S, [S]) :- !.
% Handles case for end characters
read_word(_, C, Word, [Word]) :-
    end_char(C),
    !.
read_word(Str, C, Word, Res) :-
    atom_concat(Word, C, NewWord),
    get_char(Str, C1),
    read_word(Str, C1, NewWord, Res),
    !.

% Defines end characters
end_char(' ').
end_char('\n').
end_char('\r').
end_char('\t').

% Defines keywords
key(read).
key(write).
key(if).
key(then).
key(else).
key(fi).
key(while).
key(do).
key(od).
key(and).
key(or).
key(mod).

% Defines separators
sep(';').
sep('+').
sep('-').
sep('*').
sep('/').
sep('(').
sep(')').
sep('<').
sep('>').
sep('=').
sep('/=').
sep('=<').
sep('>=').
sep(':=').
