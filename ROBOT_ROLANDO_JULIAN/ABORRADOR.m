clear
close all
clc
%-------------------------------------------------------------
%Declaramos variable de tipo tcpip conectada con esp8266
port=80;
ip1='192.168.1.10';
a=tcpip(ip1,port,'NetworkRole','client');
espera=0.2;
%-------------------------------------

px=0;%en milimitros
py=150;
pz=250;
punto=[px,py,pz];
q1=cinematica_inversa_punto(punto,-1,pi/2);
efector1=dibujar_robot(q1);
figure(2);
q2=cinematica_inversa_punto1(punto,-1,0)
efector2=dibujar_robot(q2);
axis equal
Q=AJUSTE_CEROS(q1);
Q=round(Q)
%------------------------------------------------------------

for i=0:1:2
    n=[Q,0];%en grados
    fopen(a);
    fwrite(a,'I'); %LED OFF
    fclose(a);
    
    pause(espera)
    
    %Envio de informacion para mostrar en pantalla (variable a)
    fopen(a);
    fwrite(a,n(1)); %LED OFF
    fclose(a);
    
    pause(espera)
        
    fopen(a);
    fwrite(a,n(2)); %LED OFF
    fclose(a);
    
    pause(espera)
      
    %Envio de informacion para mostrar en pantalla (variable a)
    fopen(a);
    fwrite(a,n(3)); %LED OFF
    fclose(a);
    
    pause(espera)
       
    fopen(a);
    fwrite(a,n(4)); %LED OFF
    fclose(a);
    
    pause(espera)
        
    %Envio de informacion para mostrar en pantalla (variable a)
    fopen(a);
    fwrite(a,n(5)); %LED OFF
    fclose(a);
    
    pause(espera)
    
    
    fopen(a);
    fwrite(a,n(6)); %LED OFF
    fclose(a);
    
    pause(espera)
    
    fopen(a);
    fwrite(a,201); %LED OFF
    fclose(a);
    
    pause(espera)
    
    
end


