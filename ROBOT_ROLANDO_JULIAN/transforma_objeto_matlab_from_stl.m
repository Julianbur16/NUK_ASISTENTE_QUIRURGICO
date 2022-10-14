% transforma_objeto_matlab_from_stl.m
% Esta funcion cambia la localizacion de un objeto importado de STL
% segun la MTH A
% Ejemplo:
%
% clear, close all, clc
% figure(1);
% objeto = fun_stl2matlab('stl_eslabon2.STL', [1,0,0],0);
% A = MTHRotx(pi/2);
% dibujar_objeto_matlab_from_stl(objeto,eye(4));
% objeto = transforma_objeto_matlab_from_stl(objeto,A);
% dibujar_objeto_matlab_from_stl(objeto,eye(4));
% dibujar_sistema_referencia_MTH(eye(4), 225, 5, 'o');
% view(40,20), camlight(40,20);, lighting phong;


function objeto_A = transforma_objeto_matlab_from_stl(objeto,A) 

objeto_A = objeto; % se igualan para copiar propiedades de tcolor y n_faces
for i=1:objeto.n_faces
    for j=1:3
        p = [ objeto.x(j,i); objeto.y(j,i); objeto.z(j,i); 1];
        pa = A*p; % aplica la transformacion
        objeto_A.x(j,i) = pa(1);
        objeto_A.y(j,i) = pa(2);
        objeto_A.z(j,i) = pa(3);
    end  
end