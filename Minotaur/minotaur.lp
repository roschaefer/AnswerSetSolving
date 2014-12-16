%%%%            %%%%
%%%% Generation %%%%
%%%%            %%%%

% the first position is the start position
at(X,Y,0) :- start(X,Y).
{ at(X,Y,1..(S)) : field(X,Y) } S  :- maxsteps(S).



%%%%                    %%%%
%%%% Theseus' behaviour %%%%
%%%% Constraint based   %%%%
%%%%                    %%%%

% no duplicate step numbers
:- at(X1,Y1,N1), at(X2,Y2,N2), (X1,Y1) != (X2,Y2), N1 == N2.
% every step needs a predecessor
:- at(_,_,N), N!=0, not at(_,_,N-1).

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



%%%                               %%%
%%% Solution specific constraints %%%
%%%                               %%%

% the last step must reach the goal!
:- at(X,Y,S), not at(_,_,S+1), not goal(X,Y).
% just one step can reach the goal
:- at(X,Y,S1), at(X,Y,S2), S1!=S2, goal(X,Y).

% the minotaur must not eat us!
:- mino_at(X,Y,N), at(X,Y,N).



%%%%                      %%%%
%%%% Minotaur's behaviour %%%%
%%%%                      %%%%

% minotaur starts in the mino(...) start position
mino_at(X,Y,0) :- mino(X,Y).

can(left,N+1)  :- mino_at(X,Y,N), not wall(X-1,Y,X,Y).
can(right,N+1) :- mino_at(X,Y,N), not wall(X,Y,X+1,Y).
can(up,N+1)    :- mino_at(X,Y,N), not wall(X,Y-1,X,Y).
can(down,N+1)  :- mino_at(X,Y,N), not wall(X,Y,X,Y+1).

want(left,N+1)  :- mino_at(MX,_,N),  at(TX,_,N+1), MX>TX.
want(right,N+1) :- mino_at(MX,_,N),  at(TX,_,N+1), MX<TX.
want(up,N+1)    :- mino_at(_,MY,N),  at(_,TY,N+1), MY>TY.
want(down,N+1)  :- mino_at(_,MY,N),  at(_,TY,N+1), MY<TY.
want(none,N+1)  :- mino_at(MX,MY,N), at(TX,TY,N+1), (MX,MY) == (TX,TY).

% auxiliary method to reduce code duplication
no_horizontal_movement(N):- want(left,N),  not can(left,N).
no_horizontal_movement(N):- want(right,N), not can(right,N).
no_horizontal_movement(N):- want(up,N), not want(left,N), not want(right,N).
no_horizontal_movement(N):- want(down,N), not want(left,N), not want(right,N).

going(left,N)  :- want(left,N),     can (left,N).
going(right,N) :- want(right,N),    can (right,N).
going(up,N)    :- want(up,N),       can (up,N),   no_horizontal_movement(N).
going(down,N)  :- want(down,N),     can (down,N), no_horizontal_movement(N).
going(none,N)  :- want(up,N),   not can (up,N),   no_horizontal_movement(N).
going(none,N)  :- want(down,N), not can (down,N), no_horizontal_movement(N).
going(none,N)  :- want(none,N).

mino_at(X,Y,N+1)  :- mino_at(X,Y,N), going(none,N+1).
mino_at(X-1,Y,N+1):- mino_at(X,Y,N), going(left,N+1).
mino_at(X+1,Y,N+1):- mino_at(X,Y,N), going(right,N+1).
mino_at(X,Y-1,N+1):- mino_at(X,Y,N), going(up,N+1).
mino_at(X,Y+1,N+1):- mino_at(X,Y,N), going(down,N+1).



#show at/3.
#show mino_at/3.
