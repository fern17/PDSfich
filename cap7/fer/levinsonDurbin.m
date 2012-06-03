%Realiza el algoritmo de Levinson Durbin para resolver un problema de prediccion lineal
% Entrada: 
%  r, vector de autorrelacion
%  p, orden del metodo
% Salida:
%  A, coeficientes de cada iteracion
%  E, error en cada iteracion

function [A,G,E] = levinsonDurbin(r,orden)
    Et = r(1);
    A = zeros(1,orden);  
    E = [Et];

    for i=1:orden
        At = zeros(1,i+1);
        At(1) = 1;
        suma = r(i+1);
        for j=2:i
            suma = suma + A(j)*r(i-j+2);
        end
        %k = (-1/E(i))*(r(i) + suma)
        k = -suma/Et;
        
        for j=2:i
            At(j) = A(j) + k*A(i-j+2);
        end
        At(i+1) = k;
        Et = Et*(1-k^2);
        E = [E Et];
        A = At;
    end
    G = sqrt(E(orden));
    
endfunction

