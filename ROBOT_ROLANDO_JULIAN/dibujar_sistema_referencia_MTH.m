% dibujar_sistema_referencia_MTH.m
% Esta función dibuja un sistema de referencia rotado segun
% la matriz de ttransformación homogenea MYH. L es la longuitud,
% G el grosor y el texto
%
% Ejemplo:
% MTH = eye(4);
% dibujar_sistema_referencia_MTH(MTH, 10, 5, '1');
% grid on, view(50,30);
function dibujar_sistema_referencia_MTH(MTH, L, G, Subindicice)

% Puntos finales de los ejes x, y, z
pfx = MTH*[L;0;0;1];    % Punto final eje x
pfy = MTH*[0;L;0;1];    % Punto final eje y
pfz = MTH*[0;0;L;1];    % Punto final eje z
% Dibuja los ejes
line( [MTH(1,4), pfx(1)], [MTH(2,4), pfx(2)],  [MTH(3,4), pfx(3)],'LineWidth',G, 'Color', 'r' );
line( [MTH(1,4), pfy(1)], [MTH(2,4), pfy(2)],  [MTH(3,4), pfy(3)],'LineWidth',G, 'Color', 'g' );
line( [MTH(1,4), pfz(1)], [MTH(2,4), pfz(2)],  [MTH(3,4), pfz(3)],'LineWidth',G, 'Color', 'b' );
% Dibuja los titulos de los ejes coordenados
text( pfx(1),pfx(2),pfx(3),strcat(' x_',Subindicice) );
text( pfy(1),pfy(2),pfy(3),strcat(' y_',Subindicice) );
text( pfz(1),pfz(2),pfz(3),strcat(' z_',Subindicice) );