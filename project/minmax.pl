minmax(Depth, PossibleMoves, Move, Player, Board) :- minmax(Depth, PossibleMoves, Move, -1,max, Player, Board, 0).
minmax(0,[X|_],Move,Move,_,_,_,Score) :- element(2,CurrentScore,X), Score is CurrentScore.
minmax(_,[],Move,Move,_,_,_,0).
minmax(Depth, [X|_], Move, Result, max, Player, Board, Score) :- NewDepth is Depth-1, 
														element(1,NewMove,X), 
														updateAll(Board,NewMove,Player,NewBoard), 
														nextPlayer(Player,NewPlayer), 
														possibleMoves(NewBoard,NewPlayer,NewPossibleMoves), 
														minmax(NewDepth, NewPossibleMoves, Move, Result, min, NewPlayer, NewBoard, Score2),
														
														
														
minmax(Depth, [X|_], Move, Result, min, Player, Board) :- NewDepth is Depth-1, element(1,NewMove,X), updateAll(Board,NewMove,Player,NewBoard), nextPlayer(Player,NewPlayer), possibleMoves(NewBoard,NewPlayer,NewPossibleMoves), minmax(NewDepth, NewPossibleMoves, Move, Result, max, NewPlayer, NewBoard).