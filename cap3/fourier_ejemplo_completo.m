clear;
hold off;

%parametro que define como voy a dibujar
centrada = false;

%una senal seno
function y = seno(A,f,phi,t)
    y = A*sin(2*pi*f*t + phi);
endfunction

%una senal coseno
function y = coseno(A,f,phi,t)
    y = A*cos(2*pi*f*t + phi);
endfunction

%una onda cuadrada
function y = onda_cuadrada(A,f,phi,t)
    y = sign(senal(A,f,phi,t));
endfunction

%una senal constante, notar que no usa los parametros pero se guardan por compatibilidad
function y = constante(A,f,phi,t)
    y = A*length(t);
endfunction

%calcula la transformada de fourier
function [X,Xshifted,A,F] = fourier_trans(x)
    X = fft(x);                 %transforma
    X = X/(length(x)/2);        %escala
    Xshifted = fftshift(X);     %la centra
    A = abs(X);                 %solo modulos
    F = atan(imag(X)./real(X)); %solo fases
endfunction

function [x] = fourier_trans_inv(X)
    X = X*(length(X)/2);        %le quito la escala que le hice
    x = ifft(X);
endfunction

Tm = 0.01;                      %periodo de muestreo
t0 = 0;                         %t inicial
tf = 1;                         %t final
fm = 1/Tm;                      %muestras por periodo

t = t0:Tm:tf-Tm;                %puntos a muestrear

N = length(t);                  %cantidad de muestras

%Parametros de la señal (Amplitud, Frecuenca y Fase)
A = 1;
f = 1;
phi = 0;

y = 100 + seno(150,8,0,t) + seno(50,14,0,t); %senal del parcialito
%y = onda_cuadrada(A,f,phi,t);
%y = seno(A,f,phi,t);


[X,Xs,Amp,Fases] = fourier_trans(y);        %transforma y guarda los resultados

y_inv = fourier_trans_inv(X);               %antitransformo

if (centrada == true) 
    %eje centrado
    ejex = (-length(X)/2):(length(X)/2-1);  %transforma el ejex para que vaya de -N/2 a N/2-1
else 
    %no centrado
    ejex = 1:length(X);
end


hold on;

%dibuja la senal original
figure(1);
plot(t,y,'b');
title('Senal');

%dibuja las amplitudes
figure(2);
stem(ejex,Amp,'r');
title('Modulo');

%dibuja las fases
%figure(3);
%stem(ejex,Fases,'g');
%title('Fases');

figure(4);
plot(t,y_inv,'y');
title('Transformada Inversa');

pause;

