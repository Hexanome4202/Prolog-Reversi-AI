%  Init of game board
% 0 -> empty tile
% 1 -> player 1
% 2 -> player 2
:- dynamic board/1.
% board([[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,1,2,0,0,0],[0,0,0,2,1,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]]).

board([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]).

% IAs
%	Moves: all possible moves
%	Move: The chosen one
ia1(_,Moves,Move) :- random(Moves,Move).
ia2(_,Moves,Move) :- random(Moves,Move).

% Possible moves
:- dynamic possibleMoves1/1.
possibleMoves1([[21,1],[30,1],[35,1],[44,1]]).
:- dynamic possibleMoves2/1.
possibleMoves2([]).
