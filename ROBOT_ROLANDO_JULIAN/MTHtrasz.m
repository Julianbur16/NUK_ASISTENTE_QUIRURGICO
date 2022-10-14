% MTHtrasz.m
%
% Crea una MTH con una traslación respecto al eje z

function MTH = MTHtrasz(distancia)

MTH = eye(4);
MTH(3,4) = distancia;