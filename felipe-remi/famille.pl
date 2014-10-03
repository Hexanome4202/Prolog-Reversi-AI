:- dynamic woman/1.
woman(alicia).
woman(justine).
woman(cecilia).
woman(camille).

man(remi).
man(felipe).
man(titouan).
man(alexandre).

% parent(parent,child).
parent(alexandre, alicia).
% parent(camille, alicia).
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

% ancester with trace (nice function)
ancester(X,Y,R) :- ancester(X,Y,[X],R).

% ancester with trace
ancester(X,X,L,L).
ancester(X,Y,L,R) :- parent(X,Z), ancester(Z,Y,[Z|L],R), X\=Y.