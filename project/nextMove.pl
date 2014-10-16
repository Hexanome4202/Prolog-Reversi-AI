% utilities
% element -> return value at Pos
%element(P, X, L) :- element(P,1,X,L).
%element(P,P,X,[X|L]).
%element(P,CP,X,[_|L]) :- NP is CP + 1, element(P,NP,X,L).

element(P,X,L) :- nth1(P,L,X).

% sublist -> creates a sublist of the list
sublist(List,Position,Size,Res) :- sublist(List,Position,Size,Res,[]).
sublist(L,1,0,NewList,NewList).
sublist([X|L],1,T,R,NewList) :- T1 is T - 1, sublist(L,1,T1,R,[X|NewList]).
sublist([_|L],P,T,R,NewList) :- P1 is P - 1, sublist(L,P1,T,R,NewList).


% -----
% sublineRight(Board,Position,List).
%	Computes the right subline
%	Parameters :
%		Board		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
sublineRight(Board,Position, List) :- Modulo is Position mod 8, sublineRight(Board,Position,List,[], Modulo).
sublineRight(Board,Position, List1, List, 0) :- reverse(List,List1), !.
sublineRight(Board,Position,List, AList, Modulo) :- P1 is Position+1, M1 is P1 mod 8, element(P1,Element,Board), sublineRight(Board,P1,List,[Element|AList],M1).

% -----
% sublineLeft(Board,Position,List).
%	Computes the left subline
%	Parameters :
%		Board		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
sublineLeft(Board,Position, List) :- Modulo is Position mod 8, sublineLeft(Board,Position,List,[], Modulo).
sublineLeft(Board,Position, List1, List, 1) :- reverse(List,List1), !.
sublineLeft(Board,Position,List, AList, Modulo) :- P1 is Position-1, M1 is P1 mod 8, element(P1,Element,Board), sublineLeft(Board,P1,List,[Element|AList],M1).


% -----
% subrowUp(Board,Position,List).
%	Computes the subrow above
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subrowUp(Board,Position, List) :- P1 is Position-8, subrowUp(Board,P1,List,[]).
subrowUp(Board,Position, List1, List) :- Position =< 0, reverse(List,List1), !.
subrowUp(Board,Position,List, AList) :- P1 is Position-8, element(Position,Element,Board), subrowUp(Board,P1,List,[Element|AList]).

% -----
% subrowDown(Board,Position,List).
%	Computes the subrow below
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subrowDown(Board,Position, List) :- P1 is Position+8, subrowDown(Board,P1,List,[]).
subrowDown(Board,Position, List1, List) :- Position >= 64, reverse(List,List1), !.
subrowDown(Board,Position,List, AList) :- P1 is Position+8, element(Position,Element,Board), subrowDown(Board,P1,List,[Element|AList]).

% -----
% subdiagUpLeft(Board,Position,List).
%	Computes the left-up sub diagonal
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subdiagUpLeft(Board,Position, List) :- P1 is Position-9, Modulo is Position mod 8, ModuloNext is P1 mod 8, subdiagUpLeft(Board,P1,List,[],Modulo,ModuloNext).
subdiagUpLeft(Board,Position, List1, List, M, M1) :- Position =< 0, reverse(List,List1), !.
subdiagUpLeft(Board,Position, List1, List, M, M1) :- M =\= M1+1, M=\=0, reverse(List,List1), !.
subdiagUpLeft(Board,Position, List1, List, M, M1) :- M1 == 0, reverse(List,List1), !.
subdiagUpLeft(Board,Position,List, AList, M, M1) :- M3 is M1, P1 is Position-9, M4 is P1 mod 8, element(Position,Element,Board), subdiagUpLeft(Board,P1,List,[Element|AList],M3,M4).

% -----
% subdiagDownLeft(Board,Position,List).
%	Computes the left-down sub diagonal
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subdiagDownLeft(Board,Position, List) :- P1 is Position+7, Modulo is Position mod 8, ModuloNext is P1 mod 8, subdiagDownLeft(Board,P1,List,[],Modulo,ModuloNext).
subdiagDownLeft(Board,Position, List1, List, M, M1) :- Position >= 64, reverse(List,List1), !.
subdiagDownLeft(Board,Position, List1, List, M, M1) :- M1 =\= M-1, M=\=0, reverse(List,List1), !.
subdiagDownLeft(Board,Position, List1, List, M, M1) :- M1 == 0, reverse(List,List1), !.
subdiagDownLeft(Board,Position,List, AList, M, M1) :- M3 is M1, P1 is Position+7, M4 is P1 mod 8, element(Position,Element,Board), subdiagDownLeft(Board,P1,List,[Element|AList],M3,M4).


% -----
% subdiagUpRight(Board,Position,List).
%	Computes the right-up sub diagonal
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subdiagUpRight(Board,Position, List) :- P1 is Position-7, Modulo is Position mod 8, ModuloNext is P1 mod 8, subdiagUpRight(Board,P1,List,[],Modulo,ModuloNext).
subdiagUpRight(Board,Position, List1, List, M, M1) :- Position =< 0, reverse(List,List1), !.
subdiagUpRight(Board,Position, List1, List, M, M1) :- M =\= M1-1, M1=\=0, reverse(List,List1), !.
subdiagUpRight(Board,Position, List1, List, M, M1) :- M1 == 1, reverse(List,List1), !.
subdiagUpRight(Board,Position,List, AList, M, M1) :- M3 is M1, P1 is Position-7, M4 is P1 mod 8, element(Position,Element,Board), subdiagUpRight(Board,P1,List,[Element|AList],M3,M4).


% -----
% subdiagDownRight(Board,Position,List).
%	Computes the right-down sub diagonal
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subdiagDownRight((Board,Position, List) :- P1 is Position-7, Modulo is Position mod 8, ModuloNext is P1 mod 8, subdiagDownRight((Board,P1,List,[],Modulo,ModuloNext).
subdiagDownRight((Board,Position, List1, List, M, M1) :- Position =< 0, reverse(List,List1), !.
subdiagDownRight((Board,Position, List1, List, M, M1) :- M =\= M1-1, M1=\=0, reverse(List,List1), !.
subdiagDownRight((Board,Position, List1, List, M, M1) :- M1 == 1, reverse(List,List1), !.
subdiagDownRight((Board,Position,List, AList, M, M1) :- M3 is M1, P1 is Position-7, M4 is P1 mod 8, element(Position,Element,Board), subdiagDownRight((Board,P1,List,[Element|AList],M3,M4).



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