% utilities
% element -> return value at Pos
%element(P, X, L) :- element(P,1,X,L).
%element(P,P,X,[X|L]).
%element(P,CP,X,[_|L]) :- NP is CP + 1, element(P,NP,X,L).

element(P,X,L) :- nth1(P,L,X).

% sublist -> creates a sublist of the list
sublist(List,Position,Size,Res) :- sublist(List,Position,Size,Res,[]).
sublist(_,1,0,NewList,NewList).
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
sublineRight(_,_, List1, List, 0) :- reverse(List,List1), !.
sublineRight(Board,Position,List, AList, _) :- P1 is Position+1, M1 is P1 mod 8, element(P1,Element,Board), sublineRight(Board,P1,List,[Element|AList],M1).

% -----
% sublineLeft(Board,Position,List).
%	Computes the left subline
%	Parameters :
%		Board		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
sublineLeft(Board,Position, List) :- Modulo is Position mod 8, sublineLeft(Board,Position,List,[], Modulo).
sublineLeft(_,_, List1, List, 1) :- reverse(List,List1), !.
sublineLeft(Board,Position,List, AList, _) :- P1 is Position-1, M1 is P1 mod 8, element(P1,Element,Board), sublineLeft(Board,P1,List,[Element|AList],M1).


% -----
% subrowUp(Board,Position,List).
%	Computes the subrow above
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subrowUp(Board,Position, List) :- P1 is Position-8, subrowUp(Board,P1,List,[]).
subrowUp(_,Position, List1, List) :- Position =< 0, reverse(List,List1), !.
subrowUp(Board,Position,List, AList) :- P1 is Position-8, element(Position,Element,Board), subrowUp(Board,P1,List,[Element|AList]).

% -----
% subrowDown(Board,Position,List).
%	Computes the subrow below
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subrowDown(Board,Position, List) :- P1 is Position+8, subrowDown(Board,P1,List,[]).
subrowDown(_,Position, List1, List) :- Position >= 64, reverse(List,List1), !.
subrowDown(Board,Position,List, AList) :- P1 is Position+8, element(Position,Element,Board), subrowDown(Board,P1,List,[Element|AList]).

% -----
% subdiagUpLeft(Board,Position,List).
%	Computes the left-up sub diagonal
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subdiagUpLeft(Board,Position, List) :- P1 is Position-9, Modulo is Position mod 8, ModuloNext is P1 mod 8, subdiagUpLeft(Board,P1,List,[],Modulo,ModuloNext).
subdiagUpLeft(_,Position, List1, List, _, _) :- Position =< 0, reverse(List,List1), !.
subdiagUpLeft(_,_, List1, List, M, M1) :- M =\= M1+1, M=\=0, reverse(List,List1), !.
subdiagUpLeft(_,_, List1, List, _, M1) :- M1 == 0, reverse(List,List1), !.
subdiagUpLeft(Board,Position,List, AList, _, M1) :- M3 is M1, P1 is Position-9, M4 is P1 mod 8, element(Position,Element,Board), subdiagUpLeft(Board,P1,List,[Element|AList],M3,M4).

% -----
% subdiagDownLeft(Board,Position,List).
%	Computes the left-down sub diagonal
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subdiagDownLeft(Board,Position, List) :- P1 is Position+7, Modulo is Position mod 8, ModuloNext is P1 mod 8, subdiagDownLeft(Board,P1,List,[],Modulo,ModuloNext).
subdiagDownLeft(_,Position, List1, List, _, _) :- Position >= 64, reverse(List,List1), !.
subdiagDownLeft(_,_, List1, List, M, M1) :- M1 =\= M-1, M=\=0, reverse(List,List1), !.
subdiagDownLeft(_,_, List1, List, _, M1) :- M1 == 0, reverse(List,List1), !.
subdiagDownLeft(Board,Position,List, AList, _, M1) :- M3 is M1, P1 is Position+7, M4 is P1 mod 8, element(Position,Element,Board), subdiagDownLeft(Board,P1,List,[Element|AList],M3,M4).


