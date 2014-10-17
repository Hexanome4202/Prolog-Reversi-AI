%append([ ], L1, L1).
%append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).

% Replaces the piece at Position by a Player s piece
%update(Board, Player, Position, NewBoard)
update(Board,_,-1, Board).
update([_|Y],Player,1, [Player|Y] ).
update([X|Y], Player, Move, NewBoard) :- NewMove is Move-1, update(Y, Player, NewMove, Test), append([X], Test, NewBoard).

%Updates pieces on left line
updateLeftLine(Board, Position, Player, Board) :- sublineLeft(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateLeftLine(Board, Position, Player, NewBoard) :- sublineLeft(Board, Position, List), match(List, Player, Points), Points > 0, changeLeftLine(Board, Position, Player, NewBoard).

%Updates pieces on right line
updateRightLine(Board, Position, Player, Board) :- sublineRight(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateRightLine(Board, Position, Player, NewBoard) :- sublineRight(Board, Position, List), match(List, Player, Points), Points > 0, changeRightLine(Board, Position, Player, NewBoard).

% -----
% changeLeftLine(Board,Position,Player, NewBoard).
%	Turns the pieces on the left subline
%	Parameters :
%		Board		-> the game Board
%		Position 	-> the sub starting position
%		Player 		-> the actual player
%		NewBoard	-> the refreshed board
changeLeftLine(Board,Position,_, Board) :- Modulo is Position mod 8, Modulo == 1, !.
changeLeftLine(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeLeftLine(Board,Position, Player, NewBoard) :- P1 is Position-1, update(Board, Player, Position, TempBoard), changeLeftLine(TempBoard,P1, Player, NewBoard).

% -----
% changeRightLine(Board,Position,Player, NewBoard).
%	Turns the pieces on the right subline
changeRightLine(Board,Position,_, Board) :- Modulo is Position mod 8, Modulo == 1, !.
changeRightLine(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeRightLine(Board,Position, Player, NewBoard) :- P1 is Position+1, update(Board, Player, Position, TempBoard), changeRightLine(TempBoard,P1, Player, NewBoard).
