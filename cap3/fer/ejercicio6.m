clear;
hold off;

%Leo archivos
ecg = load('ecg.txt');
eeg = load('eeg.txt');
emg = load('emg.txt');
presion = load('presion.txt');
respiracion = load('respiracion.txt');
peatc = load('peatc.txt');


%Frecuencias ordenadas segun lectura
frecuencias = [250 250 1300 250 250 10000]; %este lo completo a pata

%Calculo los N
N1 = length(ecg);
N2 = length(eeg);
N3 = length(emg);
N4 = length(presion);
N5 = length(respiracion);
N6 = length(peatc);
%Junto
N = [N1 N2 N3 N4 N5 N6]

%Calculo los df
for i=1:6
    df(i) = frecuencias(i)/N(i);
end


%Transformo
Tecg = abs(fft(ecg));
Teeg = abs(fft(eeg));
Temg = abs(fft(emg));
Tpresion = abs(fft(presion));
Trespiracion = abs(fft(respiracion));
Tpeatc = abs(fft(peatc));


%Calculo los ancho de banda
BW = zeros(1,6);
BW(1) = Tecg(         floor(N(1)/2))    *df(1);
BW(2) = Teeg(         floor(N(2)/2))    *df(2);
BW(3) = Temg(         floor(N(3)/2))    *df(3);
BW(4) = Tpresion(     floor(N(4)/2))    *df(4);
BW(5) = Trespiracion( floor(N(5)/2))    *df(5);
BW(6) = Tpeatc(       floor(N(6)/2))    *df(6);

hold on;

%Los dibujo segun el orden que veo en BW.
% Esto se deberia automatizar pero no veo forma de meter todos los espectros que tienen distinta longitud en un solo vector
stem(Tecg,'b');
stem(Tpresion,'r');
stem(Trespiracion,'g');
stem(Teeg,'c');
stem(Temg,'k');
stem(Tpeatc,'y');

pause;
