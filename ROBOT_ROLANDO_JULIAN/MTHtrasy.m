% MTHtrasy.m
%
% Crea una MTH con una traslación respecto al eje y

function MTH = MTHtrasy(distancia)

MTH = eye(4);
MTH(2,4) = distancia;