% %CINEMATICA INVERSA ROBOT JULIAN
% clear 
% close all
% clc
% q=[pi/2,0,pi/2,0];
% [A01,A12,A23,A34]=cinematica_directa_4gdl_julian(q);
% A04=A01*A12*A23*A34;
function qq=cinematica_inversa_4gdl_julian(punto,CODO,angulo)
A0=eye(4);
L1=126;
L2a=45.96;
L2b=42.18;
L3=130;
L4=14.36;
L5=117.6;
pfx=punto(1);
pfy=punto(2);
pfz=punto(3);
D=sqrt(pfx^2+pfy^2);
beta=atan2(pfy,pfx);
m=sqrt(D^2-L4^2);
alpha=atan2(L4,m);
q1=beta-alpha;
q1=round(q1,6);
f=pfz-(L1+L2a);
R=m-L2b;
J=sqrt(R^2+f^2);
cosq3=(J^2-L3^2-L5^2)/(2*L3*L5);
senq3=CODO*sqrt(1-cosq3^2);
senq3=round(senq3,6);
q3=atan2(senq3,cosq3);
q3=round(q3,6);
alpha1=atan2(L5*sin(q3),L3+L5*cos(q3));
beta1=atan2(f,R);
q2=beta1-alpha1;
q2=round(q2,6);
q4=angulo;
qq=[q1,q2,q3,q4];
end