% -----
% subdiagUpRight(Board,Position,List).
%	Computes the right-up sub diagonal
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subdiagUpRight(Board,Position, List) :- P1 is Position-7, Modulo is Position mod 8, ModuloNext is P1 mod 8, subdiagUpRight(Board,P1,List,[],Modulo,ModuloNext).
subdiagUpRight(_,Position, List1, List, _, _) :- Position =< 0, reverse(List,List1), !.
subdiagUpRight(_,_, List1, List, M, M1) :- M =\= M1-1, M1=\=0, reverse(List,List1), !.
subdiagUpRight(_,_, List1, List, _, M1) :- M1 == 1, reverse(List,List1), !.
subdiagUpRight(Board,Position,List, AList, _, M1) :- M3 is M1, P1 is Position-7, M4 is P1 mod 8, element(Position,Element,Board), subdiagUpRight(Board,P1,List,[Element|AList],M3,M4).


% -----
% subdiagDownRight(Board,Position,List).
%	Computes the right-down sub diagonal
%	Parameters :
%		Board 		-> the game Board
%		Position 	-> the sub starting position
%		List 		-> the resulting subline
subdiagDownRight(Board,Position, List) :- P1 is Position+9, Modulo is Position mod 8, ModuloNext is P1 mod 8, subdiagDownRight(Board,P1,List,[],Modulo,ModuloNext).
subdiagDownRight(_,Position, List1, List, _, _) :- Position > 64, reverse(List,List1), !.
subdiagDownRight(_,_, List1, List, M, M1) :- M =\= M1-1, M1=\=0, reverse(List,List1), !.
subdiagDownRight(_,_, List1, List, _, M1) :- M1 == 1, reverse(List,List1), !.
subdiagDownRight(Board,Position,List, AList, _, M1) :- M3 is M1, P1 is Position+9, M4 is P1 mod 8, element(Position,Element,Board), subdiagDownRight(Board,P1,List,[Element|AList],M3,M4).



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
possibleMoves(X,Player,Moves) :- possibleMoves(X,Player,Moves,[],1), !.
possibleMoves(_,_,R,R,65).
possibleMoves(X,Player,Moves,R,Pos) :- 	element(Pos,N,X), N =\= 0, Pos1 is Pos + 1, possibleMoves(X,Player,Moves,R,Pos1).
possibleMoves(X,Player,Moves,R,Pos) :- 	element(Pos,N,X), N == 0, line(X,Player,Pos,LinePoints), 
										column(X,Player,Pos,ColPoints), diag(X,Player,Pos,DiagPoints), 
										Points is LinePoints + ColPoints + DiagPoints, (Points =\= 0 -> append(R,[[Pos,Points]],Concat) ; append(R,[],Concat)),
										Pos1 is Pos + 1, possibleMoves(X,Player,Moves,Concat,Pos1).

diag(Board,Player,Position,Points) :- subdiagDownRight(Board,Position,SubList1), subdiagDownLeft(Board,Position,SubList2), 
										subdiagUpRight(Board,Position,SubList3), subdiagUpLeft(Board,Position,SubList4),
										match(SubList1,Player,Points1), match(SubList2,Player,Points2), match(SubList3,Player,Points3),
										match(SubList4,Player,Points4), Points is Points1+Points2+Points3+Points4.

% line(Board,Player,Pos,Points).
%	Return points earned by adding a token at position Pos
%	Parameters :
%		Board 	-> the game Board
%		Player 	-> the number of the player
%		Pos 	-> position concerned
%		Points 	-> Points earned by the checked move
line(Board,Player,Pos,Points) :- 	sublineLeft(Board,Pos,SubLeft), match(SubLeft,Player,PointsLeft), 
									sublineRight(Board,Pos,SubRight), match(SubRight,Player,PointsRight),
									Points is PointsLeft + PointsRight.

column(Board,Player,Position,Points) :- subrowUp(Board,Position,SubList1), match(SubList1, Player, Points1), 
										subrowDown(Board,Position,SubList2), match(SubList2,Player,Points2), 
										Points is Points1+Points2.
