:- include('init.pl').

play(Player) :- win(???).
play(Player) :- board(X), nextMove(X,Player,Move), update(X,Player,Move,NewBoard), retract(board(X)), assert(board(NewBoard)), nextPlayer(Player,NewPlayer), play(NewPlayer).

