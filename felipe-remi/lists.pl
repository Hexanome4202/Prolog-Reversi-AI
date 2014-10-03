member(X,[X|_]).
member(X,[_|L]) :- member(X,L).

member(X,[],[]).
member(X,[X],[]).
member(X,[X|Q],Q) :- member(X,Q,Q).
member(X,[T|L],[T|R]) :- member(X,L,R).