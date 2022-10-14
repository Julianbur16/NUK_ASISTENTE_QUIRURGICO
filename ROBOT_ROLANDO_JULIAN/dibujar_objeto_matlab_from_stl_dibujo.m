function dibujar_objeto_matlab_from_stl(objeto,A)

clear, close all, clc
objeto = fun_stl2matlab('fig3d1.stx', [1,0,0],0);
A= [ 1, 0, 0, 30; ...
 0,  cos(pi/6), -sin(pi/6), 20; ...   
 0,  sin(pi/6), cos(pi/6), 50; ...
 0 , 0, 0, 1];
dibujar_objeto_matlab_from_stl(objeto,A);
view(40,20), camlight(40,20);,lighting phong