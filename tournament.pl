%  @filename tournament.pl 
%  @author Nicholas Bell 500755674
%  @author Sean Lee 500758076
			/*PROLOG SESSION AT THE END OF FILE*/
  outcome(-1).
  outcome(0).
  outcome(1).
  outcome(2).

% -1 == did not participate
% 0 == loss
% 1 == draw
% 2 == win
  solve( [ [O1,O2,O3,O4,O5], [P1,P2,P3,P4,P5], [R1,R2,R3,R4,R5], [S1,S2,S3,S4,S5], [T1,T2,T3,T4,T5] ] ) :- 
	outcome(O1), outcome(P1), outcome(R1), outcome(S1), outcome(T1), %assign round 1

	P1 = 0, S1 = 2, %1/2 of rule 1
	f3R([O1,P1,R1,S1,T1]), %part of basic rules, but also enforces rule 6
	
	outcome(O2), outcome(P2), outcome(R2), outcome(S2), outcome(T2), %assign round 2
	
	P2 = 2, O2 = 0, %2/2 of rule 1
	f3R([O2,P2,R2,S2,T2]), %part of basic rules, but also enforces rule 6

	outcome(O3), outcome(P3), outcome(R3), outcome(S3), outcome(T3), %assign round 3

	T3 = -1, oneWin([T1,T2]), oneLoss([T1,T2]), %rule 2
	oneWin([R1,R2,R3]), oneLoss([R1,R2,R3]), onePass([R1,R2,R3]), %rule 5
	f3R([O3,P3,R3,S3,T3]), %part of basic rules, but also enforces rule 6
	
	outcome(O4), outcome(P4), outcome(R4), outcome(S4), outcome(T4), %assign round 4
	
	O4 =  -1, twoWins([O1,O2,O3]), %rule 3
	l2R([O4,P4,R4,S4,T4]), %part of basic rules, but also enforces rule 4

	outcome(O5), outcome(P5), outcome(R5), outcome(S5), outcome(T5), %assign round 5

	l2R([O5,P5,R5,S5,T5]), %part of basic rules, but also enforces rule 4
	
	%the following rules are so that each team only passes once
	onePass([O1,O2,O3,O4,O5]),
	onePass([P1,P2,P3,P4,P5]),
	onePass([R1,R2,R3,R4,R5]),
	onePass([S1,S2,S3,S4,S5]),
	onePass([T1,T2,T3,T4,T5]).



%counts whatever X is in the list and returns it in N
count(_, [], 0) :- !. 
count(X, [X|T], N) :- /* if X is in the head of the list */
    count(X, T, N2), /* count on the tail (let this N2) */
    N is N2 + 1.     /* and N is N2 + 1  */
count(X, [Y|T], N) :- 
    X \= Y,          /* if X is not in the head */
    count(X, T, N).  /* just count the rest */

%counts number of passes, and makes sure that theres only 1 (used for making sure a team only passes once
%enforces part of rule 5
onePass(Round):- count(-1,Round,N), N==1.
%makes sure there are 2 wins and 2 losses to match up, and only one pass per round (no ties in the first 3 rounds according to rule 6 -> hence name f(irst)3R(ounds)
%enforces rule 6
f3R(Round):- count(-1,Round,N0), N0==1, count(2,Round,N1), N1==2, count(0,Round,N2), N2==2.
%makes sure theres 4 ties and 1 pass (according to rule 4)
%enforces rule 4
l2R(Round):- count(-1,Round,N0), N0==1, count(1,Round,N1), N1==4.
%makes sure theres one win
%enforces part of rules 2 & 5
oneWin(Round):- count(2,Round,N), N==1.
%makes sure theres only one loss
%enforces part of rules 2 & 5
oneLoss(Round):- count(0,Round,N), N==1.
%makes sure theres two wins
%enforces rule 3
twoWins(Round):- count(2,Round,N), N==2.


addTotal([],N) :- N = 0.
addTotal([H|T],N):- H \= -1->notNegOne([H|T],N); addTotal(T,N).
notNegOne([H|T],N) :- addTotal(T,N1), N is N1+H.


% required predicate to print solution:
print_solution([ [O1,O2,O3,O4,O5], [P1,P2,P3,P4,P5], [R1,R2,R3,R4,R5], [S1,S2,S3,S4,S5], [T1,T2,T3,T4,T5] ]) :- 
	solve([ [O1,O2,O3,O4,O5], [P1,P2,P3,P4,P5], [R1,R2,R3,R4,R5], [S1,S2,S3,S4,S5], [T1,T2,T3,T4,T5] ]),
	addTotal([O1,O2,O3,O4,O5],OT),
	addTotal([P1,P2,P3,P4,P5],PT),
	addTotal([R1,R2,R3,R4,R5],RT),
	addTotal([S1,S2,S3,S4,S5],ST),
	addTotal([T1,T2,T3,T4,T5],TT),
	write("            round1     round2    round3   round4   round5     total"),
	nl,
	write("---------------------------------------------------------------------"),
	nl,
	write("Oakville       "), 
	write(O1), write("         "), 
	write(O2), write("         "), 
	write(O3), write("        "), 
	write(O4), write("        "), 
	write(O5), write("        "), 
	write(OT),
	nl,
	write("Pickering      "), 
	write(P1), write("         "), 
	write(P2), write("         "), 
	write(P3), write("        "), 
	write(P4), write("        "), 
	write(P5), write("        "), 
	write(PT),
	nl,
	write("RichmHill      "), 
	write(R1), write("         "), 
	write(R2), write("         "), 
	write(R3), write("        "), 
	write(R4), write("        "), 
	write(R5), write("        "), 
	write(RT),
	nl,
	write("Scarboro       "), 
	write(S1), write("         "), 
	write(S2), write("         "), 
	write(S3), write("        "), 
	write(S4), write("        "), 
	write(S5), write("        "), 
	write(ST),
	nl,
	write("Toronto        "), 
	write(T1), write("         "), 
	write(T2), write("         "), 
	write(T3), write("        "), 
	write(T4), write("        "), 
	write(T5), write("        "), 
	write(TT),
	nl,
	write("---------------------------------------------------------------------").
/**
* Prolog session: 
* [tournament].
* tournament.pl compiled 27640 bytes in 0.01 seconds
*
* Yes (0.01s cpu)
* [eclipse 139]: print_solution(X).
*             round1     round2    round3   round4   round5     total
* ---------------------------------------------------------------------
* Oakville       2         0         2        -1        1        5
* Pickering      0         2         0        1        -1        3
* RichmHill      -1         0         2        1        1        4
* Scarboro       2         -1         0        1        1        4
* Toronto        0         2         -1        1        1        4
* ---------------------------------------------------------------------
* X = [[2, 0, 2, -1, 1], [0, 2, 0, 1, -1], [-1, 0, 2, 1, 1], [2, -1, 0, 1, 1], [0, 2, -1, 1, 1]]
* Yes (0.01s cpu, solution 1, maybe more) ? ;
*
* No (0.01s cpu)
*/

