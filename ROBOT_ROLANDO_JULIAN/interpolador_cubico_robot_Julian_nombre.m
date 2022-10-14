close all
clear
clc
%dibujar iniciales del nombre RM
CODO=-1;
angulo=0;
npuntos=10;%Numero de puntos para la interpolarcion cubica
n=1;
puntoi=[200,100,150];
L1=70;
Rpuntos=tramos_JD(n,puntoi,L1);
for (i=1:length(Rpuntos))
    t(i)=i;
    q(:,i)=cinematica_inversa_punto([Rpuntos(:,i)],CODO,angulo);%Valores de las articulaciones [q1;q2;q3;q4]
end

figure()
trayectoria1=interpolador_cubico_dibujo(t,npuntos,q(1,:));%TRAYECTORIA DE LA ARTICULACION 1
figure()
trayectoria2=interpolador_cubico_dibujo(t,npuntos,q(2,:));%TRAYECTORIA DE LA ARTICULACION 2
figure()
trayectoria3=interpolador_cubico_dibujo(t,npuntos,q(3,:));%TRAYECTORIA DE LA ARTICULACION 3
figure()
trayectoria4=interpolador_cubico_dibujo(t,npuntos,q(4,:));%TRAYECTORIA DE LA ARTICULACION 4

for i=1:length(trayectoria1.t)
    figure(5);
    clf;
    posicion_efector=dibujar_robot([trayectoria1.q(i),trayectoria2.q(i),trayectoria3.q(i),trayectoria4.q(i),0]);
  linea(:,i)=posicion_efector(1:3,4);
    hold on
    lintrayec=7;
    x=length(Rpuntos)-lintrayec;
    line([Rpuntos(1,1:x)],[Rpuntos(2,1:x)],[Rpuntos(3,1:x),],'color','blue','LineWidth',1);
    hold on
    plot3(Rpuntos(1,1:x),Rpuntos(2,1:x),Rpuntos(3,1:x),'*','color','green','MarkerSize',4);
    [t]=title([' X=  ',num2str(linea(1,i)),'   Y= ',num2str(linea(2,i)),'   Z=  ',num2str(linea(3,i))],'Color','blue');
    t.FontSize = 18;
    t.FontAngle = 'italic';
    set(gca, 'Color','k', 'XColor','w', 'YColor','w' ,'ZColor','w')
    set(gcf, 'Color','k')
    grid on
    ax = gca;
    ax.GridAlpha = 0.6;
    ax.GridColor = 'w';
    % Dibuja trayectoria
    if(i<(length(trayectoria1.t)-(lintrayec*npuntos+round(npuntos/10))))
    tray(i,:) = linea(:,i);
    line(tray(:,1),tray(:,2),tray(:,3),'color','red','LineWidth',3);
     
    end
    
    if(i>=(length(trayectoria1.t)-(lintrayec*npuntos+round(npuntos/10))))
    line(tray(:,1),tray(:,2),tray(:,3),'color','red','LineWidth',3);
    end
    

    pause(0.0000001);
end


