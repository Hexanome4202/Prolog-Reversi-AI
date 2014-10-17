% display(Board);
display(Board) :- display(Board,1).
display([],_).
display([X|Board],Pos) :- (X == 1 -> write('X'); (X == 2 -> write('O'); write(' '))), Mod is Pos mod 8, (Mod == 0 -> nl ; write('|')), Pos1 is Pos + 1, display(Board,Pos1).