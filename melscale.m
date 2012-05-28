1;
%Calcula los coeficientes de Mel para el Mel-frequency Cepstrum
t0 = 0;
tf = 20000;
dt = 1;

f = [t0:dt:tf];

mel = 2595*log10(1+f/700);
mel2 = 1000*log2(1+f/1000);
hold on;
plot(f,mel,'b');
plot(f,mel2,'r');
pause;
