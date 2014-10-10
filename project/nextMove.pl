% nextMove(X,Player,Move).
nextMove(X,1,Move) :- ia1(X,Move).
nextMove(X,2,Move) :- ia2(X,Move).