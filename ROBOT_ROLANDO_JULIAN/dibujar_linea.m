% dibujar_linea.m
%
% Esta funcion se encarga de crear una línea entre dos puntos
%
% Ejemplo:
%
% p1 = [-3, -2, 5];   % Punto 1
% p2 = [10, 2, 7];    % Punto 2
% grosor = 3;
% f1=figure(1);, set(f1, 'Color', 'w');
% dibujar_linea(p1,p2,grosor);
% view(50,40);, grid on;

function dibujar_linea(p1,p2,grosor)

line( [p1(1) , p2(1)], [p1(2) , p2(2)], [p1(3) , p2(3)], ...
    'LineWidth',grosor, 'Color', 'k' , 'LineStyle', '-' ); 
