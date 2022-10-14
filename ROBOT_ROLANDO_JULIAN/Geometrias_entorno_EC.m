clear, clc, close all 
% se definen los colores de las piezas 
color1 = [1,0.85,0.27];
color2=[0.24,1,0.58];
color3=[0.917,0.36,0];
color4=[0.329,0.635,0.101];
 
% diap_transformar_geometria.m 
L1=50; % dimension de la base fija del robot;
L2=100;
L3=60;
L4=30;
Am0 = eye(4); 
 
% Carga STLs de los eslabones del robot 
%MESA
C.MESA= fun_stl2matlab('MESA.STX', color3,2); 
title('MESA'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A0CAD0 =MTHRotx(pi/2); 

C.MESA=transforma_objeto_matlab_from_stl(C.MESA,A0CAD0); 
dibujar_objeto_matlab_from_stl(C.MESA,eye(4)); 
title('MESA'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(15,15), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on

%CAJA
C.CAJA= fun_stl2matlab('CAJA.STX', color2,1); 
title('CAJA'); 
dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A1CAD1=MTHtrasx(L4/2)*MTHtrasy(-L4/2);
C.CAJA=transforma_objeto_matlab_from_stl(C.CAJA,A1CAD1); 
dibujar_objeto_matlab_from_stl(C.CAJA,eye(4)); 
title('CAJA'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(20,20), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on

save('Geometrias_entorno_EC','C')