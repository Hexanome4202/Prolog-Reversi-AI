% elementAt(Element, List, Position)
elementAt(X,[X|_],1).
elementAt(X,[_|T],N) :- N > 1, N1 is N-1, elementAt(X,T,N1).

% sizeOfList(List,Size)
sizeOfList([],0).
sizeOfList([_|T],N) :- sizeOfList(T,N1), N is N1+1.

% count(Element, List, Counter) 
count(Element, List, Counter) :- count(Element, List, Counter, 0).
count(_, [], Counter, Counter).
count(Element, [Head|Tail], Counter, ACounter) :- (Element = Head -> C1 is ACounter+1 ; C1 is ACounter), count(Element,Tail,Counter,C1).