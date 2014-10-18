%append([ ], L1, L1).
%append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).

updateAll(Board,-1,_,Board).
updateAll(Board,Move,Player,NewBoard) :- updateLeftLine(Board,Move,Player,NewBoard0), update(NewBoard0,0,Move,NewBoard1), 
										updateRightLine(NewBoard1,Move,Player,NewBoard2), update(NewBoard2,0,Move,NewBoard3), 
										updateUpperLine(NewBoard3,Move,Player,NewBoard4), update(NewBoard4,0,Move,NewBoard5), 
										updateBelowLine(NewBoard5,Move,Player,NewBoard6), update(NewBoard6,0,Move,NewBoard7), 
										updateDownLeftDiag(NewBoard7,Move,Player,NewBoard8), update(NewBoard8,0,Move,NewBoard9), 
										updateDownRightDiag(NewBoard9,Move,Player,NewBoard10), update(NewBoard10,0,Move,NewBoard11), 
										updateUpLeftDiag(NewBoard11,Move,Player,NewBoard12), update(NewBoard12,0,Move,NewBoard13), 
										updateUpRightDiag(NewBoard13,Move,Player,NewBoard14), update(NewBoard14,Player,Move,NewBoard), !.

% Replaces the piece at Position by a Players piece
% update(Board, Player, Position, NewBoard)
update(Board,_,-1, Board).
update([_|Y],Player,1, [Player|Y] ).
update([X|Y], Player, Move, NewBoard) :- NewMove is Move-1, update(Y, Player, NewMove, Test), append([X], Test, NewBoard).

