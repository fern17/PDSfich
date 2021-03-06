clear all;
clf;
%nventana: id de ventana
%anchoventana: ancho en muestras de ventana
%paso: cantidad de muestras que se mueven las ventanas sucesivas
function espectrograma = espectrograma(senal,nventana = 1, anchoventana = 1, paso = 1)
    switch nventana
    case 1
        ventana = ones(1,anchoventana);
    case 2
        ventana = hanning(anchoventana)';
    case 3
        ventana = hamming(anchoventana)';
    case 4
        ventana = blackman(anchoventana)';
    end
    N = length(senal);
    M = anchoventana;
    cantidadventanas = floor(N/(anchoventana-paso))-1;
%    cantidadventanas = ceil(N/(M-paso+1));
    espectrograma = zeros(ceil(anchoventana/2),cantidadventanas);%la mitad porque guardo solo frecuencias positivas
    for i=1:cantidadventanas
        inicio = (i-1)*paso+1; %inicio de la ventana
        fin = inicio+anchoventana; %fin de la ventana
        if fin > N
            fin = N;
        end
        M = fin-inicio; %ancho efectivo de la ventana
        fragmento = senal(inicio:fin-1) .* ventana(1:M); %ventaneo
        fft_frag = abs(fft(fragmento)); %calcula la transfromada rapida de fourier
        fft_frag = fft_frag(1:ceil(length(fft_frag)/2)); %se queda con potencias positivas
        fft_frag = [fft_frag zeros(1,ceil(anchoventana/2)-length(fft_frag))]; %rellena con ceros si el tamaño es corto
        espectrograma(:,i) = fft_frag.^2; %guarda energia
    end
endfunction

senal = load("te.txt")';
%fm = 10000;
%T = 1/fm;
%t = 0:T:1-T;
%frec = 10;
%senal = sin(2*pi*t*frec);
anchoventana = 256;
paso = anchoventana/2;

spectro1 = espectrograma(senal,2,256,128);
figure(1); imagesc(log(abs(spectro1))); title("Ancho de ventana(Hanning) de 256 muestras"); xlabel("Tiempo"); ylabel("Frecuencia");

spectro2 = espectrograma(senal,2,1024, 512);
figure(2); imagesc(log(abs(spectro2))); title("Ancho de ventana(Hanning) de 1024 muestras"); xlabel("Tiempo"); ylabel("Frecuencia");

spectro3 = espectrograma(senal,2,512, 256);
figure(3); imagesc(log(abs(spectro3))); title("Ancho de ventana(Hanning) de 512 muestras"); xlabel("Tiempo"); ylabel("Frecuencia");

pause;
