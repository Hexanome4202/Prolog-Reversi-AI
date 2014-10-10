:- include('init.pl').

play(Player) :- win(???).
play(Player) :- board(X), nextMove(X,Player,Move), update(X,Player,Move,NewBoard), retract(board(X)), assert(board(NewBoard)), nextPlayer(Player,NewPlayer), play(NewPlayer).

nextPlayer(Player,NewPlayer) :- P1 is Player+1, pow(-1,P1,X), NewPlayer is Player+X.
