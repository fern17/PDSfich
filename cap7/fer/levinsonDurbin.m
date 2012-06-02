%Realiza el algoritmo de Levinson Durbin para resolver un problema de prediccion lineal
% Entrada: 
%  r, vector de autorrelacion
%  p, orden del metodo
% Salida:
%  A, coeficientes de cada iteracion
%  E, error en cada iteracion

function [A,E] = levinsonDurbin(r,p)
    E = zeros(1,p+1); %notar que E(i) = E(i-1), ya que E0 = E(1)
    E(1) = r(1);
    A = zeros(p,p);
    k = zeros(1,p);

    for i=1:p
        suma = 0;
        for j=1:(i-1)
            suma = suma + A(j,i-1)*r(i-j);
        end
        k(i) = (-1/E(i))*(r(i) + suma);
        A(i,i) = k(i);
        for j=1:(i-1)
            A(j,i) = A(j,i-1) + k(i)*A(i-j,i-1);
        end
        E(i+1) = E(i)*(1-k(i)^2);
    end
    
endfunction

