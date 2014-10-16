% utilities
% element -> return value at Pos
element(P, X, L) :- element(P,1,X,L).
element(P,P,X,[X|L]).
element(P,CP,X,[_|L]) :- NP is CP + 1, element(P,NP,X,L).

% sublist -> creates a sublist of the list
sublist(List,Position,Size,Res) :- sublist(List,Position,Size,Res,[]).
sublist(L,1,0,NewList,NewList).
sublist([X|L],1,T,R,NewList) :- T1 is T - 1, sublist(L,1,T1,R,[X|NewList]).
sublist([_|L],P,T,R,NewList) :- P1 is P - 1, sublist(L,P1,T,R,NewList).


% -----
% sublineRight(Board,Position,List).
%	Computes the right subline
%	Parameters :
%		X 			-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
sublineRight(Board,Position, List) :- Modulo is Position mod 8, sublineRight(Board,Position,List,[], Modulo).
sublineRight(Board,Position, List1, List, 0) :- reverse(List,List1), !.
sublineRight(Board,Position,List, AList, Modulo) :- P1 is Position+1, M1 is P1 mod 8, element(P1,Element,Board), sublineRight(Board,P1,List,[Element|AList],M1).

% -----
% sublineLeft(Board,Position,List).
%	Computes the left subline
%	Parameters :
%		X 			-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
sublineLeft(Board,Position, List) :- Modulo is Position mod 8, sublineLeft(Board,Position,List,[], Modulo).
sublineLeft(Board,Position, List1, List, 1) :- reverse(List,List1), !.
sublineLeft(Board,Position,List, AList, Modulo) :- P1 is Position-1, M1 is P1 mod 8, element(P1,Element,Board), sublineLeft(Board,P1,List,[Element|AList],M1).

% -----
% nextMove(X,Player,Move).
%	list all possible moves and call the ia to chose one of them
%	Parameters :
%		X 		-> the game Board
%		Player 	-> the number of the player
%		Move 	-> the chosen move to perform
nextMove(X,1,Move) :- possibleMoves(X,1,Moves), ia1(X,Moves,Move).
nextMove(X,2,Move) :- possibleMoves(X,2,Moves), ia2(X,Moves,Move).

% -----
% possibleMoves(X,Player,Moves).
%	list all possible moves
%	Parameters :
%		X 		-> the game Board
%		Player 	-> the number of the player
%		Moves 	-> all the possible moves
possibleMoves(X,Player,Moves) :- possibleMoves(X,Player,Moves,[],1).
possibleMoves(X,Player,R,R,65).
% /!\ Uncomment when subfunctions done
% possibleMoves(X,Player,R,R,Pos) :- element(Pos,N,X), N == 0, nextPlayer(Player,NextPlayer), line(X,Player,Pos,NB), column(X,Player,Pos,NB), diag(X,Player,Pos,NB).

% line(X,Player,Pos,NB) :- backwardLine(X,Player,Pos, NB, 0), forwardLine(), NB is NB1 + NB2.

backwardLine(X,Player,Pos,R,NB).