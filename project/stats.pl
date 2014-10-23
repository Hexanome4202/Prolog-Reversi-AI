% add the result of the game to the result file
addResult(Result) :- open('stats.txt', append, Handle), write(Handle, Result), write(Handle, '\n'), close(Handle).

%stats(NbIterations)
stats(_, _, 0) :- !.
stats(Ia1, Ia2, Restant) :- play(Winner, Ia1, Ia2), addResult(Winner), I is Restant-1, stats(Ia1, Ia2, I).

listeStats(0, _, _) :- !.
listeStats(Ia1, Ia1, Nb) :- NewIa2 is Ia2 - 1, listeStats(Ia1, NewIa2).
listeStats(Ia1, 0, Nb) :- NewIa1 is Ia1 -1, listeStats(NewIa1, 4, Nb).
listeStats(Ia1, Ia2, Nb) :- stats(Ia1, Ia2, Nb), NewIa2 is Ia2 - 1, listeStats(Ia1, NewIa2).