woman(alicia).
woman(justine).
woman(cecilia).
woman(camille).

:- dynamic man/1.
man(remi).
man(felipe).
man(titouan).
man(alexandre).

% parent(parent,child).
parent(alexandre, alicia).
parent(camille, alicia).
parent(felipe,titouan).
parent(cecilia,titouan).
parent(remi,alexandre).
parent(remi,camille).
parent(remi,felipe).
parent(felipe,justine).
parent(cecilia,justine).

% ancester(ancester,child).
ancester(X,Y) :- parent(X,Y).
ancester(X,Y) :- parent(X,Z), ancester(Z,Y), X \= Y.

% fraternity(one,two).
fraternity(X,Y) :- parent(Z,X), parent(Z,Y), X \= Y.

% child(child,parent).
child(X,Y) :- parent(Y,X).

% uncle(uncle,nephew).
uncle(X,Y) :- parent(Z,Y), fraternity(Z,X), X \= Y.

append([],L1,L1).
append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).

ancetre3(X,Y,T) :- ancetre2(X,Y,[X],T).
ancetre2(X,X,V,V).
ancetre2(X,Y,V,T) :- parent(X,Z), ancetre2(Z,Y,[Z|V],T).

member(X,[X|_]).
member(X,[_|L]) :- member(X,L).

member2(X,[],[]):-!.
member2(X,[X],[]):-!.
member2(X,[X|R],R):-!.
member2(X,[T|Q],[T|R]) :- member2(X,Q,R). 
