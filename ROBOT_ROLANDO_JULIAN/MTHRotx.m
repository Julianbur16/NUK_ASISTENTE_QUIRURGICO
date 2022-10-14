% MTHRotx.m
%
% Crea una MTH con una rotación respecto al eje x

function MTH = MTHRotx(angulo)

MTH = [1,        0,              0              ,0 ;...
      0,        cos(angulo),    -sin(angulo)    ,0 ;...
      0,        sin(angulo),    cos(angulo)     ,0 ;...
      0,        0,              0               ,1];