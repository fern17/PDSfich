%Guia de Filtros. Ejercicio 1.
clear;
%clf;
hold on;

%definición de polos y ceros
function [ceros,polos] = crearRaices(rz,rp)
    polos = [rp*exp(j*pi/4); rp*exp(j*-pi/4); rp*exp(j*pi/4); rp*exp(j*-pi/4)];
    ceros = [rz*exp(j*pi/6); rz*exp(j*-pi/6); rz*exp(j*1/3*pi); rz*exp(j*-1/3*pi)];
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

%-----------fin definicion de funciones-----------
%Parametros
%frecuencia de las señales a procesar
fm = 200;


%-----------fin definicion parametros-------------

%%---Inciso A: Dibuja el diagrama de polos y ceros
%calcula los ceros y polos
[ceros,polos] = crearRaices(0.85,0.95);

%figure(1); 
%zplane(ceros, polos);
%title("Diagrama de Polos 'X' y Ceros 'O' en plano Z");
%xlabel("Parte Real");
%ylabel("Parte Imaginaria");

%%---Inciso B: graficar la respuesta en frecuencia

%calcula los coeficientes de los polonomios de la H(z)
[numerador, denominador] = raicesAPolinomio(ceros,polos);

%obtiene la respuesta en frecuencia
respuesta_freq = freqz(numerador,denominador, fm);

%dibuja
%figure(2); stem(abs(respuesta_freq));
%title("Respuesta en frecuencia"); xlabel("Frecuencia"); ylabel("|H(z)|");

%%---Inciso C: normalizar los coeficientes del filtro

%Calcula el coeficiente de normalizacion
factor_normalizacion = 1/max(abs(respuesta_freq));
%Multiplica el numerador para normalizarlo
numerador_normalizado = numerador*factor_normalizacion;
%Calcula la respuesta en frecuencia normalizada
respuesta_freq_normalizada = freqz(numerador_normalizado, denominador, fm);
%Dibuja
%figure(3); stem(abs(respuesta_freq_normalizada));
%title("Respuesta en frecuencia Normalizada"); xlabel("Frecuencia (Hz.)"); ylabel("|H(z)|");

%%---Inciso D: modificar radio de polos y ver como cambia la respuesta en frecuencia

[ceros2,polos2] = crearRaices(0.85,0.99);
[numerador2, denominador2] = raicesAPolinomio(ceros2,polos2);
respuesta_freq2 = freqz(numerador2,denominador2, fm);
numerador2_n = numerador2/max(abs(respuesta_freq2));
respuesta_freq2 = freqz(numerador2_n,denominador2, fm);
%figure(4); stem(abs(respuesta_freq2));
%title("Respuesta en frecuencia"); xlabel("Frecuencia (Hz.)"); ylabel("|H(z)|");

%%---Inciso E: Generar una señal de 15 y 25 Hz y ver cómo funciona el filtro

%paso de muestreo
T = 1/fm;
t = 0:T:1-T;

%senal de entrada
senal = sin(2*pi*t*15)+sin(2*pi*t*25);

%calculo del espectro de fourier
espectro_senal = fft(senal);

%filtrado con propiedad de multiplicacion en frecuencia = convolucion en tiempo
senal_filtrada = ifft(respuesta_freq.*espectro_senal');

%espectro de la senal filtrada
espectro_senal_filtrada = fft(senal_filtrada);
paso_frecuencia = fm/length(espectro_senal);
escala = [0:paso_frecuencia:length(respuesta_freq)*paso_frecuencia - paso_frecuencia];

%dibuja
figure(5);
title("Aplicación del filtro a una suma de senoidales");
subplot(2,2,1); plot(t,senal,'r');
xlabel("Tiempo"); ylabel("Amplitud");
subplot(2,2,2); stem(escala, abs(espectro_senal),'r');
xlabel("Frecuencia"); ylabel("Magnitud");
subplot(2,2,3); plot(t,real(senal_filtrada),'b');
xlabel("Tiempo"); ylabel("Amplitud");
subplot(2,2,4); stem(escala,abs(espectro_senal_filtrada),'b');
xlabel("Frecuencia"); ylabel("Magnitud");


%%---Inciso F:Repetir inciso E con una frecuencia de muestreo de 120 Hz.

%redefino fm
fm2 = 120;
%recalculo su respuesta en frecuencia
respuesta_freq = freqz(numerador,denominador, fm2,"whole");

%paso de muestreo
T = 1/fm2;
t = 0:T:1-T;

%senal de entrada
senal = sin(2*pi*t*15)+sin(2*pi*t*25);

%calculo del espectro de fourier
espectro_senal = fft(senal);

%filtrado con propiedad de multiplicacion en frecuencia = convolucion en tiempo
senal_filtrada = ifft(respuesta_freq.*espectro_senal');

%espectro de la senal filtrada
espectro_senal_filtrada = fft(senal_filtrada);
paso_frecuencia = fm2/length(espectro_senal);
escala = [0:paso_frecuencia:length(respuesta_freq)*paso_frecuencia - paso_frecuencia];

%dibuja
figure(6);
title("Frecuencia de muestreo de 120 Hz.");
subplot(2,2,1); plot(t,senal,'r');
xlabel("Tiempo"); ylabel("Amplitud");
subplot(2,2,2); stem(escala, abs(espectro_senal),'r');
xlabel("Frecuencia"); ylabel("Magnitud");
subplot(2,2,3);  plot(t,real(senal_filtrada),'b');
xlabel("Tiempo"); ylabel("Amplitud");
subplot(2,2,4); stem(escala,abs(espectro_senal_filtrada),'b');
xlabel("Frecuencia"); ylabel("Magnitud");

pause;
