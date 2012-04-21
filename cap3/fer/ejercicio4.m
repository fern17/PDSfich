clear;
hold off;


%Se utiliza la propiedad:
% x[n-i] <=> X[k]*e^(-j*2*pi*k*i/N)

t0 = 0;
tf = 1;
fm = 100;
Tm = 1/fm;
t = t0:Tm:tf - Tm;
t2 = t0:Tm:2*tf-Tm;
retardo = 10;
frec = 4;

y = sign(sin(2*pi*frec*t));

yvacia = zeros(1,length(y));
ylarga = [y yvacia];

Ytrans = fft(ylarga);
N = length(Ytrans);

shifting = e.^(-j*2*pi*frec*retardo/N);
%Ytransshift = Ytrans.*shifting;

for k=1:N
    Ytransshift(k) = Ytrans(k) * e^(-j*2*pi*k*retardo/N);
end
yinversa = ifft(Ytransshift);

hold on;
%figure(1);
%plot(t2,ylarga,'r');
%plot(t2,yinversa,'b');
%legend('y original','y defasada en dominio frec');

%La retardo en el dominio tiempo
y_retardada = sign(sin(2*pi*frec*t+retardo));

%esto se hizo para probar
magnitud = abs(yinversa);
fase = atan(imag(yinversa)./real(yinversa));
yoriginal = magnitud.*e.^(j*fase);
%fin prueba

figure(1);
plot(t,y,'r');
plot(t,y_retardada,'b');
plot(t2,yinversa,'k');
legend('y original','y defasada en dominio tiempo','y defasada en dominio frec');
pause;
