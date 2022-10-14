%cinematica directa
%el recibe el valor de las articulaciones q1,q2,q3,q4,q5 y devuelve las
%matrices A01,A12,A23,A34,A45,A05
function [A01,A12,A23,A34,A45,A05]=cinematica_directa(q)
L1=163.79;
L2=16.5;
L3A=32.5;
L3=130;
L4=135;
L5=117.6;


%Tabla de parametros de D_H
theta_dh = [q(1)+ pi/2, q(2), q(3)+pi/2, q(4)+pi,q(5)+pi/2];
d_dh     = [        L1,  -L2,         0,      L4,        0];
a_dh     = [       L3A,   L3,         0,       0,       L5];
alpha_dh = [      pi/2,    0,      pi/2,    pi/2,        0];

Am0 =eye(4);
%generacion de matrices homogeneas de los sistemas
A01 = dh(theta_dh(1), d_dh(1), a_dh(1), alpha_dh(1));% Sistema 1 respecto a 0
A12 = dh(theta_dh(2), d_dh(2), a_dh(2), alpha_dh(2));
A23 = dh(theta_dh(3), d_dh(3), a_dh(3), alpha_dh(3));
A34 = dh(theta_dh(4), d_dh(4), a_dh(4), alpha_dh(4));
A45 = dh(theta_dh(5), d_dh(5), a_dh(5), alpha_dh(5));

Am1 = Am0*A01;
Am2 = Am1*A12;
Am3 = Am2*A23;
Am4 = Am3*A34;
A05 = Am4*A45;

end
