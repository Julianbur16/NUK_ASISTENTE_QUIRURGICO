% MTHRotz.m
%
% Crea una MTH con una rotación respecto al eje z

function MTH = MTHRotz(angulo)

MTH = [cos(angulo),      -sin(angulo),   0   ,0 ;...
       sin(angulo),      cos(angulo),    0   ,0 ;...
       0,                0,              1   ,0 ;...
       0,                0,              0   ,1];