paint(A,N,C,S) :- painted(A,N,C,S).

axis(x). axis(y).
index(1..D) :- dim(D).
nstep(1..K) :- steps(K).

K { paint(A,N,C,S) : axis(A), index(N), color(C), nstep(S) } K :- steps(K).

% integrity constraint: every row/column has to be painted only once
:- paint(A1,N1,C1,S1), paint(A2,N2,C2,S2), (A1,N1,C1,S1) != (A2,N2,C2,S2), (A1,N1) == (A2,N2).

% integrity constraint: if a cell has a goal color, the cell must be colored respectively
:- goal(X,Y,C), not colored(X,Y,C).

% integrity constraint (to be optimized!): every step has to occur once
:- paint(A1,N1,C1,S1), paint(A2,N2,C2,S2), (A1,N1,C1,S1) != (A2,N2,C2,S2), S1==S2.



colored(X,Y,C) :- paint(x,X,C,S1), paint(y,Y,_,S2), S1>S2.
colored(X,Y,C) :- paint(y,Y,C,S1), paint(x,X,_,S2), S1>S2.


#show paint/4.

