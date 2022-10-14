%Ajusta los valores de la cinematica con los del robot real 
%Entra a la funcion los valores de cada articulacion en radianes y sale los
%valores para cada servomotor en grados con el ajuste de cada 
% clear
% close all
% clc
% q=[0,0,0,0,0];%valores articulares en radianes
function Q=AJUSTE_CEROS(q)
q=q.*(180/pi);%conversion de radianes a grados
%para q(1) 1er grado libertad
if q(1)==-180 || q(1)==180
    q(1)=0;
end
if q(1)<-90
    q(1)=-90;
end
if q(1)>90
    q(1)=90;
end
if q(1)>=-90 && q(1)<=90
    q(1)=q(1)+90;
end
%para q(2) 2do grado libertad
if q(2)<0
    q(2)=0;
end
if q(2)>180
    q(2)=180;
end
if q(2)>=0 && q(2)<=180
    q(2)=q(2)+45;
end
%para q(3) 3er grado libertad
q(3)=-1*q(3);%cambiamos el signo negativo
if q(3)<-90
    q(3)=-90;
end
if q(3)>150%rango de 200°
    q(3)=150;
end
if q(3)>=-90 && q(3)<=150
    q(3)=q(3)+90;%ajuste del cero del servo
end
%para q(4) 4to grado libertad
if q(4)<0
    q(4)=0;
end
if q(4)>180
    q(4)=180;
end
if q(4)>=0 && q(4)<=180
    q(4)=180-q(4);%ajuste del cero del servo
end
%para q(5) 5to grado libertad
if q(5)<-90
    q(5)=-90;
end
if q(5)>90
    q(5)=90;
end
if q(5)>=-90 && q(5)<=90
    q(5)=q(5)+90;%ajuste del cero del servo
    q(5)=180-q(5);%al girar q4 180° es necesario ajustar q5
end

Q=q;
end