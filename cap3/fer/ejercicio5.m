clear;
hold off

function y = delta(x)
    N = length(x);
    y = zeros(1,N);
    y(1) = 1;
endfunction

function y = seno(A,f,phi,t)
    y = A*sin(2*pi*f*t+phi);
endfunction

t0 = 0;
tf = 100/2750;
fm = 2750;
Tm = 1/fm;
t = t0:Tm:tf-Tm;
N = length(t);
df = fm/N;

A = 1;
f = 27.5;
phi = 0;

ejef = -fm/2:df:fm/2-df;

y = seno(A,f,phi,t);

Ytrans = fftshift(fft(y)/N);

hold on;
figure(1);
plot(t,y);
plot(t,-0.06*ones(length(t)),'r');

mag = abs(Ytrans);
figure(2);  
stem(ejef,mag);

pause;

