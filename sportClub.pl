% Student exercise profile
:- set_prolog_flag(occurs_check, error).        % disallow cyclic terms
:- set_prolog_stack(global, limit(8 000 000)).  % limit term space (8Mb)
:- set_prolog_stack(local,  limit(2 000 000)).  % limit environment space

% Your program goes here
% 
% 
% 
% 
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
    	% 
    	pos(Arthur), pos(Bart),pos(Colleen),pos(Dona),pos(Eva),pos(Frank),
    	%restrict the values that wont happen
    	not(Frank==2), not(Frank==3), not(Frank==4),
    	not(Bart==2),not(Bart==4),
    	not(Arthur==2), 
    	not((not(Eva==0),not(Bart==0),not(Arthur==0))),
    	not((not(Donna==0),not(Frank==0))), not((not(Donna==0), not(Frank==0))),
    	not((not(Colleen==0),not(Bart==0),Frank==0)),
   		% add the conditi
   	
		% true if bart and arthur are 0 or bart and arthur are numbers, or arthur is 0 and 
		% bart is a number.
    
    	% make sure 2 numbers are 0 and 1,2,3,4 are the rest. abuse finite domain.
    	count(0,[Arthur,Bart,Colleen,Dona,Eva,Frank],No_Job), No_Job==2,
    	count(1,[Arthur,Bart,Colleen,Dona,Eva,Frank],Prez), Prez==1,
    	count(2,[Arthur,Bart,Colleen,Dona,Eva,Frank],Vice), Vice==1,
    	count(3,[Arthur,Bart,Colleen,Dona,Eva,Frank],Tres), Tres==1,
    	count(4,[Arthur,Bart,Colleen,Dona,Eva,Frank],Sec), Sec==1.
    	%Let us constrain the comain further
    	
  
 
incompatible(Bart,Arthur):-not(   (Bart==0, Arthur==0))
