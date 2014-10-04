member(X,[X],[]):-!.
member(X,[X|Q],Q).
member(X,[T|L],[T|R]) :- member(X,L,R).
