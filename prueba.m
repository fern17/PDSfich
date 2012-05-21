1;
clear all;
fm = 100;
f = 1;
t = 0:1/fm:1 - 1/fm;
N = length(t);
x = sin(2*pi*f*t);

trans = fft(x);
hold on;
figure(1);
stem(abs(trans));
figure(2);
plot((angle(trans)));

pause;

