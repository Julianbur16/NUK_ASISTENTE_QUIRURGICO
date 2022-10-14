%planeacion de trayectorias
%El Robot recibe los puntos de interes y a traves de interpolacion cubica
%se obtinen las coordenadas articulares para seguir la trayectoria
clear;
close all;
clc;
%dibujar iniciales del nombre RM
CODO=-1;
angulo=-70*pi/180;
npuntos=5;%Numero de puntos para la interpolarcion cubica
%PUNTOS PARA FORMAR LA LETRA "R"
% punto1=[-150,-80,0]';
% punto1a=[-225,-80,0]';
% punto2=[-300,-80,0]';
% punto3=[-300,-10,0]';
% punto4=[-225,-10,0]';
% punto5=[-225,-80,0]';
% punto6=[-150,-10,0]';
% punto7=[-150,10,0]';
% punto8=[-225,10,0]';
% punto9=[-300,10,0]';
% punto10=[-225,35,0]';
% punto11=[-300,80,0]';
% punto12=[-225,80,0]';
% punto13=[-150,80,0]';
% Rpuntos=[punto1,punto1a,punto2,punto3,punto4,punto5,punto6,...
%     punto7,punto8,punto9,punto10,punto11,punto12,punto13];

%triangulo
punto1=[0,250,50]';
punto2=[200,250,50]';
punto3=[0,250,150]';
Rpuntos=[punto1,punto2,punto3,punto1];

for (i=1:length(Rpuntos))
    t(i)=i;
    q(:,i)=cinematica_inversa_punto1(Rpuntos(:,i)',CODO,angulo)';%Valores de las articulaciones [q1,q2,q3,q4,q5] vector fila
end
%plot(t,q(1,:))
trayectoria1=interpolador_cubico_dibujo(t,npuntos,q(1,:));%TRAYECTORIA DE LA ARTICULACION 1
trayectoria2=interpolador_cubico_dibujo(t,npuntos,q(2,:));%TRAYECTORIA DE LA ARTICULACION 2
trayectoria3=interpolador_cubico_dibujo(t,npuntos,q(3,:));%TRAYECTORIA DE LA ARTICULACION 3
trayectoria4=interpolador_cubico_dibujo(t,npuntos,q(4,:));%TRAYECTORIA DE LA ARTICULACION 4
trayectoria5=interpolador_cubico_dibujo(t,npuntos,q(5,:));%TRAYECTORIA DE LA ARTICULACION 5
qtray=[trayectoria1.q;trayectoria2.q;trayectoria3.q;trayectoria4.q;trayectoria5.q];
Q=AJUSTE_CEROS1(qtray);
% tamano=get(0,'ScreenSize');
% figure('position',[tamano(1) tamano(2) tamano(3) tamano(4)]);

for i=1:length(trayectoria1.t)
    
    figure(2);
    clf;
    t(i)=i;
    A05=dibujar_robot([trayectoria1.q(i),trayectoria2.q(i),trayectoria3.q(i),trayectoria4.q(i),trayectoria5.q(i)]);
    %view(-90,20), camlight(40,20); lighting phong;
    linea(:,i)=A05(1:3,4);
    hold on
    line([Rpuntos(1,:)],[Rpuntos(2,:)],[Rpuntos(3,:)]);
    hold on
    plot3(Rpuntos(1,:),Rpuntos(2,:),Rpuntos(3,:),'*');
    %line([0,linea(1,i)], [0, 0], [0, 0],'Color', 'k' ,'LineWidth',2, 'LineStyle','--');
    %line([linea(1,i),linea(1,i)], [0, linea(2,i)], [0, 0],'Color', 'k' ,'LineWidth',2, 'LineStyle','--');
    %line([linea(1,i),linea(1,i)], [linea(2,i),linea(2,i)], [0, linea(3,i)],'Color', 'k' ,'LineWidth',2, 'LineStyle','--');
    % Dibuja trayectoria
    tray(i,:) = linea(:,i);
    line(tray(:,1),tray(:,2),tray(:,3),'LineWidth',5);
    grid on;
    
end

%-----------------------------------------------------------------
%luego de la interpolacion es necesario saber donde estan los puntos de
%interes para abrir o cerrar la pinza en esos puntos
% j=1;
% for i=1:length(trayectoria1.q)
%     if round(q(1,j),4)==round(trayectoria1.q(i),4)
%         i
%         j=j+1;
%     end
%     if i>=2 && i<length(trayectoria1.q)
%         
%         if round(trayectoria1.q(i+1),4)==round(trayectoria1.q(i),4)
%             j=j-1;
%         end
%     end
%     
% end
%------------------------------------------------------------------
