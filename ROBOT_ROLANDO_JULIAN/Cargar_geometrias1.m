clear, clc, close all 
% se definen los colores de las piezas 
color1 = [0.25,0.25,0.25]; %Negro Oscuro
color2=  [1,0.35,0]; %Naranja
color3=[0.75,0.75,0.75];%Plateado

 

Am0 = eye(4); 
 
% Carga STLs de los eslabones del robot 
%--------------------------------------------------------------
%BASE01
A.BASE01= fun_stl2matlab('BASE_01.STX', color1,2); 
title('No1'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A0CAD0 = MTHRotz(-pi/2)*MTHtrasy(107.84)*MTHRotx(pi/2)*MTHtrasx(-148.53); 

A.BASE01=transforma_objeto_matlab_from_stl(A.BASE01,A0CAD0); 
dibujar_objeto_matlab_from_stl(A.BASE01,eye(4)); 
title('BASE'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(15,15), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on

%--------------------------------------------------------------
%BASE02
A.BASE02= fun_stl2matlab('BASE_02.STX', color2,2); 
title('No2'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A1CAD1 = MTHRoty(pi)*MTHtrasz(-45)*MTHtrasx(-25)*MTHtrasy(-163.79); 

A.BASE02=transforma_objeto_matlab_from_stl(A.BASE02,A1CAD1); 
dibujar_objeto_matlab_from_stl(A.BASE02,eye(4)); 
title('BASE02'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(15,15), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on


%--------------------------------------------------------------
%ESLABON03
A.ESLABON03= fun_stl2matlab('ESLABON_03.STX', color2,2); 
title('No3'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A2CAD2 = MTHtrasz(64.1)*MTHtrasx(25)*MTHtrasy(-163.79)*MTHRoty(pi); 

A.ESLABON03=transforma_objeto_matlab_from_stl(A.ESLABON03,A2CAD2); 
dibujar_objeto_matlab_from_stl(A.ESLABON03,eye(4)); 
title('ESLABON03'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(15,15), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on

%--------------------------------------------------------------
%ESLABON04
A.ESLABON04= fun_stl2matlab('ESLABON_04.STX', color2,2); 
title('No4'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A3CAD3 = MTHRotz(-pi/2)*MTHtrasz(110.5)*MTHtrasx(-21.5)*MTHRoty(pi/2)*MTHtrasy(-163.79); 

A.ESLABON04=transforma_objeto_matlab_from_stl(A.ESLABON04,A3CAD3); 
dibujar_objeto_matlab_from_stl(A.ESLABON04,eye(4)); 
title('ESLABON04'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(15,15), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on

%--------------------------------------------------------------
%ESLABON05
A.ESLABON05= fun_stl2matlab('ESLABON_05.STX', color1,2); 
title('No5'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A4CAD4 = MTHRoty(pi)*MTHRotz(-pi/2)*MTHtrasz(-57)*MTHtrasx(-17.5)*MTHtrasy(-163.79); 

A.ESLABON05=transforma_objeto_matlab_from_stl(A.ESLABON05,A4CAD4); 
dibujar_objeto_matlab_from_stl(A.ESLABON05,eye(4)); 
title('ESLABON05'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(15,15), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on

%--------------------------------------------------------------
%ESLABON06
A.ESLABON06= fun_stl2matlab('ESLABON_06.STX', color3,2); 
title('No6'); 
% dibujar_sistema_referencia_MTH(Am0, 50, 5, '0'); 

% Transforma la localizaciÛn inicial de la geometria 
figure();
set(gcf,'Color',[1, 1, 1]);  
A5CAD5 = MTHRotx(pi)*MTHtrasz(-35.8)*MTHRotz(pi)*MTHtrasy(-163.94); 

A.ESLABON06=transforma_objeto_matlab_from_stl(A.ESLABON06,A5CAD5); 
dibujar_objeto_matlab_from_stl(A.ESLABON06,eye(4)); 
title('ESLABON06'); 
dibujar_sistema_referencia_MTH(Am0, 150, 5, '0'); 
view(15,15), camlight(40,20); lighting phong; 
xlabel('x');ylabel('y');zlabel('z');grid on


save('Geometrias_precargadas1','A')