1;

%Evaluo la transformada z en el círculo unitario
%=> Obtengo la respuesta al impulso en frecuencia

Fm = 1000;

% Expresamos la variable compleja z como:
% r*e^(jw) : Pero queremos que tenga módulo 1 y w desde 0 a 2pi
% para que recorra el círculo unitario con paso 1/Fm
w = [0:1/Fm:(2*pi)-1/Fm];
r = 1;
z = r*exp(j*w);
N = length(w);

for i=1:N
	% Ecuacion del ejercicio1
	h(i) = 4 / (4 - 2*z(i)^(-1) + z(i)^(-2) );
end
df = Fm/N;
f = [0:df:(N-1)*df];

figure(1);
stem(f, real(h) ) ; % Porque hay que poner real? Hay algo mal?

%Otra forma de calcular la rta al impulso es con la TDF de un sistema estable

impulso = zeros(1,N);
impulso(1) = 1;

y(1) = impulso(1);
y(2) = impulso(2) + y(1) / 2;

for i=3:N
	y(i) = impulso(i) + y(i-1)/2 - y(i-2)/4;
end

yf = fft(y);

figure(2);
stem(f, real(yf), 'r');