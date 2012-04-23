clear;
hold off;

%cargo archivo
necg = load('necg.txt');

%Calculo parametros
N = length(necg);
fm = 360;
Tm = 1/fm;
df = fm/N;

%transformo
Tnecg = fft(necg);


%Como se sabe que hay ruido entre B1 = 40 y B2 = 180 Hz, debo poner a cero esas bandas en Tnecg
% para sacar los indices, uso la formula df*B1 y df*B2

%limites donde hay ruido
B1 = 40;
B2 = 180;

%Calculo los indices donde debo borrar
idx1 = floor(df*B1);
idx2 = floor(df*B2);

Tnecgfiltrada = Tnecg;

%Borro toda la frecuencia
for i=idx1:idx2
    Tnecgfiltrada(i) = 0;
end

%Antitransformo y me quedo con la parte real
necgFiltrada = real(ifft(Tnecgfiltrada));

hold on;

figure(1);
%Dibujo las señales antes y despues del filtrado
subplot(2,1,1);
stem(necg,'b');
subplot(2,1,2);
stem(necgFiltrada,'r');

figure(2);
%dibujo los modulos de Fourier antes y despues del filtrado
subplot(2,1,1);
stem(abs(Tnecg),'b');
subplot(2,1,2);
stem(abs(Tnecgfiltrada),'r');

pause;
