:- include('init.pl').
:- include('utilities.pl').
:- include('nextMove.pl').
:- include('match.pl').
:- include('update.pl').
:- include('display.pl').
:- include('minmax.pl').
:- include('borders.pl').
:- include('stats.pl').

% ----
% launch the game and gives a winner
% if winner = 0 -> nobody wins
% if winner = 1 -> player 1 wins
% if winner = 2 -> player 2 wins
play(Winner, Ia1, Ia2) :- 
	retract(board(_)), 
	assert(board([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])), 
	retract(possibleMoves1(_)), 
	assert(possibleMoves1(1)), 
	play(1,Winner, Ia1, Ia2),!.
	
play(_,Winner, _, _) :- win(Winner),!.

play(Player,Winner, Ia1, Ia2) :- 
	board(X), 
	displayBoard(X),
	%get_single_char(_),
	nextMove(X,Player,Move, Ia1, Ia2), 
	updateAll(X,Move,Player,NewBoard), 
	retract(board(X)), 
	assert(board(NewBoard)), 
	nextPlayer(Player,NewPlayer), 
	play(NewPlayer, Winner, Ia1, Ia2).

% nextPlayer(Player, NewPlayer) -> 1 gives 2, 2 gives 1.
nextPlayer(Player,NewPlayer) :- 
	P1 is Player+1, 
	pow(-1,P1,X), 
	NewPlayer is Player+X.

% randomIA(PossibleMoves, Move)
randomIA([],-1).
randomIA(PossibleMoves, Move) :- 
	sizeOfList(PossibleMoves, Size), 
	Position is random(Size)+1, 
	element(Position,MoveList,PossibleMoves), 
	element(1,Move,MoveList).

bestCurrentMoveIA([X|PossibleMoves], Move) :- 
	element(1,First,X), 
	element(2,Second,X), 
	bestMove(PossibleMoves,Move,Second,First).
	
bestMove([],Current,_,Current).

bestMove([X|PossibleMoves],Move,CurrentMax,Current) :- 
	element(1,First,X), 
	element(2,Second,X), 
	(Second > CurrentMax -> CurrMax is Second, Curr is First; CurrMax is CurrentMax, Curr is Current), 
	bestMove(PossibleMoves,Move,CurrMax,Curr).

% win -> conditions to win
win(Winner) :- 
	possibleMoves1(X), 
	X = [], 
	possibleMoves2(Y), 
	Y = [], 
	board(Board), 
	count(1,Board, C1), 
	count(2,Board,C2), 
	(C1 > C2 -> Winner is 1; (C2 > C1 -> Winner is 2 ; Winner is 0)), 
	!.
