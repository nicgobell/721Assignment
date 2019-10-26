%This question is incomplete and has been split in to two solutions.

%solution one is a solution to the following...
%GET
%*
%BY
%BABE
%+
%GET*10

%This solution can be found using the following query... ?-solve([Y,G,E,T,B,A,_,_,_,_]).

solve(Z) :-
    set(Z,[0,1,2,3,4,5,6,7,8,9]),
    check(Z).
    
look(GET,G,E,T):- GET is G*100+E*10+T.
look2(VAL1,Y):- VAL1 is Y.
look3(VAL2,B):-VAL2 is B*10.
look4(BABE,B,A,B,E):- BABE is B*1000+A*100+B*10+E.

check([Y,G,E,T,B,A,_,_,_,_]) :- 
    G>=1,B>=1, look(GET,G,E,T), look2(VAL1,Y),
    look3(VAL2,B),look4(BABE,B,A,B,E), VAL1*GET=:=BABE, GET*10=:=VAL2*GET.

%helpers
set(Z,L) :-
    combo(L,Z).
add(X,K,[X|K]).
add(X,[F|K],[F|L1]) :-
    add(X,K,L1).
combo([],[]).
combo([X|K],P) :- 
    combo(K,L1),
    add(X,L1,P).
%The query returns...
%A = 4,B = 1,E = 0,G = 7,T = 5,Y = 2. Which IS a solution to EQ 1.

%Problem 2 is BABE+GET*10=BEARE.
%query with check2([B,A,E,G,T,R]).


all_diff([]).
all_diff([N|L]):-not(member(N,L)), all_diff(L).

dig(0). dig(1). dig(2). dig(3). dig(4). dig(5). dig(6). dig(7). dig(8). dig(9).




check2([B,A,E,G,T,R]) :-
    dig(B), B>0,
    dig(G),G>0,
    dig(A),dig(T),dig(R),dig(E),
    
   	E is (T*10+E)mod(10), C1 is (T*10+E)//10,
    R is (E*10+B+C1)mod(10), C10 is (E*10+B+C1)//10,
    A is (G*10+A+C10)mod(10), C100 is (G*10+A+C10)//10,
    E is (G*10+B+C100)mod(10), B is (G+B+C100)//10,
 
    all_diff([B,A,E,G,T,R]).

% The output of this query is
%A = 2,B = 1,E = 0,G = 9,R = 4,T = 3
%Which is a solution to the given equation, just not the same numbers as is solution 1.


%both functions use smart interleaving and return in less than 3 seconds.
