:- include('init.pl').

play(Player) :- win(???).
play(Player) :- board(X), nextMove(X,Player,Move), update(X,Player,Move,NewBoard), retract(board(X)), assert(board(NewBoard)), nextPlayer(Player,NewPlayer), play(NewPlayer).

% nextPlayer(Player, NewPlayer) -> 1 gives 2, 2 gives 1.
nextPlayer(Player,NewPlayer) :- P1 is Player+1, pow(-1,P1,X), NewPlayer is Player+X.

% elementAt(Element, List, Position)
elementAt(X,[X|_],1).
elementAt(X,[_|T],N) :- N > 1, N1 is N-1, elementAt(X,T,N1).

% sizeOfList(List,Size)
sizeOfList([],0).
sizeOfList([_|T],N) :- sizeOfList(T,N1), N is N1+1.

% randomIA(PossibleMoves, Move)
randomIA(PossibleMoves, Move) :- sizeOfList(PossibleMoves, Size), Position is random(Size)+1, elementAt(MoveList,PossibleMoves,Position), elementAt(Move,MoveList,1).
