% Part 2 ----------------------- 
member(X,[X|Q],Q).
member(X,[T|L],[T|R]) :- member(X,L,R).

extract(L,Extract) :- extract(L,Extract,[],2).
extractFinal(Res).
extract(L,Extract,Extract,0) :- reverse(Extract, Res), extractFinal(Res).
extract(L,Extract,Res,N) :- member(X,L), member(X,L,L1), N1 is N-1, extract(L1,Extract,[X|Res], N1).

% Part 3 -----------------------
% element(Pos, Element, List).

% Does not return P (position) but can return X (the element)
elements(1, X, [X|L]).
elements(P,E,[X|L]) :- P1 is P - 1, element(P1,E,L).

% Works in all cases
element(P, X, L) :- element(P,1,X,L).
element(P,P,X,[X|L]).
element(P,CP,X,[_|L]) :- NP is CP + 1, element(P,NP,X,L).

% Part 4 -----------------------

% member(X,S).
member(X,[X|_]).
member(X,[_|S]) :- member(X,S).

% isSet(S).
isSet(S) :- isSet(S,[]).
isSet([],L).
isSet([X|S],L) :- not(member(X,L)), isSet(S,[X|L]).

% list2set(S,E)
list2set(S,R) :- list2set(S,[],R).
list2set([],L,L).
list2set([X|S],L,R) :- (member(X,L) -> list2set(S,L,R) ; list2set(S,[X|L],R)).

% Part 5 -----------------------

% before(A,B)
before(A,B) :- name(A,X), name(B,Y), nameBefore(X,Y).
nameBefore([],B).
nameBefore([X|A],[Y|B]) :- (X>96 -> X1 is X-32 ; X1 is X), (Y>96 -> Y1 is Y-32 ; Y1 is Y), (X1 == Y1 -> nameBefore(A,B); (X1 < Y1 -> 1 == 1 ; 1==2)).
nameBefore([X|A],[X|B]) :- nameBefore(A,B).
% can be called with : ?-alex before remi.
:- op(42,xfx,before).
