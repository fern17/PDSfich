%Diseño de un filtro de Butterworth pasa altos de frecuencia de corte de 500hz

%Definicion de parametros:
frec_corte = 500;   %frecuencia de corte pretendida
tolerancia = 50;    %tolerancia en hertz para las frecuencias de paso y rechazo
frec_paso = frec_corte + tolerancia; 
frec_rechazo = frec_corte - tolerancia;
epsilon = 0.01;     %parametro de tolerancia pasabanda
lambda = 100;       % parametro de tolerancia rechazabanda

%parametros por simplicidad
A = lambda/epsilon;
K0 = frec_paso/frec_rechazo;
%estimacion del orden:
N = ceil(abs(log(A)/log(1/K0)));

%frecuencia de las señales a procesar
frec_muestreo = 2000;
%Genera un vector de frecuencias hasta fm
fvector = 0:1:frec_muestreo-1;

%calculo de la energia segun formula de butterworth
energia_filtro = 1./(1 + (epsilon^2*(fvector./frec_paso).^(2*N)));

%como es un pasa altos, se debe hacer una transformacion de frecuencia
energia_filtro = 1./(1 + (epsilon^2*(frec_paso./fvector).^(2*N)));

%calculo de la escala de la grafica de frecuencias
M = length(fvector);
delta_escala = frec_muestreo/M;
escala = 0:delta_escala:frec_muestreo*delta_escala - delta_escala;

hold on;
%Dibuja
title("Respuesta en frecuencia del filtro");
stem(escala,energia_filtro);
xlabel("Frecuencia");
ylabel("Energia");

pause;
