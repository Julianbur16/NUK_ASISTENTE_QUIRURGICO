
% Dibuja el resultado de interpolar mediante spline cubico los valores q en
% los instantes tt con las velocidades de paso qd.
% Devuelve un vector con 1 fila por punto con los 
% resultados (t,q,qd,qdd)de muestrear el polinomio interpolador 
% Utiliza la funcion i_cubico que obtiene los valores de los coeficientes
% Las velocidades de paso pueden ser expecificadas o en caso contrario se
% utiliza la expresión [6.8]
% Ejercicio 6.2
%   (c) FUNDAMENTOS DE ROBOTICA   (A. Barrientos) McGrawHill 2007
% se modifico para que trace la línea continuo
%
% Ejemplo adicional:
% clear, close all, clc
% t =  [0, 1, 2, 4, 5, 6, 7];
% q =  [2, 6, 4, 3, 8, 9, 5];
% qp = [0,-1, 3, 0, 3,-3, 0];
% npuntos = 300;
% trayectoria =p_cubico_m(q,t,qp)
%________________________________________________________________

function trayectoria=interpolador_cubico_dibujo(t,npuntos,q,qp)
n=length(q);    % numero de intervalos
PL=[];
clf
hold on
% Obtiene los coeficientes de los splines cubicos 
% [ti,tf,a,b,c,d] para cada intervalo
if (nargin==3)
    P=interpolador_cubico(t,q);
else
    P=interpolador_cubico(t,q,qp);
end
 
for intervalo=1:n-1
    ti =P.ti(intervalo);
    tf =P.tim1(intervalo);
    a  =P.a(intervalo);
    b  =P.b(intervalo);
    c  =P.c(intervalo);
    d  =P.d(intervalo);
    
    inc=(tf-ti)/npuntos;
    for tt=ti:inc:tf
        qt=a+b*(tt-ti)+c*(tt-ti)^2+d*(tt-ti)^3; 
        qdt=b+2*c*(tt-ti)+3*d*(tt-ti)^2;
        qddt=2*c+6*d*(tt-ti);
        %plot(tt,qt,'k.');
        PL=vertcat(PL,[tt,qt,qdt,qddt]);
    end
end
trayectoria.t=PL(:,1)';
trayectoria.q=PL(:,2)';
trayectoria.qp=PL(:,3)';
trayectoria.qpp=PL(:,4)';
plot(trayectoria.t,trayectoria.q); % linea nueva
plot(t,q,'o')
title('POSICION')
grid
hold off

