

minmax(Depth, Player, PossibleMoves, MoveToPlay) :- 
	Depth > 0, 
	board(Board), 
	minmax(Depth,Board,Player, max, PossibleMoves, [-1,-999999], Result),
	element(1,X,Result),
	MoveToPlay is X.

minmax(0,_,_,_,Move,_,_,Move).

minmax(_,_,_,_,Move,[],_,Move).

minmax(Depth, Board, Player, max, [NewMove|PossibleMoves], Val, Result) :- 
	NewDepth is Depth-1, 
	nextPlayer(Player,NewPlayer),
	element(1,PositionNewMove,NewMove),
	updateAll(Board,PositionNewMove,NewPlayer,NewBoard), 
	possibleMoves(NewBoard, NewPlayer,NewPossibleMoves),
	minmax(NewDepth, NewBoard, NewPlayer, min, NewMove, NewPossibleMoves, [-1,999999], NewResult),
	max(Val,NewResult, MaxResult),
	minmax(Depth, Board, Player, max, PossibleMoves, MaxResult, Result).

minmax(Depth, Board, Player, min, [NewMove|PossibleMoves], Val, Result) :- 
	NewDepth is Depth-1, 
	nextPlayer(Player,NewPlayer), 
	updateAll(Board,NewMove,NewPlayer,NewBoard), 
	possibleMoves(NewBoard, NewPlayer,NewPossibleMoves),
	minmax(NewDepth, NewBoard, NewPlayer, max, NewMove, NewPossibleMoves, [-1,-999999], NewResult),
	min(Val,NewResult, MinResult),
	minmax(Depth, Board, Player, max, PossibleMoves, MinResult, Result).

max(Val1,Val2,Res) :- 
	element(2,X,Val1), 
	element(2,Y,Val2), 
	(X > Y -> Res is Val1 ; Res is Val2).

min(Val1,Val2,Res) :- 
	element(2,X,Val1), 
	element(2,Y,Val2), 
	(X < Y -> Res is Val1 ; Res is Val2).
