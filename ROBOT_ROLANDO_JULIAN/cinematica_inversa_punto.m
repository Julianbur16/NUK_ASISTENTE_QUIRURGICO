% funcion que calcula la cinematica inversa de un robot antropomorfico de 4
% GDL, para una aplicacion de paletización.

function q=cinematica_inversa_punto(pf,CODO,Angulo)

L1=163.79;
L2=16.5;
L3A=32.5;
L3=130;
L4=135;
L5=117.6;
L4=L4+L5;
%punto de la muñeca
px=pf(1);
py=pf(2);
pz=pf(3);
m=sqrt((py^2)+(px^2));
D=sqrt((m^2)-(L2^2));
beta1=atan2(L2,D);
alpha1=atan2(-px,py);
q1=alpha1-beta1;
J=sqrt(((D-L3A)^2)+((pz-L1)^2));
cosq3=((J^2)-(L3^2)-(L4^2))/(2*L3*L4);
senq3=CODO*sqrt(1-(cosq3^2));
q3=atan2(senq3,cosq3);
beta2=atan2((L4*senq3),(L3+L4*cosq3));
alpha2=atan2((pz-L1),(D-L3A));
q2=alpha2-beta2;
q4=Angulo;
q5=0;

% q1=round(q1,6);
% q2=round(q2,6);
% q3=round(q3,6);
% q4=round(q4,6);
% q5=round(q5,6);
q=[q1,q2,q3,q4,q5];
end
