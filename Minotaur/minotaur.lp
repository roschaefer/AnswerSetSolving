
% auxiliary functions
nstep(0..(S+1)) :- maxsteps(S).

S+1 { at(X,Y,N) : field(X,Y), nstep(N) } S+1  :- maxsteps(S).

% the first position is the start position
at(X,Y,0) :- start(X,Y).

% we must reach the goal
:- goal(X,Y), not at(X,Y,_).







#show at/3.
