1;
x = 0:0.001:2*pi;
f = 1;
phi = 10;

y = sin(2*pi*f*x+phi);
S = fft(y);
fases = atan(-imag(S)./real(S));
maxi = max(abs(fases))


