% funcion que calcula la cinematica inversa de un robot antropomorfico de 4
%  GDL, para una aplicacion de paletización.
% 
% A05=[0.0000   -0.0000    1.0000  -13.5000
%      1.0000    0.0000   -0.0000  430.7800
%     -0.0000    1.0000    0.0000  170.8100
%          0         0         0    1.0000];

function q=cinematica_inversa_matrizA(A05,CODO)

L1=163.79;
L2=16.5;
L3A=32.5;
L3=130;
L4=135;
L5=117.6;
px5=A05(1,4);
py5=A05(2,4);
pz5=A05(3,4);
p5=A05(1:3,4);
x5=A05(1:3,1);
y5=A05(1:3,2);
z5=A05(1:3,3);
%punto de la muñeca
pm=p5-(L5*x5);
pmx=pm(1);
pmy=pm(2);
pmz=pm(3);
m=sqrt((pmy^2)+(pmx^2));
D=sqrt((m^2)-(L2^2));
beta1=atan2(L2,D);
alpha1=atan2(-pmx,pmy);
q1=alpha1-beta1;
J=sqrt(((D-L3A)^2)+((pmz-L1)^2));
cosq3=((J^2)-(L3^2)-(L4^2))/(2*L3*L4);
senq3=CODO*sqrt(1-(cosq3^2));
q3=atan2(senq3,cosq3);
beta2=atan2((L4*senq3),(L3+L4*cosq3));
alpha2=atan2((pmz-L1),(D-L3A));
q2=alpha2-beta2;
[A01,A12,A23]=cinematica_directa([q1,q2,q3,0,0]);
A03=A01*A12*A23;
x3=A03(1:3,1);
y3=A03(1:3,2);
z4=z5;
cosq4=dot(z4,y3);%producto punto
senq4=-dot(z4,x3);
q4=atan2(senq4,cosq4);
[A01,A12,A23,A34]=cinematica_directa([q1,q2,q3,q4,0]);
A04=A01*A12*A23*A34;
my4=sqrt(A04(1,2)^2+A04(2,2)^2+A04(3,2)^2);
mx4=sqrt(A04(1,1)^2+A04(2,1)^2+A04(3,1)^2);
mx5=sqrt(A05(1,1)^2+A05(2,1)^2+A05(3,1)^2);
x4=A04(1:3,1);
y4=A04(1:3,2);
cosq5=(dot(x5,y4))/(mx5*my4);
senq5=(-dot(x5,x4))/(mx5*mx4);
q5=atan2(senq5,cosq5);


% q1=round(q1,6);
% q2=round(q2,6);
% q3=round(q3,6);
% q4=round(q4,6);
% q5=round(q5,6);
q=[q1,q2,q3,q4,q5];


end