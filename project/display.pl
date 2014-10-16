% display(Board);
display(Board) :- display(Board,1).
display([],Pos).
display([X|Board],Pos) :- write(X), Mod is Pos mod 8, (Mod == 0 -> nl ; write(' ')), Pos1 is Pos + 1, display(Board,Pos1).