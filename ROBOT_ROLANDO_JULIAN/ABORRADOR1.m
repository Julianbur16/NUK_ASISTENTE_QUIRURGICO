clear 
close all
clc
punto=[-16.5,215.1,300]
Az=40;
Ax=0;
A05=matriz_efector(punto,Az,Ax);

     
q=cinematica_inversa_matrizA(A05,-1);
dibujar_robot(q);

