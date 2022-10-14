% MTHRoty.m
%
% Crea una MTH con una rotación respecto al eje y

function MTH = MTHRoty(angulo)

MTH = [cos(angulo),        0,        sin(angulo)     ,0 ;...
      0,                   1,        0               ,0 ;...
      -sin(angulo),        0,        cos(angulo)     ,0 ;...
      0,                   0,        0               ,1];