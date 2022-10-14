% funcion que calcula la cinematica inversa de un robot antropomorfico de 4
% GDL, para una aplicacion de paletización.

function q=cinematica_inversa_punto1(pf,CODO,Angulo)

L1=163.79;
L2=16.5;
L3A=32.5;
L3=130;
L4=135;
L5=117.6;
%punto de la muñeca
px5=pf(1);
py5=pf(2);
mb=sqrt((py5^2)+(px5^2));
Db=sqrt((mb^2)-(L2^2));
beta1=atan2(L2,Db);
alpha1=atan2(-px5,py5);
q1=alpha1-beta1;

x5=[-cos(Angulo)*sin(q1), cos(Angulo)*cos(q1), sin(Angulo)];
pm=pf-x5*L5;
px=pm(1);
py=pm(2);
pz=pm(3);
m=sqrt((py^2)+(px^2));
D=sqrt((m^2)-(L2^2));

J=sqrt(((D-L3A)^2)+((pz-L1)^2));
cosq3=((J^2)-(L3^2)-(L4^2))/(2*L3*L4);
senq3=CODO*sqrt(1-(cosq3^2));
q3=atan2(senq3,cosq3);
beta2=atan2((L4*senq3),(L3+L4*cosq3));
alpha2=atan2((pz-L1),(D-L3A));
q2=alpha2-beta2;
q4=0;
q5=Angulo-q3-q2;

% q1=round(q1,6);
% q2=round(q2,6);
% q3=round(q3,6);
% q4=round(q4,6);
% q5=round(q5,6);
q=[q1,q2,q3,q4,q5];
end
