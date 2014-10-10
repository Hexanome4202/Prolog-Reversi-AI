% utilities
% element --> return value at Pos
element(P, X, L) :- element(P,1,X,L).
element(P,P,X,[X|L]).
element(P,CP,X,[_|L]) :- NP is CP + 1, element(P,NP,X,L).

% sublist --> creates a sublist of the list
sublist(L,P,T,R) :- sublist(L,P,T,R,[]).
sublist(L,1,0,NewList,NewList).
sublist([X|L],1,T,R,NewList) :- T1 is T - 1, sublist(L,1,T1,R,[X|NewList]).
sublist([_|L],P,T,R,NewList) :- P1 is P - 1, sublist(L,P1,T,R,NewList).

% nextMove(X,Player,Move).
nextMove(X,1,Move) :- possibleMoves(X,1,Moves,Move), ia1(X,Moves,Move).
nextMove(X,2,Move) :- possibleMoves(X,2,Moves,Move), ia2(X,Moves,Move).

possibleMoves(X,Player,Moves,Move) :- possibleMoves(X,Player,Moves,[],Move,1).
possibleMoves(X,Player,R,R,Move,65).
possibleMoves(X,Player,R,R,Move,Pos) :- element(Pos,N,X), N == 0, nextPlayer(Player,NextPlayer), line(X,Player,Pos,NB), column(X,Player,Pos,NB), diag(X,Player,Pos,NB).

% line(X,Player,Pos,NB) :- backwardLine(X,Player,Pos, NB, 0), forwardLine(), NB is NB1 + NB2.

backwardLine(X,Player,Pos,R,NB).