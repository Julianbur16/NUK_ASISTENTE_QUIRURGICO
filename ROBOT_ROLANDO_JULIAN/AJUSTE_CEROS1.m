%Ajusta los valores de la cinematica con los del robot real
%Entra a la funcion los valores de cada articulacion en radianes y sale los
%valores para cada servomotor en grados con el ajuste de cada
% clear
% close all
% clc
% q=[0,0,0,0,0];%valores articulares en radianes
function Q=AJUSTE_CEROS1(qtray)
q=qtray.*(180/pi);%conversion de radianes a grados
%para q(1) 1er grado libertad
for(i=1:length(q))
    if q(1,i)==-180 || q(1,i)==180
        q(1,i)=0;
    end
    if q(1,i)<-90
        q(1,i)=-90;
    end
    if q(1,i)>90
        q(1,i)=90;
    end
    if q(1,i)>=-90 && q(1,i)<=90
        q(1,i)=q(1,i)+90;
    end
    %para q(2) 2do grado libertad
    if q(2,i)<0
        q(2,i)=0;
    end
    if q(2,i)>180
        q(2,i)=180;
    end
    if q(2,i)>=0 && q(2,i)<=180
        q(2,i)=q(2,i)+45;
    end
    %para q(3) 3er grado libertad
    q(3,i)=-1*q(3,i);%cambiamos el signo negativo
    if q(3,i)<-90
        q(3,i)=-90;
    end
    if q(3,i)>150%rango de 200°
        q(3,i)=150;
    end
    if q(3,i)>=-90 && q(3,i)<=150
        q(3,i)=q(3,i)+90;%ajuste del cero del servo
    end
    %para q(4) 4to grado libertad
    if q(4,i)<0
        q(4,i)=0;
    end
    if q(4,i)>180
        q(4,i)=180;
    end
    if q(4,i)>=0 && q(4,i)<=180
        q(4,i)=180-q(4,i);%ajuste del cero del servo
    end
    %para q(5) 5to grado libertad
    if q(5,i)<-90
        q(5,i)=-90;
    end
    if q(5,i)>90
        q(5,i)=90;
    end
    if q(5,i)>=-90 && q(5,i)<=90
        q(5,i)=q(5,i)+90;%ajuste del cero del servo
        q(5,i)=180-q(5,i);%al girar q4 180° es necesario ajustar q5
    end
end

Q=q;
end