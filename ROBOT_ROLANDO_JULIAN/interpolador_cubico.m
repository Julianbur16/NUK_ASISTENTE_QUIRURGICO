% Obtiene los coeficientes de los splines cubicos
% que interpolan los valores q en los instantes t
% con las velocidades de paso qd
% Las velocidades de paso pueden ser especificadas
% o en caso contrario se utiliza la expresión [6.8]
% Retorna un vector con una fila por cada tramo
% con [ti,tf,a,b,c,d] siendo el polinomio:
% q(t)=a+b(t-ti)+c(t-ti)^2+d(t-ti)^3   para ti<t<tf
% Ejercicio 6.2
%   (c) FUNDAMENTOS DE ROBOTICA   (A. Barrientos) McGrawHill 2007
%
% Ejemplo adicional 1 del uso del interpolador cubico
% clear, close all, clc
% t =  [0, 2, 4, 6, 9, 25, 27];
% q =  [0, 1, 3, 3, 2,  5,  6];
% P=interpolador_cubico(t,q)
%
% Ejemplo adicional 2 del uso del interpolador cubico
% clear, close all, clc
% t =  [0, 2, 4, 6, 9, 25, 27];
% q =  [0, 1, 3, 3, 2,  5,  6];
% qp = [0,-1, 3, 0, 3,-3, 0];
% P=interpolador_cubico(t,q,qp)
%________________________________________________________________

function P=interpolador_cubico(t,q,qp)
n=length(q);
if n~=length(t)
    error('ERROR en i_cubico: Las dimensiones de q y t deben ser iguales')
end
 
if nargin~= 3    % qd no definida. La obtiene  segun [6.8]
   qp(1)=0;
   qp(n)=0;
  for i=2:n-1
      if (sign(q(i)-q(i-1))==sign(q(i+1)-q(i)))...
              |q(i)==q(i+1)...
              |q(i-1)==q(i)
          qp(i)=0.5*((q(i+1)-q(i))/(t(i+1)-t(i))+ ...
         +(q(i)-q(i-1))/(t(i)-t(i-1)));
      else
          qp(i)=0;
      end
  end
end

% obtiene los coeficientes de los polinomios
    for i=1:n-1
        ti=t(i);
        tii=t(i+1);
        if tii<=ti
            error ('ERROR en i_cubico. Los tiempos deben estar ordenados: t(i) debe ser < t(i+1)')
        end
        T=tii-ti;
        %TT(:,i)=[ti;tii];
        P.ti(i)=ti;
        P.tim1(i)=tii;
        P.a(i)=q(i);
        P.b(i)=qp(i);
        P.c(i)= 3/T^2*(q(i+1)-q(i)) - 1/T  *(qp(i+1)+2*qp(i));
        P.d(i)=-2/T^3*(q(i+1)-q(i)) + 1/T^2*(qp(i+1)  +qp(i));
    end
         
    %P=[TT;a; b; c; d]';

end