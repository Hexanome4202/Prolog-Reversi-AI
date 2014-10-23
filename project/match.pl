% Gets how many points the player will get based on the given List 
match(List, Player, Points) :- match(List, Player, 0, Points).

match([],  _, TempPoints, Points) :- Points is TempPoints ,!.
match([X], Player, _, Points) :- X =\= Player, Points is 0, !.
match([X|_], _, _, Points) :- X==0, Points is 0, !. 
match([X|_], X, TempPoints, Points) :- Points is TempPoints, !.
match([X|Y], Player, TempPoints, Points) :- X>0, X =\= Player, match(Y, Player, TempPoints+1, Points).