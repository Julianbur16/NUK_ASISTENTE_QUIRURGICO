clear, clc, close all 
% se definen los colores de las piezas 
color1 = [1,0.85,0.27];
color2=[0.24,1,0.58];
color3=[0.917,0.36,0];
color4=[0.329,0.635,0.101];
color5=[1,0.5,0];%NARANJA
color6=[0.23,0.51,0.74];%azul
 
 
L1=170.81;
L2=13.5;
L3=172.18;
L4=141;
L5=117.6;
Am0 = eye(4); 
 
% Carga STLs de los eslabones del robot 
%ESLABON1_No_2.STX
B.ESLABON1_No_2= fun_stl2matlab('ESLABON1_No_2.STX', color6,2); 
title('No1'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A0CAD0 =MTHRoty(-pi/2)*MTHtrasz(-25)*MTHtrasx(-50.5)*MTHtrasy(-L1);

B.ESLABON1_No_2=transforma_objeto_matlab_from_stl(B.ESLABON1_No_2,A0CAD0); 
dibujar_objeto_matlab_from_stl(B.ESLABON1_No_2,eye(4)); 
title('ESLABON1No2'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(15,15), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on
% 
%ESLABON2_No_3.STX
B.ESLABON2_No_3= fun_stl2matlab('ESLABON2_No_3.STX', color5,1); 
title('ESLABON2_No_3'); 
dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A1CAD1=MTHRoty(-pi/2)*MTHtrasx(-2.5+16)*MTHtrasz(-25)*MTHtrasy(-L1);
B.ESLABON2_No_3=transforma_objeto_matlab_from_stl(B.ESLABON2_No_3,A1CAD1); 
dibujar_objeto_matlab_from_stl(B.ESLABON2_No_3,eye(4)); 
title('B.ESLABON2_No_3'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(20,20), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on

% %ESLABON 2
% E.ESLABON2= fun_stl2matlab('ESLABON2.STX', color3,1); 
% title('ESLABON2'); 
% dibujar_sistema_referencia_MTH(Am0, 300, 5, '0'); 
% 
% % Transforma la localizaciÛn inicial de la geometria 
% figure();
% set(gcf,'Color',[1, 1, 1]);  
% A2CAD2=MTHtrasx(-L3/2)*MTHRoty(-pi/2);
% E.ESLABON2=transforma_objeto_matlab_from_stl(E.ESLABON2,A2CAD2); 
% dibujar_objeto_matlab_from_stl(E.ESLABON2,eye(4)); 
% title('ESLABON 2'); 
% dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
% view(20,20), camlight(40,20); lighting phong; 
% xlabel('x');ylabel('y');zlabel('z');grid on
% 
% %ESLABON 3
% E.ESLABON3= fun_stl2matlab('ESLABON3.STX', color4,1); 
% title('ESLABON3'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 
% 
% % Transforma la localizaciÛn inicial de la geometria 
% figure();
% set(gcf,'Color',[1, 1, 1]);  
% %A4CAD4 =MTHtrasz(219.8771)*MTHRotx(-pi/2); 
% A3CAD3=MTHtrasx(-L4)*MTHRoty(-pi/2);
% E.ESLABON3=transforma_objeto_matlab_from_stl(E.ESLABON3,A3CAD3); 
% dibujar_objeto_matlab_from_stl(E.ESLABON3,eye(4)); 
% title('ESLABON 3'); 
% dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
% view(20,20), camlight(40,20); lighting phong; 
% xlabel('x');ylabel('y');zlabel('z');grid on



save('Geometrias_precargadas2','B')