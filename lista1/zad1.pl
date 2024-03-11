kobieta(kinga).
kobieta(beata).
kobieta(agata).
kobieta(halina).
kobieta(janina).
kobieta(paulina).

mezczyzna(tomasz).
mezczyzna(tadeusz).
mezczyzna(jerzy).
mezczyzna(lukasz).

matka(beata, kinga).
matka(beata, agata).
matka(halina, tomasz).
matka(janina, beata).
matka(janina, paulina).
matka(janina, lukasz).

ojciec(tomasz, kinga).
ojciec(tomasz, agata).
ojciec(tadeusz, tomasz).
ojciec(jerzy, beata).
ojciec(jerzy, paulina).
ojciec(jerzy, lukasz).


rodzic(X, Y) :-
    matka(X, Y);
    ojciec(X, Y).

jest_matka(X) :-
    kobieta(X),
    matka(X, _).

jest_ojcem(X) :-
    mezczyzna(X),
    ojciec(X, _).

jest_synem(X) :-
    mezczyzna(X),
    rodzic(_, X).

siostra(X, Y) :-
    kobieta(X),
    rodzenstwo(X, Y).

rodzenstwo(X, Y) :-
    rodzic(Z, X),
    rodzic(Z, Y),
    X \= Y.

dziadek(X, Y) :-
    ojciec(X, Z),
    rodzic(Z, Y).