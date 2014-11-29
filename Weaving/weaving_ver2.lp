%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
% File: weaving.lp                                                            %
%                                                                             %
% Name(s):                                                                    %
%                                                                             %
% At most two members are allowed per group                                   %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%
% Generate %
%%%%%%%%%%%%

1 { paint(x,N,C,1..S) : color(C), steps(S) } 1 :- N = 1..D, dim(D).
1 { paint(y,N,C,1..S) : color(C), steps(S) } 1 :- N = 1..D, dim(D).
1 { paint((x;y),N,C,S) : N = 1..D, dim(D), color(C)} 1 :- S = 1..L, steps(L).

paint(A,N,C,S) :- painted(A,N,C,S).

%%%%%%%%%%%%
% Test     %
%%%%%%%%%%%%


:- paint(x,NX,CX,SX), paint(y,NY,CY,SY), goal(NX,NY,C), SX > SY, C != CX.  
:- paint(x,NX,CX,SX), paint(y,NY,CY,SY), goal(NX,NY,C), SY > SX, C != CY.  


%%%%%%%%%%%%%%%%%%%%%%%%
% Display only paint/4 %
%%%%%%%%%%%%%%%%%%%%%%%%

#show paint/4.
