clear;
hold off;

function y = senal(A,f,phi,t)
    y = A*sin(2*pi*f*t+phi);
endfunction

t0 = 0;
tf = 1;

fm = 50;

dt = 1/fm;
t = t0:dt:tf-dt;

Tm = tf-t0;
N = length(t)
df = fm/N;

ejex = -floor(fm/2):df:ceil(fm/2)-1;

A = 2;
f = 27;
phi = 0;

y = senal(A,f,phi,t);

Yt = fft(y);
%Yt = fftshift(fft(y)/N)

hold on;
%stem(ejex,abs(Yt));
stem(abs(Yt));

%Inciso 1
%La frecuencia observada es 23 Hz. Es distinta a la señal original porque no se cumple 
% el teorema de muestreo de Nyquist y estamos en presencia de un alias.
% Esto es: la frecuencia de muestreo NO es al menos el doble de la frecuencia original:
% fm > 2*f ? === 50 > 2*27? => False.

%Inciso 2
%Para determinar la frecuencia de la señal obtenida, aplicamos la formula:
% frec_obtenida = mod(abs(fm - f) , fm)

%Inciso 3
%La magnitud de la señal obtenida es 2, ya que el valor es 50 pero:
% A_senal/2*N = A_modulo => 2/2*50 = 50 == 50.
% REVISAR.
pause;
