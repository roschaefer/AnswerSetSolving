paint(X,N,C,S) :- painted(X,N,C,S).

D { paint(x,N,C,1..K) } D :- dim(D), steps(K), N=1..D, color(C).
D { paint(y,N,C,1..K) } D :- dim(D), steps(K), N=1..D, color(C).


#show paint/4.

