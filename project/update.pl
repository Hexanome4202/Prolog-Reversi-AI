append([ ], L1, L1).
append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).

update([X|Y],Player,1, [Player|Y] ).
update([X|Y], Player, Move, NewBoard) :- NewMove is Move-1, update(Y, Player, NewMove, Test), append([X], Test, NewBoard).