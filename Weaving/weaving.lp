paint(A,N,C,S) :- painted(A,N,C,S).

axis(x). axis(y).
index(1..D) :- dim(D).
nstep(1..K) :- steps(K).

K { paint(A,N,C,S) : axis(A), index(N), color(C), nstep(S) } K :- steps(K).

% every row/column has to be painted only once
:- paint(A1,N1,C1,S1), paint(A2,N2,C2,S2), (A1,N1,C1,S1) != (A2,N2,C2,S2), (A1,N1) == (A2,N2).

#show paint/4.

