1;

fm = 100;
dx = 1/fm;
x = 0:dx:1-dx;

f = 4;
phi = 10;
y = sin(2*pi*f*x+phi);
N = length(x);
df = fm/N;


S = fft(y)/N;
stem(atan(imag(S)./real(S)));


if (f*df == floor(f*df))
    muestra = S(f*df)
else
    disp("La fase esta repartida entre los adyacentes");
    muestra = (S(floor(f*df)) + S(ceil(f*df)))/2
end

atan(imag(muestra)/real(muestra))
pause;
