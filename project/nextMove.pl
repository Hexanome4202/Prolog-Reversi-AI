% nextMove(X,Player,Move).
nextMove(X,1,Move) :- possibleMoves(X,1,Moves,Move), ia1(X,Moves,Move).
nextMove(X,2,Move) :- possibleMoves(X,2,Moves,Move), ia2(X,Moves,Move).

possibleMoves(X,Player,Moves,Move) :- possibleMoves(X,Player,Moves,[],Move,1).
possibleMoves(X,Player,R,R,Move,65).
possibleMoves(X,Player,R,R,Move,Pos) :- nextPlayer(Player,NextPlayer), line(X,Player,Pos,NB), column(X,Player,Pos,NB), diag(X,Player,Pos,NB).

line(X,Player,Pos, NB) :- backwardLine(), forwardLine(), NB is NB1 + NB2.