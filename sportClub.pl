count(_, [], 0) :- !. /* empty list, base case */
count(X, [X|T], N) :- /* if X is in the head of the list */
    count(X, T, N2), /* count on the tail (let this N2) */
    N is N2 + 1.     /* and N is N2 + 1  */
count(X, [Y|T], N) :- 
    X \= Y,          /* if X is not in the head */
    count(X, T, N).  /* just count the rest */

pos(0). %nothing
pos(1). %prez
pos(2). %vice-prez
pos(3). %tres
pos(4). %sec

elect([Arthur,Bart,Colleen,Dona,Eva,Frank]):-
    	% assign each person a number.
    	 
    	pos(Arthur), pos(Bart), pos(Colleen), pos(Dona), pos(Eva), pos(Frank),
    	%restrict the values that wont happen
    	Arthur \= 2, %rule 1 (1/2)
    Frank \= 4, Frank \=2, 
	Bart \= 2, Bart \= 4, %rule 2
	rule1(Bart, Arthur), %rule 1 (2/2)
    rule6(Frank, Colleen),
	rule3(Bart, Frank, Colleen), 
	rule4(Dona, Eva, Frank), 
	rule5(Eva, Arthur, Bart),
% make sure 2 numbers are 0 and 1,2,3,4 are the rest. abuse finite domain.
        count(0,[Arthur,Bart,Colleen,Dona,Eva,Frank],No_Job), No_Job==2,
        count(1,[Arthur,Bart,Colleen,Dona,Eva,Frank],Prez), Prez==1,
        count(2,[Arthur,Bart,Colleen,Dona,Eva,Frank],Vice), Vice==1,
        count(3,[Arthur,Bart,Colleen,Dona,Eva,Frank],Tres), Tres==1,
        count(4,[Arthur,Bart,Colleen,Dona,Eva,Frank],Sec), Sec==1.
        %Let us constrain the comain further

all_diff([]).
all_diff([N|L]) :- not( member(N,L) ), all_diff(L).




rule1(0,0).
rule1(B,A) :- B \= 0, A \= 0.

rule3(B,0,0) :- B \= 0.
rule3(B,F,C) :- B \= 0, F \= 0, C \= 0.
rule3(0,F,C).

rule4(0,E,F) :- F \= 0.
rule4(0,E,F) :- E \= 0.
rule4(D,0,0) :- D \= 0.

rule5(E,0,0).
rule5(0,A,B) :- A \= 0, B \= 0.

%rule6(1,C) :- C \= 2.
%rule6(F,C) :- F \= 1.
%rule6(Y,X):-Y==1,not(X==2).
%rule6(Y,X):-Y==0.
rule6(F,C):-F\=1.
rule6(1,C):-C==0.
