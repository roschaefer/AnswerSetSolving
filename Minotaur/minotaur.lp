% the first position is the start position
at(X,Y,0) :- start(X,Y).
{ at(X,Y,1..(S+1)) : field(X,Y) } S+1  :- maxsteps(S).

% the last step must reach the goal!
:- at(X,Y,S), not at(_,_,S+1), not goal(X,Y).


move(X,Y,N,t) :- at(X,Y,N).

% the minotaur must not eat us!
:- move(X,Y,N,m), at(X,Y,N).

%%%%                      %%%%
%%%% Minotaur's behaviour %%%%
%%%%                      %%%%

% minotaur starts in the mino(...) start position
move(X,Y,0,m) :- mino(X,Y).

% theseus is ahead in horizontal direction and there is no wall
move(MX-1, MY, N, m) :- at(TX,TY,N), move(MX,MY,N-1,m), TX < MX, not wall(MX-1,MY,MX,MY).
move(MX+1, MY, N, m) :- at(TX,TY,N), move(MX,MY,N-1,m), TX > MX, not wall(MX,MY,MX+1,MY).
% theseus is ahead in horizontal direction and there is a wall
move(MX, MY, N, m) :- at(TX,TY,N), move(MX,MY,N-1,m), TX < MX, wall(MX-1,MY,MX,MY).
move(MX, MY, N, m) :- at(TX,TY,N), move(MX,MY,N-1,m), TX > MX, wall(MX,MY,MX+1,MY).

% theseus is ahead in vertical direction and there is no wall
move(MX, MY-1, N, m) :- at(TX,TY,N), move(MX,MY,N-1,m), TX == MX, TY < MY, not wall(MX,MY-1,MX,MY).
move(MX, MY+1, N, m) :- at(TX,TY,N), move(MX,MY,N-1,m), TX == MX, TY > MY, not wall(MX,MY,MX,MY+1).
% theseus is ahead in vertical direction and there is a wall
move(MX, MY, N, m) :- at(TX,TY,N), move(MX,MY,N-1,m), TX == MX, TY < MY, wall(MX,MY-1,MX,MY).
move(MX, MY, N, m) :- at(TX,TY,N), move(MX,MY,N-1,m), TX == MX, TY > MY, wall(MX,MY,MX,MY+1).



%%%%                      %%%%
%%%% Movement Constraints %%%%
%%%% P is a placeholder   %%%%

% no duplicate step numbers
:- move(X1,Y1,N1,P), move(X2,Y2,N2,P), (X1,Y1) != (X2,Y2), N1 == N2.
% every step needs a predecessor
:- move(_,_,N,P), N!=0, not move(_,_,N-1,P).

% we can't go diagonal
:- move(X1,Y1,N1,P), move(X2,Y2,N2,P), (N1+1) == N2, X1!=X2, Y1!=Y2.
% we can't go more than one field in x-direction
:- move(X1,Y1,N1,P), move(X2,Y2,N2,P), (N1+1) == N2, ((X1-X2) * (X1-X2)) > 1.
% we can't go more than one field in y-direction
:- move(X1,Y1,N1,P), move(X2,Y2,N2,P), (N1+1) == N2, ((Y1-Y2) * (Y1-Y2)) > 1.

% we can't go through a wall
:- wall(WX1, WY1, WX2, WY2), move(X1,Y1,N1,P), move(X2,Y2,N2,P), (N1+1) == N2, (WX1, WY1) == (X1, Y1), (WX2,WY2) == (X2,Y2).
% we can't go through a wall, not even in the other direction
:- wall(WX1, WY1, WX2, WY2), move(X1,Y1,N1,P), move(X2,Y2,N2,P), (N1+1) == N2, (WX1, WY1) == (X2, Y2), (WX2,WY2) == (X1,Y1).



#show at/3.
