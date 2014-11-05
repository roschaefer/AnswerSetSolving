initial(1,2,4).
initial(1,3,2).
initial(2,1,2).
initial(3,4,3).
initial(4,3,3). %initial(4,2,3).
initial(4,2,1). %initial(4,3,1).

row(1..n).
col(1..n).
val(1..n).



sudoku(X,Y,N) :- initial(X,Y,N).

{sudoku(X,Y,N) : row(X), col(Y), val(N)}.

:- sudoku(X,Y,I), sudoku(X,Y,J), I != J.
:- not n*n { sudoku(X,Y,N)}.


:- sudoku(X,Y1,N), sudoku(X,Y2,N), Y1 != Y2.
:- sudoku(X1,Y,N), sudoku(X2,Y,N), X1 != X2.
:- sudoku(X1,Y1,N), sudoku(X2,Y2,N), (div((X1-1),2) == div((X2 - 1),2)), (div((Y1 - 1),2) == div((Y2 - 1),2) ).

#show sudoku/3.
