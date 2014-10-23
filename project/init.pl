%  Init of game board
% 0 -> empty tile
% 1 -> player 1 (X)
% 2 -> player 2 (O)
:- dynamic board/1.
board([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]).

% ----
% IAs
%	Moves: all possible moves
%	Move: The chosen one
ia(Player,Moves,Move, 1) :- minmaxAlphaBetaIA(5, Player,Moves,Move).
ia(_,Moves,Move, 2) :- bestPositionIA(Moves,Move).
ia(_,Moves,Move, 3) :- randomIA(Moves,Move).
ia(Player,Moves,Move, 4) :- minmaxIA(3,Player,Moves,Move).
ia(Player,Moves,Move, 5) :- bestCurrentMoveIA(Moves, Move).

% ----
% Possible moves for players 1 and 2
:- dynamic possibleMoves1/1.
possibleMoves1([[21,1],[30,1],[35,1],[44,1]]).
:- dynamic possibleMoves2/1.
possibleMoves2([]).
