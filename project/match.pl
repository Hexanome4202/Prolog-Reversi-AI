match(List, Player, Points) :- match(List, Player, Points, TempPoints).

match([],  Player, TempPoints, TempPoints) :- TempPoints > 0.
match([X|Y], X, Points, TempPoints) :- X>0, match([], Player, Points, TempPoints).
match([X|Y], Player, Points, TempPoints) :- X>0, Player =\= X, TP is TempPoints +1, match(Y, Player, Points, TP).