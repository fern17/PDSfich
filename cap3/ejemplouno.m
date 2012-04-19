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


# BEGIN OF MARIANITA'S EXAMPLE IN MATHLAB:

function []=signal()
  f1 = 10; f2 = 60;
    T = 0.001;
N = 1000;

t = 0:T:1-T;
% LTI means La tenes Inside. * (ferdy 1990 - 2565)
	y=2*sin(2*pi*f1*t) + sin(2*pi*f2*t) + 10*randn();

 fm=1/T;
 df=fm/N;
 frec=[- (fm/2):df:(fm/2)-df];
 S=fftshift(fft(y)/(N/2));
 subplot(2,1,1);
 plot(t,y, 'y');
 subplot(2,1,2);
 stem(frec,abs(S));
 sumy=sum(y.^2);
 sumS=(1/N)*(sum(abs(S*(N/2)).^2));
 ricura = sumy - sumS
end



