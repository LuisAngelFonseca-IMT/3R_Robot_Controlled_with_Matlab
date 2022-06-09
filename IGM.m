% parametros DH para un 6R, simbolicos
syms D1 L1 L2 L3 L4 L6 real
syms q1 q2 q3 q4 q5 q6 real
pi = sym(pi); 
clear all
close all
D1 = 5
DH.sigma =  [0 0 1].';
DH.a =      [0 0 0].';
DH.alpha =  [pi/2 pi/2 0].';
DH.d =      [D1 0 0].';
DH.theta =  [0 0 0].';
% DH.theta =  [q1 q2 q3 q4 q5 q6].';
q = rand(3,1);
[T0Tn, T] = DGM2(DH, q);
P=T0Tn{end}(:,4);
q_calc = ejemplo_IGM_esferico(P);
[T0Tn_calc, T] = DGM(DH, q_calc);
P-T0Tn_calc{end}(:,4)
syms S6X S6Y S6Z N6X N6Y N6Z A6X A6Y A6Z P6X P6Y P6Z real
%Metodo de Paul
U6=[S6X N6X A6X P6X; S6Y N6Y A6Y P6Y; S6Z, N6Z, A6Z, P6Z; 0 0 0 1];
return
simplify(inv(T{1})*U6*[0 0 0 1]')
simplify(inv(T{1})*T0Tn{end}*[0 0 0 1]')