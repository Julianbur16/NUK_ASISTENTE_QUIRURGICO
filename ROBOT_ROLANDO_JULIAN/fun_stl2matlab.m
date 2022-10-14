% fun_stl2matlab.m
% importa datos de un fichero stl
% Ejemplo:
% clear, close all, clc
% objeto_matlab = fun_stl2matlab('cubostl.stl', [1,0,0],1)

function objeto_matlab = fun_stl2matlab(file, color, dibujar)

datos = importdata(file,'\t');
[nfil,nada]=size(datos);
n_face = 0;
datos_mat=[];
for i = 2:7:nfil-1 % encabezado
    n_face = n_face +1;
    Cf = textscan(datos{i}, '%s %s %n %n %n');
    C1 = textscan(datos{i+2}, '%s %n %n %n');
    C2 = textscan(datos{i+3}, '%s %n %n %n');
    C3 = textscan(datos{i+4}, '%s %n %n %n');
    datos_mat.facet_normal(n_face,:) = [Cf{3} , Cf{4} , Cf{5} ];
    datos_mat.vertex1(n_face,:) = [C1{2}, C1{3}, C1{4}];
    datos_mat.vertex2(n_face,:) = [C2{2}, C2{3}, C2{4}];
    datos_mat.vertex3(n_face,:) = [C3{2}, C3{3}, C3{4}];
end
objeto_matlab.x = [datos_mat.vertex1(:,1)'; datos_mat.vertex2(:,1)'; datos_mat.vertex3(:,1)'];
objeto_matlab.y = [datos_mat.vertex1(:,2)'; datos_mat.vertex2(:,2)'; datos_mat.vertex3(:,2)'];
objeto_matlab.z = [datos_mat.vertex1(:,3)'; datos_mat.vertex2(:,3)'; datos_mat.vertex3(:,3)'];
objeto_matlab.tcolor(1,1:n_face,1) = color(1);
objeto_matlab.tcolor(1,1:n_face,2) = color(2);
objeto_matlab.tcolor(1,1:n_face,3) = color(3);
objeto_matlab.n_faces = n_face;
if dibujar
    f1=figure;, set(f1,'Color',[1, 1, 1]); 
    p=patch(objeto_matlab.x,objeto_matlab.y,objeto_matlab.z,objeto_matlab.tcolor);
    set(p, 'EdgeColor', 'none' );
    view(40,20), camlight(40,20);, lighting phong;
    xlabel('x');, ylabel('y');, zlabel('z');, grid on
end




