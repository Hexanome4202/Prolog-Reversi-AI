% add the result of the game to the result file
addResult(Result) :- open('stats.txt', append, Handle), write(Handle, Result), write(Handle, ';'), close(Handle).

%stats(NbIterations)
stats(0) :- !.
stats(Restant) :- play(Winner), addResult(Winner), I is Restant-1, stats(I).
