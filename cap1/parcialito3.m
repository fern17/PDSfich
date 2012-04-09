1;

% Escriba el código que permita generar una señal cuadrada periódica de frecuencia dada, con valores entre -1 y 1. 
%  La función debe ser llamada con los siguientes parámetros x=cuadrada(f,t,fm), donde f es la frecuencia de la señal,
%  t es la duración y fm es la frecuencia de muestreo. Luego genera una señal cuadrada de 2 segundos muestreada a 50 Hz. 
%  con frecuencia 5 Hz y contamínela con ruido gaussiano a una SNR de 10 dB.

function x = cuadrada(f, t, fm)
    dx = 1/fm;
    xi = 0:dx:t-dx;
    x = sign(sin(2*pi*f*xi));
endfunction

function z = senalMasRuido(x, senal, snr)
    potencia_senal = norm(senal,2)^2;
    n = length(senal);
    ruido = randn(1,n);
    potencia_ruido = norm(ruido,2)^2;
    alfa = sqrt(potencia_senal*10^(-snr/10)/potencia_ruido);
    z = senal + alfa*ruido;
    plot(x,z);
    pause;
endfunction

f = 5;
t = 2;
fm = 50;
#x = cuadrada(f, t, fm);
snr = 25;
ti = 0:1/fm:t - 1/fm;
#z = senalMasRuido(ti,x,snr);

% Genere el código necesario para verificar la ergodicidad de una senal dada. 
% Suponga que la señal es gaussiana. Explique su algoritmo.

function xbar = getMedia(x)
    xbar = sum(x)/length(x);
endfunction

function S = getVarianza(x, xbar)
    suma = 0;
    n = length(x);
    for i=1:n
        suma = suma + (x(i)-xbar)^2;
    end
    S = suma;
endfunction

function resultado = comprobarNormal(muestras)
    media = getMedia(muestras);
    varianza = getVarianza(muestras, media);
    desvio = sqrt(varianza);
    n = length(muestras);
    contador = 0;
    for i=1:n
        if(abs(muestras(i)-media) < 2*desvio)
            contador = contador + 1;
        end
    end
    if(contador/n >= 0.90)
        resultado = true;
    else
        resultado = false;
    end
endfunction

function resultado = estacionareidad(muestras)
    m = size(muestras,2);
    contador = 0;
    for i=1:m
        if(comprobarNormal(muestras(:,i)))
            contador = contador + 1;
        end
    end
    if (contador/m >= 0.90)
        resultado = true;
    else
        resultado = false;
    end
endfunction

function resultado = ergodicidad(muestras)
    n = size(muestras,1);
    contador = 0;
    for i=1:n
        if(comprobarNormal(muestras(i,:)))
            contador = contador + 1;
        end
    end
    if (contador/n >= 0.90)
        resultado = true;
    else
        resultado = false;
    end
endfunction

function muestras=generaAleatoria(t0, dt, tf,  n)
    t=t0:dt:tf-dt;
    muestras=randn(n,length(t));
endfunction

t0 = 0;
dt = 0.1;
tf = 1;
n = 25;

muestras = generaAleatoria(t0, dt, tf, n);

if (estacionareidad(muestras))
    disp("Es estacionaria")
    if (ergodicidad(muestras))
        disp("Es ergodica")
    else
        disp("No es ergodica")
    end
else
    disp("No es estacionaria")
end

