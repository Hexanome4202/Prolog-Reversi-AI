minmaxIA(Depth,Player,PossibleMoves,Move) :- 
	((Player == 1 -> possibleMoves2([]) ; possibleMoves1([])) -> bestCurrentMoveIA(PossibleMoves,Move); minmax(Depth,Player,PossibleMoves,Move)).

max(Val1,Val2,Res) :- 
	element(2,X,Val1), 
	element(2,Y,Val2), 
	(X >= Y -> Res = Val1 ; Res = Val2).

min(Val1,Val2,Res) :- 
	element(2,X,Val1), 
	element(2,Y,Val2), 
	(X =< Y -> Res = Val1 ; Res = Val2).

minmax(Depth, Player, PossibleMoves, MoveToPlay) :- 
	board(Board), 
	minmax(Depth,Depth,Board,Player, max, [-1,0], PossibleMoves, [-1,-999999], Result),
	element(1,X,Result),
	MoveToPlay is X.

minmax(_,0,_,_,_,Move,_,_,Move) :- !.

minmax(Depth,Depth,_,_,_,_,[],Move,Move) :- !.

minmax(_,_,_,_,_,[Move,_],[],[_,Points],[Move,Points]) :- !.

minmax(ConstantDepth, Depth, Board, Player, max, CurrentMove, [NewMove|PossibleMoves], Val, Result) :- 
	!,
	NewDepth is Depth-1,
	nextPlayer(Player,NewPlayer),
	element(1,PositionNewMove,NewMove),
	updateAll(Board,PositionNewMove,Player,NewBoard),
	possibleMoves(NewBoard, NewPlayer,NewPossibleMoves),
	minmax(ConstantDepth, NewDepth, NewBoard, NewPlayer, min, NewMove, NewPossibleMoves, [-1,999999], NewResult),
	max(Val,NewResult, MaxResult),
	minmax(ConstantDepth, Depth, Board, Player, max, CurrentMove, PossibleMoves, MaxResult, Result).

minmax(ConstantDepth, Depth, Board, Player, min, CurrentMove, [NewMove|PossibleMoves], Val, Result) :- 
	!,
	NewDepth is Depth-1, 
	nextPlayer(Player,NewPlayer),
	element(1,PositionNewMove,NewMove),
	updateAll(Board,PositionNewMove,Player,NewBoard), 
	possibleMoves(NewBoard, NewPlayer,NewPossibleMoves),
	minmax(ConstantDepth, NewDepth, NewBoard, NewPlayer, max, NewMove, NewPossibleMoves, [-1,-999999], NewResult),
	min(Val,NewResult, MinResult),
	minmax(ConstantDepth, Depth, Board, Player, min, CurrentMove, PossibleMoves, MinResult, Result).
