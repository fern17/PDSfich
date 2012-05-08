1;

a = [1 2 3];
b = [4 5 6];
N = length(a);
M = length(b);

% sumatoria convolucion
y1 = convolucion_lineal(a,b)

% Funcion conv
y2 = conv(a,b)

% La funcion filter
% Agregamos ceros para que de igual que la lineal
as = [a zeros(1, M-1)];
y3 = filter(b,[1],as)

% Por propiedad
y4 = ifft(fft(a).*fft(b))

% Agregando ceros
a = [a zeros(1,N-1)];
b = [b zeros(1,M-1)];
y5 = ifft(fft(a).*fft(b))

% La ecuacion de la inversa del producto de las transformadas se cumple 
%  cuando a A y B se le agregan N-1 ceros y M-1 de manera que queden de 
%  igual longitud ambas muestras, o cuando se hace la convolucion circular 
%  (pero deben ser iguales).
pause
