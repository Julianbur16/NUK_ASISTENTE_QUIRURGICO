%SE CREA LA MATRIZ DEL EFECTOR FINAL A PARITR DEL PUNTO pf DESEADO Y EL ANGULO
%DE APROXIMACION CON EL EJE Z0 Y EL ANGULO DE APROXIMACION CON EL EJE X0
function A05=matriz_efector(pf,Az,Ax)
r=sqrt((pf(1)^2)+(pf(2)^2));%se calcula la distacia radial del punto al origen
theta=atan2(-pf(1),pf(2));
A_Z0=Az*pi/180;%Angulo de acercamiento al objeto con respeto a la vertical
A_X0=Ax*pi/180;%Angulo de acercamiento al objeto con respecto a la horizontal
A05=MTHtrasz(pf(3))*MTHRotz(theta)*MTHtrasy(r)*MTHRoty(pi/2)*MTHRotz(pi/2-A_Z0)*MTHRotx(A_X0);
dibujar_sistema_referencia_MTH(A05, 50, 5, 'F')
end





