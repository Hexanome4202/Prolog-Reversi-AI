
lien(paris,lyon).
lien(lyon,marseille).
lien(nice,marseille).
lien(lyon,paris).

% ?-lien(X,marseille).		2 succes
% ?-lien(marseille,lyon).	echec
% ?-lien(X,Y), lien(Y,X). 	2 succes


lien1(paris,lyon).
lien1(lyon,marseille).
lien1(nice,marseille).
chemin1(X,Y) :- lien1(X,Y).   
 			
% ?-chemin1(X,marseille).	2 succes
% ?-chemin1(X,Y).			3 succes

chemin2(X,Y) :- lien1(X,Y).    	
chemin2(X,Y) :- lien1(X,Z), chemin2(Z,Y). 

% ?-chemin2(X,marseille).
% ?-chemin2(X,Y).			4 succes

relation(X,Y) :- lien(X,Y).
fermeture(X,Y) :- relation(X,Y).    			
fermeture(X,Y) :- relation(X,Z), fermeture(Z,Y). 

% ?-fermeture(X,Y).
% Attention, puisque le graphe qui correspond à lien 
% contient un cycle, ce programme peut boucler

fermeture1(X,Y) :- relation(X,Y).    			
fermeture1(X,Y) :- relation(X,Z), fermeture1(Z,Y). 	

fermeture2(X,Y) :- relation(X,Z), fermeture2(Z,Y). 
fermeture2(X,Y) :- relation(X,Y).    		

fermeture3(X,Y) :- relation(X,Y).    		
fermeture3(X,Y) :- fermeture3(Z,Y), relation(X,Z). 
		
fermeture4(X,Y) :- fermeture4(Z,Y), relation(X,Z).	
fermeture4(X,Y) :- relation(X,Y).    	

liaison(paris,marseille,date(12,5,2008)). 
liaison(paris,marseille,heure(13,15),[lundi,jeudi]).

avant(date(_,_,A1),date(_,_,A2)) :- A1 < A2.
avant(date(_,M1,A),date(_,M2,A)) :- M1 < M2.
avant(date(J1,M,A),date(J2,M,A)) :- J1 < J2.

% ?- liaison(D,A,date(_,5,_)).
% ?- liaison(paris,lyon,date(J1,M1,A)), liaison(lyon,X,date(J2,M2,A)), 
%			avant(date(J1,M1,A),date(J2,M2,A)).
% ?- liaison(paris,_,heure(H,_), L), H > 12, member(jeudi,L).		

membre(X,[X|_]).		   /* voir aussi element et member */
membre(X,[_|L]) :- membre(X,L).

% ?- membre(b,[a,b,c]).
% ?- membre(X,[a,b,c]).
% ?- membre(a,L).

append([ ], L1, L1).
append([A|L1],L2,[A|L3]) :- append(L1,L2,L3).

% ?- append([a,b],[c],[a,b,c]), append([a,b],[c,d],X).
% ?- append(X,Y, [a,b,c,d]).
% ?- append(X,[a,b],Y]).
% ?- L=[a,b,c], append(_,[X],L).

lien2(a,b).	
lien2(b,c).	
lien2(c,d).	
lien2(b,d).
chemin3(X,Y,T) :- calcul_chemin(X,Y,[X],T).
calcul_chemin(X,X,V,V).
calcul_chemin(X,Y,V,T) :- lien2(X,Z), calcul_chemin(Z,Y,[Z|V],T).

% ?- chemin3(a,c,L).
% ?- chemin3(X,d,L).

lien3(a,b).		
lien3(b,c).
lien3(c,d).
lien3(b,d).	 				
lien3(d,b).				      
:- dynamic lien3/2.

chemin4(X,Y,R) :- calcul_chemin1(X,Y,[X],T), reverse(T,R).
calcul_chemin1(X,X,V,V).
calcul_chemin1(X,Y,V,T) :- lien3(X,Z), not(member(Z,V)), 
				calcul_chemin1(Z,Y,[Z|V],T).

