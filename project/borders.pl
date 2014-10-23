corner(1).
corner(8).
corner(57).
corner(64).
border(X) :- X mod 8 == 1.
border(X) :- X mod 8 == 0.
border(X) :- X < 8, X > 0.
border(X) :- X > 57, X < 64.

positionPoints(X, Points) :-
	(corner(X) -> Points is 3;
		(border(X) -> Points is 2;
			Points is 1
		)
	).

bestPositionIA([X|PossibleMoves], Move) :- 
	element(1,First,X),
	positionPoints(First,Second), 
	bestMove(PossibleMoves,Move,Second,First).
bestMove([],Current,_,Current).
bestMove([X|PossibleMoves],Move,CurrentMax,Current) :- 
	element(1,First,X), 
	positionPoints(First,Second), 
	(Second > CurrentMax -> CurrMax is Second, Curr is First; CurrMax is CurrentMax, Curr is Current), 
	bestMove(PossibleMoves,Move,CurrMax,Curr).