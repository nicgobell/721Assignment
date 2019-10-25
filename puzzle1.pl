solve(Z) :-
    assign(Z,[0,1,2,3,4,5,6,7,8,9]),
    check(Z).


look(GET,G,E,T):- GET is G*100+E*10+T.
look2(VAL1,Y):- VAL1 is Y.
look3(VAL2,B):-VAL2 is B*10.
look4(BABE,B,A,B,E):- BABE is B*1000+A*100+B*10+E.

check([Y,G,E,T,B,A,_,_,_,_]) :- 
    G>=1,B>=1, look(GET,G,E,T), look2(VAL1,Y),
    look3(VAL2,B),look4(BABE,B,A,B,E), VAL1*GET=:=BABE, GET*10=:=VAL2*GET.
     
      







assign(Z,L) :-
    permute(L,Z).

/* permute is similar to all_different in swi-prolog */
addany(X,K,[X|K]).
addany(X,[F|K],[F|L1]) :-
    addany(X,K,L1).

permute([],[]).
permute([X|K],P) :- 
    permute(K,L1),
    addany(X,L1,P).
