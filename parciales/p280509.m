1;
clear all;
fm = 300;
dt = 1/fm;
t = 0:dt:1 - dt;

s1 = sin(2*pi*100*t);
s2 = 2*sin(2*pi*50*t);

s3 = sin(2*pi*50*t) + 2*sin(2*pi*51*t);

f1 = fft(s1);
f2 = fft(s2);
hold on;
figure(1);
stem(abs(f1)+abs(f2));
figure(2);
stem(abs(fft(s1+s2)));
figure(3);
plot(ifft(f1) + ifft(f2),'r');
plot(ifft(fft(s1+s2)),'b');
figure(4);
plot(s1,'r');
plot(s2,'b');
pause;
