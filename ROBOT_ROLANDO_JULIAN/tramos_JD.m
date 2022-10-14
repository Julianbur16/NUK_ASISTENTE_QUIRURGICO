function Rpuntos=tramos_JD(n,puntoi,L1)

puntost1(2,:)=linspace(puntoi(2),puntoi(2)-L1,n+2);
puntost1(1,:)=puntoi(1);
puntost1(3,:)=puntoi(3);

aux=linspace(puntoi(1),puntoi(1)+L1*3,n+2);
puntost2(1,:)=aux(1,2:n+2);
puntost2(2,:)=puntoi(2)-L1;
puntost2(3,:)=puntoi(3);

aux1=fliplr(puntost1(2,:));
puntost3(2,:)=aux1(1,2:n+2);
puntost3(1,:)=puntoi(1)+L1*3;
puntost3(3,:)=puntoi(3);

aux2=linspace(puntoi(2),puntoi(2)-2*L1,n+2);
puntost4(2,:)=aux2(1,2:n+2);
puntost4(1,:)=puntoi(1)+L1*3;
puntost4(3,:)=puntoi(3);

th = linspace(pi/2,0,n+2);
aux13 =-(-(puntoi(2)-2*L1)+L1*(3/2)*cos(th));
aux23 =puntoi(1)+L1*(3/2)+L1*(3/2)*sin(th);
puntost5(2,:) =aux13(1,2:n+2);
puntost5(1,:)= aux23(1,2:n+2);
puntost5(3,:)=puntoi(3);

th1 = linspace(0,-pi/2,n+2);
aux14 =-(-(puntoi(2)-2*L1)+L1*(3/2)*cos(th1));
aux24 =puntoi(1)+L1*(3/2)+L1*(3/2)*sin(th1);
puntost6(2,:) = aux14(1,2:n+2);
puntost6(1,:)= aux24(1,2:n+2);
puntost6(3,:)=puntoi(3);

puntost7(1,:)=aux(1,2:n+2);
puntost7(2,:)=puntoi(2)-2*L1;
puntost7(3,:)=puntoi(3);

aux78 =linspace(puntoi(3),puntoi(3)+50,4);
puntost8(1,1:3)=aux(1,n+2);
puntost8(2,1:3)=puntoi(2)-2*L1;
puntost8(3,1:3)=aux78(1,2:4);

aux79 =linspace(puntoi(2)-2*L1,puntoi(2)-L1,4);
puntost9(1,1:3)=puntoi(1)+L1*3;
puntost9(2,1:3)=aux79(1,2:4);
puntost9(3,1:3)=puntoi(3)+50;

puntost10(1,:)=puntoi(1);
puntost10(2,:)=puntoi(2);
puntost10(3,:)=puntoi(3)+50;

Rpuntos=[puntost1,puntost2,puntost3,puntost4,puntost5,puntost6,puntost7,puntost8,puntost9,puntost10];
end