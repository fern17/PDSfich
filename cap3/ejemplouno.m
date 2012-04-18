# TDF de una funcion senoidal de f=10 Hz durante 1 s con 200 muestras
# Representaci ́n est ́ndar y centrada.


clear;
hold off;
#
T=1;
# Periodo de tiempo total muestreado
N=200;
# Numero de muestras
freq=10;
# Frecuencia de la entrada en Hz
#
#
W=2*pi*freq;
# frecuencia de la senal (en rad/s)

t=T*[0:N-1]/N;
# Escala de tiempo
f=(2*pi/T)*[0:N-1];
# Escala en frecuencia
x1=sin(W*t);
y1=fft(x1)
# T. de Fourier
f=(2*pi/T)*[-N/2:N/2-1];
# Escala en frecuencia
y1s=fft(x1);
# T. de Fourier
y1s=fftshift(y1s);
#gset term post landscape
#gset output "salida1b.ps"
#plot(f,abs(y1),';Transformada estandar;');
S=sqrt(real(y1).^2+imag(y1).^2);
stem([0:length(S)-1],S);
hold on;
pause;
#plot(f,abs(y1s),';Transformada centrada;');
pause;
