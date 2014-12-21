%%%%            %%%%
%%%% Generation %%%%
%%%%            %%%%
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
:- at(X,Y,S1), at(X,Y,S2), goal(X,Y), S1<S2.
:- at(X1,Y1,S), at(X2,Y2,S+1), not go(theseus,X1,Y1,X2,Y2,S+1).


#minimize{1,S: at(_,_,S)}.


% the minotaur must not eat us!
:- mino_at(X,Y,2*N), at(X,Y,N).


%%%%                      %%%%
%%%% Minotaur's behaviour %%%%
%%%%                      %%%%

% minotaur starts in the mino(...) start position
mino_at(X,Y,0) :- mino(X,Y).

% where is theseus in the current mino-step?
doubled_theseus(X,Y,2*N) :- at(X,Y,N).
doubled_theseus(X,Y,2*N-1) :- at(X,Y,N), N !=0.

can(left,N+1)  :- mino_at(X,Y,N), not wall(X-1,Y,X,Y).
can(right,N+1) :- mino_at(X,Y,N), not wall(X,Y,X+1,Y).
can(up,N+1)    :- mino_at(X,Y,N), not wall(X,Y-1,X,Y).
can(down,N+1)  :- mino_at(X,Y,N), not wall(X,Y,X,Y+1).

want(left,N+1)  :- mino_at(MX,_,N),  doubled_theseus(TX,_,N+1), MX>TX.
want(right,N+1) :- mino_at(MX,_,N),  doubled_theseus(TX,_,N+1), MX<TX.
want(up,N+1)    :- mino_at(_,MY,N),  doubled_theseus(_,TY,N+1), MY>TY.
want(down,N+1)  :- mino_at(_,MY,N),  doubled_theseus(_,TY,N+1), MY<TY.
want(none,N+1)  :- mino_at(MX,MY,N), doubled_theseus(TX,TY,N+1), (MX,MY) == (TX,TY).

% auxiliary method to reduce code duplication
no_horizontal_movement(N):- want(left,N),  not can(left,N).
no_horizontal_movement(N):- want(right,N), not can(right,N).
no_horizontal_movement(N):- want(up,N), not want(left,N), not want(right,N).
no_horizontal_movement(N):- want(down,N), not want(left,N), not want(right,N).


no_vertical_movement(N):- want(up, N), not can(up, N).
no_vertical_movement(N):- want(down, N), not can(down, N).
no_vertical_movement(N):- want(left,N), not want(up, N), not want(down, N).
no_vertical_movement(N):- want(right,N), not want(up, N), not want(down, N).

going(left,N)  :- want(left,N),     can (left,N).
going(right,N) :- want(right,N),    can (right,N).
going(up,N)    :- want(up,N),       can (up,N),   no_horizontal_movement(N).
going(down,N)  :- want(down,N),     can (down,N), no_horizontal_movement(N).
going(none,N)  :- want(up,N),   not can (up,N),   no_horizontal_movement(N).
going(none,N)  :- want(down,N), not can (down,N), no_horizontal_movement(N).
going(none,N)  :- want(left,N),   not can (left,N), no_vertical_movement(N).
going(none,N)  :- want(right,N),  not can (right,N), no_vertical_movement(N).
going(none,N)  :- want(none,N).

mino_at(X,Y,N+1)  :- field(X,Y),   N < 2*(S+1), maxsteps(S), mino_at(X,Y,N), going(none,N+1).
mino_at(X-1,Y,N+1):- field(X-1,Y), N < 2*(S+1), maxsteps(S), mino_at(X,Y,N), going(left,N+1).
mino_at(X+1,Y,N+1):- field(X+1,Y), N < 2*(S+1), maxsteps(S), mino_at(X,Y,N), going(right,N+1).
mino_at(X,Y-1,N+1):- field(X,Y-1), N < 2*(S+1), maxsteps(S), mino_at(X,Y,N), going(up,N+1).
mino_at(X,Y+1,N+1):- field(X,Y+1), N < 2*(S+1), maxsteps(S), mino_at(X,Y,N), going(down,N+1).


#show at/3.

