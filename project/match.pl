match(List, Player, Points) :- match2(List, Player, 0, Points).

match2([],  Player, TempPoints, Points) :- Points is TempPoints, TempPoints > 0.
match2([X|Y], Player, TempPoints, Points) :- X==0, Points is 0. 
match2([X|Y], Player, TempPoints, Points) :- X==Player, Points is TempPoints, TempPoints > 0.
match2([X|Y], Player, TempPoints, Points) :- X>0, X =\= Player, match2(Y, Player, TempPoints+1, Points).
