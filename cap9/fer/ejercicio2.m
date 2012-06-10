1;

clear all;

%Umbrales para detectar si el fonema es sordo o sonoro
%obtenidos experimentalmente al analizar la 
global MIN_ENERGIA = 0.8; %energia en la banda de frecuencias altas (N/4~N/2)
global MIN_CRUCES = 60; %30 cruces en 30 ms equivale a una frecuencia de 1000 hz

%Devuelve la cantidad de cruces por cero que tiene la señal
% Mientras mas cruces por unidad de tiempo, mayor frecuencia tiene
function cruza = contar_cruces(senal)
    cruces = sign(senal);
    signo = cruces(1);
    cruza = 0;
    for i=2:length(cruces)
        if(signo == cruces(i)*(-1)) %si el signo es distinto al anterior
            cruza = cruza + 1;
        end
        signo = cruces(i);
    end
endfunction

%Calcula la energia de una senal con autocorrelacion
function energia = calcular_energia(senal)
    trans = abs(fft(senal)); %transforma
    N = length(trans);
    %evaluar = trans(floor(N/4):floor(N/2)); %se queda con el segundo cuarto que pertenece a las frecuencias altas
    energia = sum(trans.^2); %calcula energia en espectro
endfunction

%Devuelve true si el fragmento es sonoro.
function resultado = esSonoro(energia,cruces)
    global MIN_ENERGIA;
    global MIN_CRUCES;
    if(energia >= MIN_ENERGIA) %compara energia, mientras mas, es mas sonoro
        resultado = true;
    else
        if(cruces < MIN_CRUCES) %compara cruces, mientras menos, es mas sonoro
            resultado = true;
        else
            resultado = false;
        end
    end
endfunction

%Calcula el pitch de un fragmento por el metodo de autocorrelacion
function pitch_autocor = pitch_autocorrelacion(fragmento, frec_muestreo)
    autocor = xcorr(fragmento, fragmento);
    M = length(autocor);
    autocor = autocor(ceil(M/2):M);         %le saco la mitad porque esta duplicado
    M = length(autocor);                    %recalculo M
    inicio = ceil((2/1000)*frec_muestreo);  %empiezo a buscar a partir de 2 ms, para saltearme el primer pico.
    [maximo idx] = max(autocor(inicio:M));  %encuentro el indice del maximo
    pitch_autocor = (frec_muestreo/(idx+inicio));
endfunction

%Calcula el pitch de un fragmento por el metodo de cepstrum
function pitch_cep = pitch_cepstrum(fragmento, frec_muestreo)
    frec_inicio_busqueda = 400; %busco el pitch a partir de 400 Hz.
    inicio = frec_muestreo/frec_inicio_busqueda;

    cep = fragmento(1:floor(length(fragmento)/2)); %le quito la mitad porque es simetrico
    M = length(cep);

    [maximo idx] = max(cep(inicio:M)); %me quedo con el indice (frecuencia) maximo pico
    pitch_cep = (frec_muestreo/(inicio+idx)); %le sumo el desplazamiento y convierto a frecuencia
end


