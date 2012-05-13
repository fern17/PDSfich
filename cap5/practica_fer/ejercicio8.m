1;

clear all;

pb = load('pb100.txt');
pb = pb';

fm = 1000;

%filtro pasa bajos con frecuencia de corte fc=100
fc = 100;

dt = 1/fm;
t0 = 0;
tf = 0.1;

t = [t0:dt:tf-dt];
N = length(t);
M = length(pb);

fs = [50 75 100 125 150];

senos = sin(2*pi*fs'*t);

fr = 300; %frecuencia del ruido

%ruido para entrada
ruido = rand(1,N).*sin(2*pi*fr*t);


entrada = sum(senos);

%entrada = entrada.+ruido; %suma ruido en la entrada

salida = conv(entrada,pb); %salida filtrada

%ruido para salida
ruido = rand(1,N).*sin(2*pi*fr*t);
ruido = [ruido ruido(1,1:(M-1))];

salida = salida+ruido; %suma ruido en la salida

entrada_d = deconv(salida,pb);

hold on;
figure(1);
stem(entrada,'b');
figure(2);
stem(entrada_d,'r');
figure(3);
stem(ruido);
pause;
