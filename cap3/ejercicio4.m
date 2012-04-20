clear;
hold off;
% El anguo de fase de la transformada de fourier tiene relacion con retardos de la señal cuya fase se modif
% en forma lineal (Proporcional a la frecuencia), experimentará un retardo igual a la pendiente de dicha variacion.
%

Fm = 100;
Tm = 1/Fm;

t = 0:Tm:1-Tm;
s = sign(sin(2*pi*4*t));

N = length(t);
for i=1:N
	s(i+N) = 0;
end

%Redefino el t porque ahora tiene mas muestras
t = 0:Tm:2-Tm;
N = length(t);

S = fft(s);

% Espectro de fase
% y = atan(imag(S) ./ real(S));

% Calculo del desplazamiento:
% Utilizaremos la propiedad de la TDF: x[n-i] <=(F)=> X[k]*e^-(j2piki)/N 
j = sqrt(-1);

for k=1:N
	S_retardada(k) = S(k)*e^( (j*2*pi*k*10) / N);
end

s_corrida = ifft(S_retardada);

length(t)
length(s)
length(s_corrida)
plot(t, s, 'r');
hold on;
plot(t, s_corrida, 'b');