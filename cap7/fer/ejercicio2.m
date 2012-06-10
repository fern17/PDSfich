%lectura de datos
eeg = load("eeg.txt")';
N = length(eeg);
orden = 8;

%ventanas
ventana = hamming(N)';
eeg = eeg .* ventana;

%calculo del sistema normal
r = xcorr(eeg);
r = r(ceil(length(r)/2):length(r)); %me quedo con una sola parte
[A, G, E, Ep] = levinsonDurbin(r,orden); %identifico el sistema 

%Estimacion del orden
Vp = E/r(1); %calculo los errores normalizados
Vp = Vp(2:length(Vp)); %le quito el primer valor para ver mejor la grafica

Ne = 0.4*N; %ventana efectiva de Hamming
I = zeros(1,length(E));
for p=1:length(E)
    I(p) = log(E(p)) + 2*p/Ne;
end

I = I(2:length(I)); 

hold on;
figure(4);
subplot(2,1,1);
plot(2:1:length(Vp)+1,log(Vp),'r');  %grafica orden contra Vp
title("Comportamiento del orden Vp");  ylabel("Error relativo");
subplot(2,1,2);
plot(2:1:length(I)+1,log(I),'b');    %grafica orden contra Ip
title("Comportamiento del orden Ip"); xlabel("Orden"); ylabel("Error relativo");


%ventanas
ventana = hamming(N)';
%ventana = hanning(N)';

%calculo del sistema ventaneado
eegventana = eeg .* ventana;
rv = xcorr(eegventana);
rv = rv(ceil(length(rv)/2):length(rv));
[Av, Gv, Ev, Epv] = levinsonDurbin(rv,orden);

%calculo de las respuestas en frecuencia
[H,W] = freqz(G,A,N, "whole");
[Hv,Wv] = freqz(Gv,Av,N, "whole");

eeg_frec = fft(eeg);
%eeg_frec = eeg_frec(1:ceil(length(eeg_frec)/2));


%dibujo
hold on;
figure(1); 
stem(abs(eeg_frec),'r'); title("Eeg en frecuencia original"); xlabel("Frecuencia (Hz.)"); ylabel("Magnitud");
figure(2);
stem(abs(H),'b'); title("Eeg aproximado con orden 8"); xlabel("Frecuencia (Hz.)"); ylabel("Magnitud");
%subplot(2,2,2); stem(abs(H - eeg_frec'),'k'); title("Errores en la aproximacion"); xlim([0, 4100]);
figure(3);
stem(abs(Hv),'b'); title("Eeg aproximado con orden 8 y ventaneado"); xlabel("Frecuencia (Hz.)"); ylabel("Magnitud");
%subplot(2,2,4); stem(abs(Hv - eeg_frec'),'k'); title("Errores en la aproximacion (ventaneado)"); xlim([0, 4100]);
pause;
