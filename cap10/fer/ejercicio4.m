%Defino señal con frecuencia que crezca linealmente
fm = 1000;
T = 1/fm;
t = [0:T:1-T];
pendiente = 8; %define cuanto va a crecer la frecuencia
senal = sin(2*pi*pendiente*fm.*(t.^2)/2);

%Defino la ventana de Gabor
anchoventana = 30;
Tv = 1/(anchoventana/2);
t2 = -1:Tv:1-T;
gabor = exp(-18/2*t2.^2)';

%dibuja el espectrograma
figure(1); plot(senal); title("Senal original"); xlabel("Tiempo"); ylabel("Amplitud");
figure(2); plot(abs(fft(senal))); title("Senal original en Frecuencia"); xlabel("Frecuencia"); ylabel("Magnitud");
figure(3); specgram(senal,length(gabor),fm,gabor,anchoventana/2);

pause;