function [pitchs_cep, pitchs_autocor] = calcularPitch(frase, frec_muestreo);
    N = length(frase);
    %Configuracion de la ventana a utilizar
    ancho_ms = 30;                                  %ancho en milisegundos de la ventana
    ancho_ventana = ancho_ms*frec_muestreo/1000;    %ancho en muestras de la ventana
    ventana = hanning(ancho_ventana);               %definicion de la ventana

    %calculo de los pitchs
    pitchs_cep = [];
    pitchs_autocor = [];

    for i=1:ceil(N/ancho_ventana)
        inicio = (i-1)*ancho_ventana + 1;           %inicio de la ventana a procesar
        fin = ancho_ventana*i;                      %fin de la ventana
        fragmento = frase(((i-1)*ancho_ventana + 1):min(ancho_ventana*i,N)); %calcula fragmento
        if(length(fragmento) < ancho_ventana)       %termino de recorrer cuando la ventana es chica
            break;
        end;
        fragmento_v = fragmento .* ventana;         %ventanea fragmento
        energia = calcular_energia(fragmento_v);
        cruces = contar_cruces(fragmento_v);
        
        if(esSonoro(energia,cruces))
            cep = (ifft(log(abs(fft(fragmento_v)))));
            pitchs_cep = [pitchs_cep pitch_cepstrum(cep, frec_muestreo)];
            pitchs_autocor = [pitchs_autocor pitch_autocorrelacion(fragmento_v', frec_muestreo)];
        else
            pitchs_cep = [pitchs_cep 0];
            pitchs_autocor = [pitchs_autocor 0];
        end
    end

endfunction

%devuelve la frase con una relacion senal ruido dada por snr
function frase_ruido = contaminarRuido(frase, snr)
   N = length(frase);
   ruido = randn(N,1);
   potencia_frase = norm(frase,2)^2/N;
   potencia_ruido = norm(ruido,2)^2/N;
   alfa = sqrt(potencia_frase*(10^(-snr/10))/potencia_ruido);
   frase_ruido = frase + alfa*ruido;
endfunction

%filtra los pitchs mayores a 350 y menores a 50
function pitchs_filtrados = filtrarBajosAltos(pitchs)
    pitchs_filtrados = [];
    for i=1:length(pitchs)
        if(pitchs(i) >= 50 & pitchs(i) <= 350)
            pitchs_filtrados = [pitchs_filtrados pitchs(i)];
        else
            pitchs_filtrados = [pitchs_filtrados 0];
        end
    end
endfunction

%-----------------------------------------------

%Carga el audio
frec_muestreo = 8000;
frase = load("sent.txt");
frase = frase(125:length(frase)); %quita todos los ceros del principio

frases = [frase contaminarRuido(frase,50) contaminarRuido(frase,20) contaminarRuido(frase,0)];

%Calcula el pitch con dos metodos distintos
[pitchs_cep100, pitchs_autocor100]  = calcularPitch(frases(:,1), frec_muestreo);
[pitchs_cep50, pitchs_autocor50]    = calcularPitch(frases(:,2), frec_muestreo);
[pitchs_cep20, pitchs_autocor20]    = calcularPitch(frases(:,3), frec_muestreo);
[pitchs_cep0, pitchs_autocor0]      = calcularPitch(frases(:,4), frec_muestreo);

%Proceso de filtrado
pitchs_filtrados_cep100 = filtrarBajosAltos(pitchs_cep100);
pitchs_filtrados_cep50  = filtrarBajosAltos(pitchs_cep50);
pitchs_filtrados_cep20  = filtrarBajosAltos(pitchs_cep20);
pitchs_filtrados_cep0   = filtrarBajosAltos(pitchs_cep0);

pitchs_filtrados_autocor100 = filtrarBajosAltos(pitchs_autocor100);
pitchs_filtrados_autocor50  = filtrarBajosAltos(pitchs_autocor50);
pitchs_filtrados_autocor20  = filtrarBajosAltos(pitchs_autocor20);
pitchs_filtrados_autocor0   = filtrarBajosAltos(pitchs_autocor0);

M1 = length(pitchs_autocor100);
x1 = 0:M1-1;
M2 = length(pitchs_cep100);
x2 = 0:M2-1;

%Dibuja
hold on;
%   figure(1); specgram(frase); title("Espectrograma");
%   figure(2); plot(frase); title("Frase");
%   figure(3); plot(pitchs_cep); title("Pitchs por cepstrum");
%   figure(4); plot(pitchs_autocor); title("Pitchs por autocorrelacion");
figure(5); specgram(frases(:,1)); title("Espectrograma para senal sin ruido");
figure(6); specgram(frases(:,2)); title("Espectrograma para SNR = 50");
figure(7); specgram(frases(:,3)); title("Espectrograma para SNR = 20");
figure(8); specgram(frases(:,4)); title("Espectrograma para SNR = 0");

%figure(2); stem(energias)
hold on;
figure(1); 
subplot(2,1,1); plot(x1,pitchs_filtrados_autocor100,'b'); title("Pitch por Autocorrelacion. Sin ruido"); ylabel("Pitch"); ylim([50, 400]);
subplot(2,1,2); plot(x2,pitchs_filtrados_cep100,'r'); title("Pitch por Cepstrum. Sin ruido"); xlabel("Tiempo"); ylabel("Pitch"); ylim([50, 400]);

figure(2); 
subplot(2,1,1); plot(x1,pitchs_filtrados_autocor50,'b'); title("Pitch por Autocorrelacion. SNR = 50"); ylabel("Pitch"); ylim([50, 400]);
subplot(2,1,2); plot(x2,pitchs_filtrados_cep50,'r'); title("Pitch por Cepstrum. SNR = 50"); xlabel("Tiempo"); ylabel("Pitch"); ylim([50, 400]);

figure(3); 
subplot(2,1,1); plot(x1,pitchs_filtrados_autocor20,'b'); title("Pitch por Autocorrelacion. SNR = 20"); ylabel("Pitch"); ylim([50, 400]);
subplot(2,1,2); plot(x2,pitchs_filtrados_cep20,'r'); title("Pitch por Cepstrum. SNR = 20"); xlabel("Tiempo"); ylabel("Pitch"); ylim([50, 400]);

figure(4); 
subplot(2,1,1); plot(x1,pitchs_filtrados_autocor0,'b'); title("Pitch por Autocorrelacion. SNR = 0"); ylabel("Pitch"); ylim([50, 400]);
subplot(2,1,2); plot(x2,pitchs_filtrados_cep0,'r'); title("Pitch por Cepstrum. SNR = 0"); xlabel("Tiempo"); ylabel("Pitch"); ylim([50, 400]);

pause;
