1;

a = [1 2 3];
b = [4 5 6];
N = length(a);

% sumatoria convolucion
y1 = convolucion_lineal(a,b)

% Funcion conv
y2 = conv(a,b)

% La funcion filter
y3 = filter(b,1,a)

% Por propiedad
y4 = ifft(fft(a).*fft(b))

% Agregando ceros
a = [a zeros(1,N-1)];
b = [b zeros(1,N-1)];
y5 = ifft(fft(a).*fft(b))

pause
