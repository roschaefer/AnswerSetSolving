

% the first position is the start position
at(X,Y,0) :- start(X,Y).
{ at(X,Y,1..(S+1)) : field(X,Y) } S+1  :- maxsteps(S).

% we must reach the goal
:- goal(X,Y), not at(X,Y,_).


move(X,Y,N,t) :- at(X,Y,N).

%%%%                      %%%%
%%%% Movement Constraints %%%%
%%%%                      %%%%

% no duplicate step numbers
:- move(X1,Y1,N1,_), move(X2,Y2,N2,_), (X1,Y1) != (X2,Y2), N1 == N2.
% every step needs a predecessor
:- move(_,_,N,_), N!=0, not move(_,_,N-1,_).

% we can't go diagonal
:- move(X1,Y1,N1,_), move(X2,Y2,N2,_), (N1+1) == N2, X1!=X2, Y1!=Y2.
% we can't go more than one field in x-direction
:- move(X1,Y1,N1,_), move(X2,Y2,N2,_), (N1+1) == N2, ((X1-X2) * (X1-X2)) > 1.
% we can't go more than one field in y-direction
:- move(X1,Y1,N1,_), move(X2,Y2,N2,_), (N1+1) == N2, ((Y1-Y2) * (Y1-Y2)) > 1.

% we can't go through a wall
:- wall(WX1, WY1, WX2, WY2), move(X1,Y1,N1,_), move(X2,Y2,N2,_), (N1+1) == N2, (WX1, WY1) == (X1, Y1), (WX2,WY2) == (X2,Y2).
% we can't go through a wall, not even in the other direction
:- wall(WX1, WY1, WX2, WY2), move(X1,Y1,N1,_), move(X2,Y2,N2,_), (N1+1) == N2, (WX1, WY1) == (X2, Y2), (WX2,WY2) == (X1,Y1).



#show at/3.