%Updates pieces on left line
updateLeftLine(Board, Position, Player, Board) :- sublineLeft(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateLeftLine(Board, Position, Player, NewBoard) :- sublineLeft(Board, Position, List), match(List, Player, Points), Points > 0, changeLeftLine(Board, Position, Player, NewBoard).

%Updates pieces on right line
updateRightLine(Board, Position, Player, Board) :- sublineRight(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateRightLine(Board, Position, Player, NewBoard) :- sublineRight(Board, Position, List), match(List, Player, Points), Points > 0, changeRightLine(Board, Position, Player, NewBoard).

%Updates pieces on above line
updateUpperLine(Board, Position, Player, Board) :- subrowUp(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateUpperLine(Board, Position, Player, NewBoard) :- subrowUp(Board, Position, List), match(List, Player, Points), Points > 0, changeUpperLine(Board, Position, Player, NewBoard).

%Updates pieces on below line
updateBelowLine(Board, Position, Player, Board) :- subrowDown(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateBelowLine(Board, Position, Player, NewBoard) :- subrowDown(Board, Position, List), match(List, Player, Points), Points > 0, changeBelowLine(Board, Position, Player, NewBoard).

%Updates pieces on up left diagonal
updateUpLeftDiag(Board, Position, Player, Board) :- subdiagUpLeft(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateUpLeftDiag(Board, Position, Player, NewBoard) :- subdiagUpLeft(Board, Position, List), match(List, Player, Points), Points > 0, changeUpLeftDiag(Board, Position, Player, NewBoard).

%Updates pieces on up right diagonal
updateUpRightDiag(Board, Position, Player, Board) :- subdiagUpRight(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateUpRightDiag(Board, Position, Player, NewBoard) :- subdiagUpRight(Board, Position, List), match(List, Player, Points), Points > 0, changeUpRightDiag(Board, Position, Player, NewBoard).

%Updates pieces on down right diagonal
updateDownRightDiag(Board, Position, Player, Board) :- subdiagDownRight(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateDownRightDiag(Board, Position, Player, NewBoard) :- subdiagDownRight(Board, Position, List), match(List, Player, Points), Points > 0, changeDownRightDiag(Board, Position, Player, NewBoard).

%Updates pieces on down left diagonal
updateDownLeftDiag(Board, Position, Player, Board) :- subdiagDownLeft(Board, Position, List), match(List, Player, Points), Points == 0, !.
updateDownLeftDiag(Board, Position, Player, NewBoard) :- subdiagDownLeft(Board, Position, List), match(List, Player, Points), Points > 0, changeDownLeftDiag(Board, Position, Player, NewBoard).

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
changeLeftLine(Board,Position, Player, NewBoard) :- P1 is Position-1, update(Board, Player, Position, TempBoard), changeLeftLine(TempBoard,P1, Player, NewBoard), !.

% -----
% changeRightLine(Board,Position,Player, NewBoard).
%	Turns the pieces on the right subline
changeRightLine(Board,Position,_, Board) :- Modulo is Position mod 8, Modulo == 1, !.
changeRightLine(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeRightLine(Board,Position, Player, NewBoard) :- P1 is Position+1, update(Board, Player, Position, TempBoard), changeRightLine(TempBoard,P1, Player, NewBoard),!.

% -----
% changeUpperLine(Board,Position,Player, NewBoard).
%	Turns the pieces on the subline above
changeUpperLine(Board,Position,_, Board) :- Position =< 0, !.
changeUpperLine(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeUpperLine(Board,Position, Player, NewBoard) :- P1 is Position-8, update(Board, Player, Position, TempBoard), changeUpperLine(TempBoard,P1, Player, NewBoard),!.

% -----
% changeBelowLine(Board,Position,Player, NewBoard).
%	Turns the pieces on the subline below
changeBelowLine(Board,Position,_, Board) :- Position >= 64, !.
changeBelowLine(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeBelowLine(Board,Position, Player, NewBoard) :- P1 is Position+8, update(Board, Player, Position, TempBoard), changeBelowLine(TempBoard,P1, Player, NewBoard),!.


% -----
% changeUpLeftDiag(Board,Position,Player, NewBoard).
%	Turns the pieces on the subline below
changeUpLeftDiag(Board,Position,_, Board) :- Position =< 0, !.
changeUpLeftDiag(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeUpLeftDiag(Board,Position, Player, NewBoard) :- Mod is Position mod 8, Mod == 1, update(Board, Player, Position, TempBoard), NewBoard is TempBoard, !.
changeUpLeftDiag(Board,Position, Player, NewBoard) :- P1 is Position-9, update(Board, Player, Position, TempBoard), changeUpLeftDiag(TempBoard,P1, Player, NewBoard),!.


% -----
% changeUpRightDiag(Board,Position,Player, NewBoard).
%	Turns the pieces on the subline below
changeUpRightDiag(Board,Position,_, Board) :- Position =< 0, !.
changeUpRightDiag(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeUpRightDiag(Board,Position, Player, NewBoard) :- Mod is Position mod 8, Mod == 0, update(Board, Player, Position, TempBoard), NewBoard is TempBoard, !.
changeUpRightDiag(Board,Position, Player, NewBoard) :- P1 is Position-7, update(Board, Player, Position, TempBoard), changeUpRightDiag(TempBoard,P1, Player, NewBoard),!.

% -----
% changeDownLeftDiag(Board,Position,Player, NewBoard).
%	Turns the pieces on the subline below
changeDownLeftDiag(Board,Position,_, Board) :- Position >= 64, !.
changeDownLeftDiag(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeDownLeftDiag(Board,Position, Player, NewBoard) :- Mod is Position mod 8, Mod == 1, update(Board, Player, Position, TempBoard), NewBoard is TempBoard, !.
changeDownLeftDiag(Board,Position, Player, NewBoard) :- P1 is Position + 7, update(Board, Player, Position, TempBoard), changeDownLeftDiag(TempBoard,P1, Player, NewBoard),!.


% -----
% changeDownRightDiag(Board,Position,Player, NewBoard).
%	Turns the pieces on the subline below
changeDownRightDiag(Board,Position,_, Board) :- Position >= 64, !.
changeDownRightDiag(Board,Position,Player, Board) :- nth1(Position,Board,X), X==Player, !.
changeDownRightDiag(Board,Position, Player, NewBoard) :- Mod is Position mod 8, Mod == 0, update(Board, Player, Position, TempBoard), NewBoard is TempBoard, !.
changeDownRightDiag(Board,Position, Player, NewBoard) :- P1 is Position+9, update(Board, Player, Position, TempBoard), changeDownRightDiag(TempBoard,P1, Player, NewBoard),!.



