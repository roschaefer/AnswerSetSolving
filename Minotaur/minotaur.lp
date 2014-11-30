

% the first position is the start position
at(X,Y,0) :- start(X,Y).
S+1 { at(X,Y,1..(S+1)) : field(X,Y) } S+1  :- maxsteps(S).

% we must reach the goal
:- goal(X,Y), not at(X,Y,_).

% no duplicate step numbers
:- at(X1,Y1,N1), at(X2,Y2,N2), (X1,Y1) != (X2,Y2), N1 == N2.

% we can't go diagonal
:- at(X1,Y1,N1), at(X2,Y2,N2), (N1+1) == N2, X1!=X2, Y1!=Y2.
% we can't go more than one field in x-direction
:- at(X1,Y1,N1), at(X2,Y2,N2), (N1+1) == N2, ((X1-X2) * (X1-X2)) > 1.
% we can't go more than one field in y-direction
:- at(X1,Y1,N1), at(X2,Y2,N2), (N1+1) == N2, ((Y1-Y2) * (Y1-Y2)) > 1.

% we can't go through a wall
:- wall(WX1, WY1, WX2, WY2), at(X1,Y1,N1), at(X2,Y2,N2), (N1+1) == N2, (WX1, WY1) == (X1, Y1), (WX2,WY2) == (X2,Y2).
% we can't go through a wall, not even in the other direction
:- wall(WX1, WY1, WX2, WY2), at(X1,Y1,N1), at(X2,Y2,N2), (N1+1) == N2, (WX1, WY1) == (X2, Y2), (WX2,WY2) == (X1,Y1).



#show at/3.
