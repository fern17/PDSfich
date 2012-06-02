
%Calcula la ubicacion de los polos de butterworth, dado N y la frecuencia de corte deseada
function [sm] = polosButterworth(fc,N)
    sm = zeros(1,2*N);
    for i=1:2*N
        sm(i) = fc*exp(j*pi*(N+2*i-1)/(2*N));
    end
endfunction

%parametros
frec_corte = 500;
frec_muestreo = 2000;

%grado del polinomio de butterworth
N = 10;

%calculo de los ceros y polos
ceros = [];
polos = polosButterworth(frec_corte,N);


function hz = respuestaFrecuencia(polos,wc,T,z)
    N2 = length(polos);
    M = length(z);
    hz = zeros(1,M);
    for i=1:M
        value = (z(i) - 1)/(z(i) + 1); % formula sacada del defatta
        %value = ((2/T)*((1 - z(i)^(-1))/(1 + z(i)^(-1))));
        numerador = value^N2;
        denominador = 1;
        for j=1:N2
            denominador = denominador * (wc - polos(j)*value);
        end
        hz(i) = numerador/denominador;
    end
endfunction

%Lugares del circulo en z donde evaluar
T = 4*frec_muestreo;
dz = 1/T;
z = 0:dz:pi - dz;
evaluar = exp(j*z);

%encuentra la respuesta en frecuencia
hz = respuestaFrecuencia(polos,frec_corte,T,evaluar);


%dibuja
nn = length(hz);
dff = T/nn;
escala = [0:dff:nn*dff - dff];
figure(1); stem(escala, abs(hz));
pause;
