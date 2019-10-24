%  @filename tournament.pl 
%  @author Nicholas Bell 500755674
%  @author Sean Lee 500758076

  outcome(-1).
  outcome(0).
  outcome(1).
  outcome(2).

% teamResults: Round1, Round2, Round3, Round4, Round5 (total can be added up?)
% round(O,P,R,S,T)
% -1 == did not participate
% 0 == loss
% 1 == draw
% 2 == win
% required predicate to solve:  
  solve( [ [O1,O2,O3,O4,O5], [P1,P2,P3,P4,P5], [R1,R2,R3,R4,R5], [S1,S2,S3,S4,S5], [T1,T2,T3,T4,T5] ] ) :- 
%assign 1
	outcome(O1), outcome(P1), outcome(R1), outcome(S1), outcome(T1),
	onePass([O1,P1,R1,S1,T1])/*,
%constrainst 1
	P1 = 0, S1 = 2, %first half of rule 1
%assign 2

	outcome(O2), outcome(P2), outcome(R2), outcome(S2), outcome(T2),
	onePass([O1,P1,R1,S1,T1]),
%constrainst 2
	P2 = 2, O2 = 0, %second half of rule 1
%assign 3
	outcome(O3), outcome(P3), outcome(R3), outcome(S3), outcome(T3),
	onePass([O1,P1,R1,S1,T1]),
%constraints 3
	T3 = -1, count(1,1,X2,Y2,[T1,T2]), %rule 2
	count(1,1,X5,Y5,[R1,R2,R3]), %rule 5
%assign 4
	outcome(O4), outcome(P4), outcome(R4), outcome(S4), outcome(T4),
        onePass([O1,P1,R1,S1,T1]),
%constraints 4
	O4 =  -1, count(2,X3,Y3,Z3,[O1,O2,O3]), %rule 3
%assign 5
	outcome(O5), outcome(P5), outcome(R5), outcome(S5), outcome(T5),
        onePass([O1,P1,R1,S1,T1])
%constrainst 5
*/		  
	  .

seep([X,Y,Z]) :- outcome(X),outcome(Y),outcome(Z), Z = 1.
equal(A,A).

% helper to count w/l/d/dnp and return true if they meet w/l/d/dnp, else false
  count(Wins,Loss,Draw,DNP,Team) :-
	encounters(-1,Team,NP), NP = DNP, 
	encounters(2,Team,W), W = Wins,
	encounters(0,Team,L), L = Loss,
	encounters(1,Team,D), D = Draw.

onePass(Round) :- encounters(-1,Round,P), P = 1. %derivative helper method to make sure theres only one pass per round

/*
xmember(N,[N|L]).
xmember(N,[M|L]) :- xmember(N,L).
oneMember(N,[N|L]) := \+ not( xmember(N,L) ).
oneMember(N,[M|L]) := oneMember(N,L).
*/
encounters(_,[],Num) :- Num = 0.
encounters(X,[X|T],Num) :- encounters(X,T,Num1), Num is Num1+1.
encounters(X,[H|T],Num) :- encounters(X,T,Num).
addAll([T1,T2,T3,T4,T5],Total) :- Total is T1+T2+T3+T4+T5.
% required predicate to print solution:
print_solution([ [O1,O2,O3,O4,O5], [P1,P2,P3,P4,P5], [R1,R2,R3,R4,R5], [S1,S2,S3,S4,S5], [T1,T2,T3,T4,T5] ]) :- 
	solve([ [O1,O2,O3,O4,O5], [P1,P2,P3,P4,P5], [R1,R2,R3,R4,R5], [S1,S2,S3,S4,S5], [T1,T2,T3,T4,T5] ]),
	addAll([O1,O2,O3,O4,O5],OT),
	addAll([P1,P2,P3,P4,P5],PT),
	addAll([R1,R2,R3,R4,R5],RT),
	addAll([S1,S2,S3,S4,S5],ST),
	addAll([T1,T2,T3,T4,T5],TT),
	write("            round1     round2    round3   round4   round5   total"),
	nl,
	write("-------------------------------------------------------------------"),
	nl,
	write("Oakville        "), 
	write(O1), write("        "), 
	write(O2), write("       "), 
	write(O3), write("       "), 
	write(O4), write("       "), 
	write(O5), write("       "), 
	write(OT),
	nl,
	write("Pickering        "), 
	write(P1), write("        "), 
	write(P2), write("       "), 
	write(P3), write("       "), 
	write(P4), write("       "), 
	write(P5), write("       "), 
	write(PT),
	nl,
	write("RichmHill        "), 
	write(R1), write("        "), 
	write(R2), write("       "), 
	write(R3), write("       "), 
	write(R4), write("       "), 
	write(R5), write("       "), 
	write(RT),
	nl,
	write("Scarboro        "), 
	write(S1), write("        "), 
	write(S2), write("       "), 
	write(S3), write("       "), 
	write(S4), write("       "), 
	write(S5), write("       "), 
	write(ST),
	nl,
	write("Toronto        "), 
	write(T1), write("        "), 
	write(T2), write("       "), 
	write(T3), write("       "), 
	write(T4), write("       "), 
	write(T5), write("       "), 
	write(TT),
	nl,
	write("-------------------------------------------------------------------").

% suggested predicate by A3 sheet:
% true if X occurs exactly four times in [List] - useful for constraint 4!
  fourExactly(X,[List]).

% required predicate:
% print_solution([List]).
/**
* Needs to follow this format: 

"            round1     round2    round3   round4   round5   total
-------------------------------------------------------------------
Oakville        O1        O2       O3       O4       O5       OT
Pickering       P1        P2       P3       P4       P5       PT
RichmHill       R1        R2       R3       R4       R5       RT
Scarboro        S1        S2       S3       S4       S5       ST
Toronto         T1        T2       T3       T4       T5       TT
-------------------------------------------------------------------

*/


