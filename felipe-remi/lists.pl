% Part 2 ----------------------- 
member(X,[X|Q],Q).
member(X,[T|L],[T|R]) :- member(X,L,R).

extract(L,Extract) :- extract(L,Extract,2);

extract(L,[],1).
extract(L,T,1).
extract([X|L],[X|T],N) :- N1 is N - 1, extract(L,T,N1).
extract([X|L],[T],N) :- extract(L,T,N).

% Part 3 -----------------------
% element(Pos, Element, List).

element(1, X, [X|L]).
element(P,E,[X|L]) :- P > 1, P1 is P - 1, element(P1,E,L).