% ?- chemin4(a,d,L).
% L=[a,b,c,d], L=[a,b,d]

intersec([],_,[]).
intersec([X|Y], Z, [X|T]) :- member(X,Z), intersec(Y,Z,T).
intersec([X|Y], Z, T) :- not(member(X,Z)), intersec(Y,Z,T).

intersec1([],_,[]) :- ! .
intersec1([X|Y], Z, [X|T]) :- member(X,Z), !, intersec1(Y,Z,T).
intersec1([_|Y], Z, T) :- intersec1(Y,Z,T).

% ?-R=[a,b,c,d], S=[a,c,e,d,r], 
%		setof(X,(member(X,R),member(X,S)),M), M = [a,c,d] 
% ?-setof(ar(X,Y),(lien3(X,Y),lien3(Y,X)), M), M == [ar(b,d), ar(d,b)] 


single(X) :- not(married(X)), (homme(X) ; femme(X)).
homme(bob).
femme(lola).
married(tom).

% ?-single(X).
% No

collecter(T,B,R) :- bagof(T,B,R), ! .
collecter(_,_ ,[]).
chemin5(X,Y,R) :- chemin_L([[X]],Y,T), reverse(T,R).
chemin_L([[X|Xs]|_],X,[X|Xs]).
chemin_L([[X|Xs]|L],Y,P):-
	collecter([N,X|Xs],
			(lien3(X,N),not(member(N,[X|Xs]))),Succ_de_X),
	append(L,Succ_de_X,Z),chemin_L(Z,Y,P).

% ?- chemin5(a,d,L).
% L=[a,b,d], L=[a,b,c,d]

p1([obj(s1),obj(s2),acces(c1)]).
p2([obj(s3),acces(c1),acces(p3)]).
p3([acces(p2),acces(c1)]).
p4([obj(s4),obj(s5),acces(c1)]).
c1([robot,acces(p1),acces(p2), acces(p3), acces(p4)]).


lien4(X,Y) :- F =.. [X,ArgX], call(F), member(acces(Y),ArgX).
% ?-lien4(c1,Y).

mouvement_Robot(X,Y) :- 
	F =.. [X,ArgX], call(F), member(robot,ArgX), retract(F), 
		select(robot,ArgX,NArgX),
			NF =.. [X,NArgX], assert(NF),
	G =.. [Y,ArgY], call(G), retract(G), 
			NG =.. [Y,[robot|ArgY]], assert(NG).
% ?-mouvement_Robot(c1,p1).

% ?- X is 2*3+2, X ==8
% ?- X is 8, X is X+1

longueur([],0).
longueur([_|Q],N) :- longueur(Q,N1), N is N1+1.

% ?- longueur([a,b,c],3).

colorier1(C1,C2,C3,C4,C5)
:- col(C1), col(C2), col(C3), col(C4), col(C5),
	C1 \== C2, C1 \== C3, C1 \== C4, C2 \== C3, 		
	C2 \== C5, C3 \== C4, C3 \== C5, C4 \== C5.
col(1).
col(2).
col(3).

colorier2(C1,C2,C3,C4,C5)
:- 	voisin(C1,C2), voisin(C1,C3), voisin(C1,C4), voisin(C2,C3),
	voisin(C2,C5), voisin(C3,C4), voisin(C3,C5), voisin(C4,C5).
voisin(X,Y) :- col(X), col(Y), X \== Y.
% col(1).
% col(2).
% col(3).

:-use_module(library('clp/bounds')).
color(L,N) :- 
	L=[C1,C2,C3,C4,C5], 
	L in 1..N,
	C1#\=C2, C1#\=C3, C1#\=C4, C2#\=C3, 
	C2#\=C5, C3#\=C4, C3#\=C5, C4#\=C5, 
	label(L).
