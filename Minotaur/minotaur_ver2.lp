%%%%%%%%%%%%%%%%%%%%%%%%%
% Generation
%%%%%%%%%%%%%%%%%%%%%%%%%

% initial position 
go(theseus,X,Y,X,Y,0) :- start(X,Y).

% go right if not already achieved goal field
go(theseus,X,Y,X+1,Y,S+1) :- go(theseus,_,_,X,Y,S), right(X,Y), S < LS+1, maxsteps(LS), not goal(X,Y).

% go left if not already achieved goal field
go(theseus,X,Y,X-1,Y,S+1) :- go(theseus,_,_,X,Y,S), left(X,Y), S < LS+1, maxsteps(LS), not goal(X,Y).

% go up if not already achieved goal field
go(theseus,X,Y,X,Y+1,S+1) :- go(theseus,_,_,X,Y,S), up(X,Y), S < LS+1, maxsteps(LS), not goal(X,Y).

% go down if not already achieved goal field
go(theseus,X,Y,X,Y-1,S+1) :- go(theseus,_,_,X,Y,S), down(X,Y), S < LS+1, maxsteps(LS), not goal(X,Y).

% stay on field 
go(theseus,X,Y,X,Y,S+1) :- go(theseus,_,_,X,Y,S), S < LS+1, maxsteps(LS), not goal(X,Y).




% it is possible to move from field (X,Y) left/right/up/down
right(X,Y):- field(X,Y), field(X+1,Y), not wall(X,Y,X+1,Y).
left(X,Y):- field(X,Y), field(X-1,Y), not wall(X-1,Y,X,Y).
up(X,Y):- field(X,Y), field(X,Y+1), not wall(X,Y,X,Y+1).
down(X,Y):- field(X,Y), field(X,Y-1), not wall(X,Y-1,X,Y).


at(X,Y,0) :- start(X,Y).
{ at(X,Y,S) : go(theseus,_,_,X,Y,S) } 1 :- S = 1..LS+1, maxsteps(LS).

%%%%%%%%%%%%%%%%%%%%%%%%%
% Testing
%%%%%%%%%%%%%%%%%%%%%%%%%

:- at(X1,Y1,S), not goal(X1,Y1), not at(_,_,S+1).
:- at(X,Y,S1), at(X,Y,S2), goal(X,Y), S1!=S2.
:- at(X1,Y1,S), at(X2,Y2,S+1), not go(theseus,X1,Y1,X2,Y2,S+1).


#minimize{1,S:at(_,_,S)}.


#show at/3.











