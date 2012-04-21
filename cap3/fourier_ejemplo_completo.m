clear;
hold off;

%parametro que define como voy a dibujar
centrada = true;
dibuja_shifted = true;

%parametros para dibujar
dibuja_senal = false;
dibuja_ifft = false;
dibuja_modulo = true;
dibuja_fase = false;

%una senal seno
function y = seno(A,f,phi,t)
    y = A*sin(2*pi*f*t + phi);
endfunction

%una senal coseno
function y = coseno(A,f,phi,t)
    y = A*cos(2*pi*f*t + phi);
endfunction

%una onda cuadrada
function y = onda_cuadrada(A,f,phi,t)
    y = sign(seno(A,f,phi,t));
endfunction

%una senal constante, notar que no usa los parametros pero se guardan por compatibilidad
function y = constante(A,f,phi,t)
    y = A*ones(length(t),1);
endfunction

%dibuja un pulso de modulo A entre [t0,tf]
function y = pulso(A,t0, dt, tf, t)
    n = length(t);
    y = zeros(n,1);
    for i=1:n
        idx = i*dt;
        if ((idx >= t0) && (idx <= tf))
            y(i) = A;
        end
    end
endfunction


%calcula la transformada de fourier
function [X,Xshifted,A,F] = fourier_trans(x)
    X = fft(x);                 %transforma
    X = X/(length(x));          %escala
    Xshifted = fftshift(X);     %la centra
    A = abs(X);                 %solo modulos
    F = atan(imag(X)./real(X)); %solo fases
endfunction

function [x] = fourier_trans_inv(X)
    X = X*(length(X));        %le quito la escala que le hice
    x = ifft(X);
endfunction

fm = 129;                      %muestras por periodo
Tm = 1/fm;                      %periodo de muestreo
t0 = 0;                         %t inicial
tf = 1;                         %t final
t = t0:Tm:tf-Tm;                %puntos a muestrear

N = length(t);                  %cantidad de muestras

df = fm/N;
%Parametros de la señal (Amplitud, Frecuenca y Fase)
A = 1;
f = 4000;
phi = 0;

%y = 200 + seno(300,8,0,t) + seno(100,14,0,t); %senal del parcialito
y = seno(A,f,phi,t);
%y = onda_cuadrada(A,f,phi,t);
%y = coseno(A,f,phi,t);
%y = constante(A,f,phi,t);
%y = seno(A,f,phi,t) + seno(A/2,3*f,phi,t);
%y = pulso(A,t0,Tm,0.35,t);

[X,Xs,Amp,Fases] = fourier_trans(y);        %transforma y guarda los resultados

y_inv = fourier_trans_inv(X);               %antitransformo

if (centrada == true) 
    %eje centrado
    ejex = (-floor(fm/2):df:ceil(fm/2)-1);  %transforma el ejex para que vaya de -N/2 a N/2-1
else 
    %no centrado
    ejex = 1:length(X);
end


hold on;

if (dibuja_senal == true) %dibuja la senal original
    figure(1);
    plot(t,y,'b');
    title('Senal');
end

if (dibuja_modulo == true) %dibuja las amplitudes
    figure(2);
    if (dibuja_shifted == true)
        Amp = abs(Xs);
    end
    stem(ejex,Amp,'r');
    title('Modulo');
end

if (dibuja_fase == true) %dibuja las fases
    figure(3);
    if (dibuja_shifted == true)
        Fases = atan(imag(Xs),real(Xs));
    end
    stem(ejex,Fases,'r');
    title('Fases');
end

if (dibuja_ifft == true) %dibuja la inversa
    figure(4);
    plot(t,y_inv,'y');
    title('Transformada Inversa');
end
pause;

