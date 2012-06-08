1;

clear all;

%Umbrales para detectar si el fonema es sordo o sonoro
%obtenidos experimentalmente al analizar la 
global MIN_ENERGIA = 0.6; %energia en la banda de frecuencias altas (N/4~N/2)
global MIN_CRUCES = 30; %30 cruces en 30 ms equivale a una frecuencia de 1000 hz

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
    evaluar = trans(floor(N/4):floor(N/2)); %se queda con el segundo cuarto que pertenece a las frecuencias altas
    energia = sum(evaluar.^2); %calcula energia en espectro
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
function pitch_cep = pitch_cepstrum(cep, frec_muestreo)
    frec_inicio_busqueda = 400; %busco el pitch a partir de 400 Hz.
    inicio = frec_muestreo/frec_inicio_busqueda;

    cep = cep(1:floor(length(cep)/2)); %le quito la mitad porque es simetrico
    M = length(cep);

    [maximo idx] = max(cep(inicio:M)); %me quedo con el indice (frecuencia) maximo pico
    pitch_cep = (frec_muestreo/(inicio+idx)); %le sumo el desplazamiento y convierto a frecuencia
end

%Calculo del pitch con el metodo del cepstrum
function pitchs_cep = calcularPitchCepstrum(frase, ventana, frec_muestreo)
    N = length(frase);
    ancho_ventana = length(ventana);
    pitchs_cep = [];
    
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
        else
            pitchs_cep = [pitchs_cep 0];
        end
    end
endfunction

%Calculo del pitch con el metodo de la autocorrelacion
function [pitchs_autocor, energias] = calcularPitchAutocorrelacion(frase, ventana, frec_muestreo)
    N = length(frase);
    ancho_ventana = length(ventana);
    pitchs_autocor = [];
    energias = [];
    for i=1:ceil(N/ancho_ventana)
        inicio = (i-1)*ancho_ventana + 1; %inicio de la ventana a procesar
        fin = ancho_ventana*i; %fin de la ventana
        fragmento = frase(((i-1)*ancho_ventana + 1):min(ancho_ventana*i,N)); %calcula fragmento
        
        if(length(fragmento) < ancho_ventana) %termino de recorrer cuando la ventana es chica
            break;
        end;
        fragmento_v = fragmento .* ventana; %ventanea fragmento
        
        energia = calcular_energia(fragmento_v);
        cruces = contar_cruces(fragmento_v);
        energias = [energias energia]; 
        if(esSonoro(energia,cruces))
            pitchs_autocor = [pitchs_autocor pitch_autocorrelacion(fragmento_v', frec_muestreo)];
        else
            pitchs_autocor = [pitchs_autocor 0];
        end
    end
endfunction

function [pitchs_cep, pitchs_autocor, energias] = calcularPitch(frase, frec_muestreo);
    N = length(frase);
    %Configuracion de la ventana a utilizar
    ancho_ms = 30;                                  %ancho en milisegundos de la ventana
    ancho_ventana = ancho_ms*frec_muestreo/1000;    %ancho en muestras de la ventana
    ventana = hanning(ancho_ventana);               %definicion de la ventana

    %calculo de los pitchs
    pitchs_cep = calcularPitchCepstrum(frase, ventana, frec_muestreo);
    [pitchs_autocor, energias] = calcularPitchAutocorrelacion(frase, ventana, frec_muestreo);
    
    endfunction

%-----------------------------------------------

%Carga el audio
frec_muestreo = 8000;
frase = load("sent.txt");
frase = frase(125:length(frase)); %quita todos los ceros del principio

%Calcula el pitch con dos metodos distintos
[pitchs_cep, pitchs_autocor, energias] = calcularPitch(frase, frec_muestreo);

%Filtra
pitchs_filtrados_cep = [];
for i=1:length(pitchs_cep)
    if(pitchs_cep(i) >= 50 & pitchs_cep(i) <= 400)
        pitchs_filtrados_cep = [pitchs_filtrados_cep pitchs_cep(i)];
    else
        pitchs_filtrados_cep = [pitchs_filtrados_cep 0];
    end
end

pitchs_filtrados_autocor = [];
for i=1:length(pitchs_autocor)
    if(pitchs_autocor(i) >= 50 & pitchs_autocor(i) <= 400)
        pitchs_filtrados_autocor = [pitchs_filtrados_autocor pitchs_autocor(i)];
    else
        pitchs_filtrados_autocor = [pitchs_filtrados_autocor 0];
    end
end

M1 = length(pitchs_autocor);
x1 = 0:M1-1;
M2 = length(pitchs_cep);
x2 = 0:M2-1;

%Dibuja
hold on;
%   figure(1); specgram(frase); title("Espectrograma");
%   figure(2); plot(frase); title("Frase");
%   figure(3); plot(pitchs_cep); title("Pitchs por cepstrum");
%   figure(4); plot(pitchs_autocor); title("Pitchs por autocorrelacion");


%figure(2); stem(energias)
hold on;
figure(1); 
subplot(2,1,1);
stem(x1,pitchs_filtrados_autocor,'b');
ylim([50, 400]);
subplot(2,1,2);
stem(x2,pitchs_filtrados_cep,'r');
ylim([50, 400]);
pause;
