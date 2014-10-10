% nextMove(X,Player,Move).
nextMove(X,Player,Move) :- nextMove(X,Player,Moves,Move).
nextMove(X,1,Moves,Move) :- ia1(X,Moves,Move).
nextMove(X,2,Moves,Move) :- ia2(X,Moves,Move).