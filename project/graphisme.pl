

:- use_module(library(pce)).
:- use_module(library(tabular)).
:- use_module(library(autowin)).

make_table(X) :-
        new(P, auto_sized_picture('Table with merged cells')), 
        send(P, display, new(T, tabular)),
        send(T, border, 1),
        send(T, cell_spacing, -1),
        send(T, rules, all),
        send_list(T, list(X,[Y])),
        send(P, open).	

		

list(Board,Y) :- nl, list(Board, Y, 1).
list([],_,_).
list([X|Board], Y, Pos) :- (X == 1 -> assert(Y,"append('X')"); (X == 2 -> assert(Y,"append('O')"); Mod is Pos mod 8, (Mod == 0 -> assert(Y,"next_row"); Pos1 is Pos + 1, displayBoard(Board,Pos1).