
%Calcula la ubicacion de los polos de butterworth, dado N y la frecuencia de corte deseada
function [sm] = polosButterworth(fc,N)
    sm = zeros(1,2*N);
    for i=1:2*N
        sm(i) = fc*exp(j*pi*(N+2*i-1)/(2*N));
    end
endfunction

%Retorna los dos polinomios de la funcion de transferencia a partir de 
% un vector de ceros y polos
function [numerador, denominador] = raicesAPolinomio(ceros,polos)
    lz = length(ceros);
    lp = length(polos);
    numerador = [1];
    denominador = [1];
    for i=1:lp
        %convolucion es una operacion de multiplicacion
        denominador = conv(denominador,[1 -polos(i)]);
    end
    
    for i=1:lz
        numerador = conv(numerador,[1 -ceros(i)]);
    end
endfunction

%parametros
frec_corte = 500;
frec_muestreo = 2000;

%grado del polinomio de butterworth
N = 2;

%calculo de los ceros y polos
ceros = [];
polos = polosButterworth(frec_corte,N);

%cambio de normalizado a pasabajos en frec_corte
% s -> w_c/s
for i=1:length(polos)
    polos(i) = frec_corte/polos(i);
end

%calculo de los polinomios
[numerador, denominador] = raicesAPolinomio(ceros, polos);

%calculo de la respuesta en frecuencia
respuesta_freq = freqz(numerador, denominador, frec_muestreo, "whole");

%dibuja
figure(1); stem(abs(respuesta_freq));
pause;
