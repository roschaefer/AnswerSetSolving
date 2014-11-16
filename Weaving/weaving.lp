paint(A,N,C,S) :- painted(A,N,C,S).

axis(x). axis(y).
index(1..D) :- dim(D).
nstep(1..K) :- steps(K).

K { paint(A,N,C,S) : axis(A), index(N), color(C), nstep(S) } K :- steps(K).



#show paint/4.

