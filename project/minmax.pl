% -----
% minmaxIA(Depth,Player,PossibleMoves,Move).
%	Predicate that gives the best Move to play.
%	This IA uses the minmax algorithm and chooses
%	the best move by the number of pieces it swaps
%	
%	Parameters :
%		Depth			-> how deep the minmax algo will go
%		Player 			-> the actual player
%		PossibleMoves	-> what moves the actual player can play
%		Move			-> the selected best move to play 
minmaxIA(Depth,Player,PossibleMoves,Move) :- 
	((Player == 1 -> possibleMoves2([]) ; possibleMoves1([])) -> bestCurrentMoveIA(PossibleMoves,Move); minmax(Depth,Player,PossibleMoves,Move)).

% -----
% max(Val1,Val2,Res).
%	given two lists of two elements, gives the list that has the max second element
%	ex :
%		max([12,3],[-5,10],X).
%		X = [-5,10]
%
%	Parameters :
%		Val1	-> first list to compare
%		Val2	-> second list to compare
%		Res		-> max list
max(Val1,Val2,Res) :- 
	element(2,X,Val1), 
	element(2,Y,Val2), 
	(X >= Y -> Res = Val1 ; Res = Val2).

% -----
% min(Val1,Val2,Res).
%	given two lists of two elements, gives the list that has the minimum second element
%	ex :
%		min([12,3],[-5,10],X).
%		X = [12,3]
%
%	Parameters :
%		Val1	-> first list to compare
%		Val2	-> second list to compare
%		Res		-> min list
min(Val1,Val2,Res) :- 
	element(2,X,Val1), 
	element(2,Y,Val2), 
	(X =< Y -> Res = Val1 ; Res = Val2).


minmax(Depth, Player, PossibleMoves, MoveToPlay) :- 
	board(Board), 
	minmax(Depth,Depth,Board,Player, max, [-1,0], PossibleMoves, [-1,-999999], Result),
	element(1,X,Result),
	MoveToPlay is X.

% ----
% Condition to stop if Depth == 0
minmax(_,0,_,_,_,Move,_,_,Move) :- !.

% ----
% Condition to stop if there is no possibleMoves left and the depth is the inital depth
minmax(Depth,Depth,_,_,_,_,[],Move,Move) :- !.

% ----
% Condition to stop if there is no possibleMoves left
minmax(_,_,_,_,_,[Move,_],[],[_,Points],[Move,Points]) :- !.

% ----
% minmax call searching for the max value
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

% ----
% minmax call searching for the min value
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

% -----
% minmaxAlphaBetaIA(Depth,Player,PossibleMoves,Move).
%	Predicate that gives the best Move to play.
%	This IA uses the minmax algorithm with the alpha-beta pruning (élagage) and chooses
%	the best move by the number of pieces it swaps
%	
%	Parameters :
%		Depth			-> how deep the minmax algo will go
%		Player 			-> the actual player
%		PossibleMoves	-> what moves the actual player can play
%		Move			-> the selected best move to play 
minmaxAlphaBetaIA(Depth,Player,PossibleMoves,Move) :- 
	((Player == 1 -> possibleMoves2([]) ; possibleMoves1([])) -> bestCurrentMoveIA(PossibleMoves,Move); minmaxAlphaBeta(Depth,Player,PossibleMoves,Move)).


minmaxAlphaBeta(Depth, Player, PossibleMoves, MoveToPlay) :-
	board(Board), 
	minmaxAlphaBeta(Depth,Depth,Board,Player, max, -99999,[-1,0], PossibleMoves, [-1,-999999], Result),
	element(1,X,Result),
	MoveToPlay is X.

% ----
% Condition to stop if Depth == 0
minmaxAlphaBeta(_,0,_,_,_,_,Move,_,_,Move) :- !.

% ----
% Condition to stop if there is no possibleMoves left and the depth is the inital depth
minmaxAlphaBeta(Depth,Depth,_,_,_,_,_,[],Move,Move) :- !.

% ----
% Condition to stop if there is no possibleMoves left
minmaxAlphaBeta(_,_,_,_,_,_,[Move,_],[],[_,Points],[Move,Points]) :- !.

% ----
% minmaxAlphaBeta call searching for the max value
minmaxAlphaBeta(ConstantDepth, Depth, Board, Player, max, AlphaBeta, CurrentMove, [NewMove|PossibleMoves], Val, Result) :-
	!,
	NewDepth is Depth-1,
	nextPlayer(Player,NewPlayer),
	element(1,PositionNewMove,NewMove),
	updateAll(Board,PositionNewMove,Player,NewBoard),
	possibleMoves(NewBoard, NewPlayer,NewPossibleMoves),
	element(2,NewAlphaBeta,Val),
	minmaxAlphaBeta(ConstantDepth, NewDepth, NewBoard, NewPlayer, min, NewAlphaBeta, NewMove, NewPossibleMoves, [-1,999999], NewResult),
	max(Val,NewResult, MaxResult),
	element(2,PossibleAlphaBeta,MaxResult),
	(AlphaBeta > PossibleAlphaBeta -> minmaxAlphaBeta(ConstantDepth, Depth, Board, Player, max, AlphaBeta,CurrentMove, PossibleMoves, MaxResult, Result) ; minmaxAlphaBeta(ConstantDept,Depth,Board,Player,max,AlphaBeta,CurrentMove,[],MaxResult,Result)).

% ----
% minmaxAlphaBeta call searching for the min value
minmaxAlphaBeta(ConstantDepth, Depth, Board, Player, min, AlphaBeta, CurrentMove, [NewMove|PossibleMoves], Val, Result) :-
	!,
	NewDepth is Depth-1,
	nextPlayer(Player,NewPlayer),
	element(1,PositionNewMove,NewMove),
	updateAll(Board,PositionNewMove,Player,NewBoard),
	possibleMoves(NewBoard, NewPlayer,NewPossibleMoves),
	element(2,NewAlphaBeta,Val),
	minmaxAlphaBeta(ConstantDepth, NewDepth, NewBoard, NewPlayer, max, NewAlphaBeta, NewMove, NewPossibleMoves, [-1,-999999], NewResult),
	min(Val,NewResult, MinResult),
	element(2,PossibleAlphaBeta,MinResult),
	(AlphaBeta < PossibleAlphaBeta -> minmaxAlphaBeta(ConstantDepth, Depth, Board, Player, min, AlphaBeta, CurrentMove, PossibleMoves, MinResult, Result) ; minmaxAlphaBeta(ConstantDept,Depth,Board,Player,min,AlphaBeta,CurrentMove,[],MinResult,Result)).
