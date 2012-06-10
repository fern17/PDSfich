function demotf
close all
senal=atoms(256,[50,0.1,10,1;120,0.3,10,1]);

%Descomentar esto para probar con la señal real (no analitica)
%senal=real(senal);

figure;
wignerdist(senal);


figure;
cohendist(senal,0.1);

figure;
cohendist(senal,10);

figure;
cohendist(senal,100);

figure;
windowft(senal,32,1,'Hanning','STFT Hamming');

figure;
windowft(senal,32,1,'Blackman','STFT Blackman');

figure;
windowft(senal,32,1,'Gaussian','STFT Gaussiana');

figure;
spectrogram(senal,32,1,'Espectrograma (usa ventana cuadrada)');

figure;
tocon(senal,1,20,1);  

figure;
[a, d]=todd(senal,ondita('daubechies',6),8);
escalogramad(a,d,length(senal),8); 

%Para ver una ondita y la funcion de escala (solo funciona con 'daubechies'
%orden 1,2,4,5,6
viewwave('daubechies',4);