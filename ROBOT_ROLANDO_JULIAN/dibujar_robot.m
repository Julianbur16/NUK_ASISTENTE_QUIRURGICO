% clear
% close all
% clc
% q=[pi/2,pi/3,pi/4,pi/5,pi/6];%ARTICULACIONES SON ROTACIONALES ANGULOS EN RADIANES
function efector=dibujar_robot(q)
L1=163.79;
L2=16.5;
L3A=32.5;
L3=130;
L4=135;
L5=117.6;

load('Geometrias_precargadas1.mat');
% load('Geometrias_precargadas2.mat');
% load('Geometrias_precargadas3.mat');

Am0 =eye(4);

[A01,A12,A23,A34,A45]=cinematica_directa(q);

Am1 = Am0*A01;
Am2 = Am1*A12;
Am3 = Am2*A23;
Am4 = Am3*A34;
Am5 = Am4*A45;


dibujar_sistema_referencia_MTH(Am0, 55, 5, '0');
dibujar_sistema_referencia_MTH(Am1, 55, 5, '1');
dibujar_sistema_referencia_MTH(Am2, 55, 5, '2');
dibujar_sistema_referencia_MTH(Am3, 55, 5, '3');
dibujar_sistema_referencia_MTH(Am4, 55, 5, '4');
dibujar_sistema_referencia_MTH(Am5, 55, 5, '5');
view(120,20);

p0 = Am0(1:3,4);
p1 = Am1(1:3,4);
p2 = Am2(1:3,4);
p3 = Am3(1:3,4);
p4 = Am4(1:3,4);
p5 = Am5(1:3,4);

dibujar_linea(p0,p1,5);
dibujar_linea(p1,p2,5);
dibujar_linea(p2,p3,5);
dibujar_linea(p3,p4,5);
dibujar_linea(p4,p5,5);

dibujar_objeto_matlab_from_stl(A.BASE01,Am0);
dibujar_objeto_matlab_from_stl(A.BASE02,Am1);
dibujar_objeto_matlab_from_stl(A.ESLABON03,Am2);
dibujar_objeto_matlab_from_stl(A.ESLABON04,Am3);
dibujar_objeto_matlab_from_stl(A.ESLABON05,Am4);
dibujar_objeto_matlab_from_stl(A.ESLABON06,Am5);

p5(1)=round(p5(1),2);
p5(2)=round(p5(2),2);
p5(3)=round(p5(3),2);
efector=Am5;

view(135,20), camlight(40,20); lighting phong;
xlabel('x');ylabel('y');zlabel('z');grid on
title(['px=',num2str(p5(1)),'  py=',num2str(p5(2)),'  pz=',num2str(p5(3))], 'FontSize', 18)




