minmax(Depth,Player,Board,PossibleMoves,FinalMove) :- minmax(Depth,Player,Board,PossibleMoves,max, [], FinalMove).
minmax(0,_,_,[],_,ListScore,FinalMove).
minmax(0,_,_,[Move|RestPoss],_,ListScore,FinalMove) :- append(ListScore,Move,NewList), minmax(0,_,_,ResPoss,_,NewList,FinalMove).


-----------------------------------------------------------

minmax(Depth, PossibleMoves, Move, Player, Board) :- minmax(Depth, PossibleMoves, Move, -1,max, Player, Board, 0).
minmax(0,[X|_],Move,Move,_,_,_,Score) :- element(2,CurrentScore,X), Score is CurrentScore.
minmax(_,[],Move,Move,_,_,_,0).
minmax(Depth, [X|RestPlusAnonyme], Move, Result, max, Player, Board, Score) :- NewDepth is Depth-1, 
	element(1,NewMove,X), 
	updateAll(Board,NewMove,Player,NewBoard), 
	nextPlayer(Player,NewPlayer), 
	possibleMoves(NewBoard,NewPlayer,NewPossibleMoves), 
	minmax(NewDepth, NewPossibleMoves, Move, Result, min, NewPlayer, NewBoard, Score2),
	element(2,Score3,X),
	Score4 is Score,
	Score = Score2+Score3,
	minmax(Depth, RestPlusAnonyme, Move, Result, max, Player, Board, Score4).
														
minmax(Depth, [X|RestPlusAnonyme], Move, Result, min, Player, Board, Score) :- NewDepth is Depth-1, 
	element(1,NewMove,X), 
	updateAll(Board,NewMove,Player,NewBoard), 
	nextPlayer(Player,NewPlayer), 
	possibleMoves(NewBoard,NewPlayer,NewPossibleMoves), 
	minmax(NewDepth, NewPossibleMoves, Move, Result, max, NewPlayer, NewBoard, Score2),
	element(2,Score3,X),
	Score4 is Score,
	Score = Score2+Score3,
	minmax(Depth, RestPlusAnonyme, Move, Result, min, Player, Board, Score4).