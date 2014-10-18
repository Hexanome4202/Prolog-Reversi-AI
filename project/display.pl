% displayBoard(Board);
displayBoard(Board) :- nl, displayBoard(Board,1).
displayBoard([],_).
displayBoard([X|Board],Pos) :- (X == 1 -> write('X'); (X == 2 -> write('O'); write(' '))), Mod is Pos mod 8, (Mod == 0 -> nl ; write('|')), Pos1 is Pos + 1, displayBoard(Board,Pos1).