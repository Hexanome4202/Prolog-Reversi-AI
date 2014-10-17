%Gets how many points are got with the given sublist
match(List, Player, Points) :- match(List, Player, 0, Points).

<<<<<<< HEAD
match([],  _, TempPoints, Points) :- Points is TempPoints ,!.
match([X], Player, _, Points) :- X =\= Player, Points is 0.
match([X|_], _, _, Points) :- X==0, Points is 0, !. 
match([X|_], X, TempPoints, Points) :- Points is TempPoints, !.
match([X|Y], Player, TempPoints, Points) :- X>0, X =\= Player, match(Y, Player, TempPoints+1, Points).
=======
match2([],_, TempPoints, Points) :- Points is TempPoints, TempPoints > 0.
match2([X|_],_, _, Points) :- X==0, Points is 0. 
match2([X|_], Player, TempPoints, Points) :- X==Player, Points is TempPoints, TempPoints > 0.
match2([X|Y], Player, TempPoints, Points) :- X>0, X =\= Player, match2(Y, Player, TempPoints+1, Points).
>>>>>>> origin/master
