row(1..9).
col(1..9).
val(1..9).

sudoku(X,Y,N) :- initial(X,Y,N).

9*9 {sudoku(X,Y,N) : row(X), col(Y), val(N)} 9*9


:- sudoku(X,Y,I), sudoku(X,Y,J), I != J.
:- sudoku(X,Y1,N), sudoku(X,Y2,N), Y1 != Y2.
:- sudoku(X1,Y,N), sudoku(X2,Y,N), X1 != X2.
:- sudoku(X1,Y1,N), sudoku(X2,Y2,N), Y1!=Y2, ((X1-1)/3) == ((X2 - 1)/3), ((Y1 - 1)/3) == ((Y2 - 1)/3).
:- sudoku(X1,Y1,N), sudoku(X2,Y2,N), X1!=X2, ((X1-1)/3) == ((X2 - 1)/3), ((Y1 - 1)/3) == ((Y2 - 1)/3).


#show sudoku/3.
