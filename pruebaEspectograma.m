1;
clear all;

dt = 0.001;
t1 = [0:dt:1 - dt];
t2 = [1:dt:2 - dt];
f1 = 100;
f2 = 50;
x1 = sin(2*pi*f1*t1);
x2 = sin(2*pi*f2*t2);
x3 = chirp(t1);
x = [x1 x2];
x = x3;
fm = 50; %tendremos fm/2 valores distintos en frecuencia
ancho = 100;
solapamiento = ceil(ancho/3);
[spec,frecs,tiempo] = specgram(x,ancho,fm,[],solapamiento);
size(spec)
%spec = spec/max(spec(:));
%imagesc(tiempo,frecs,flipud(log(abs(spec))));


pause;
