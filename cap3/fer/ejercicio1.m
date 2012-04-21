1;
hold off;
clear;
clf;

%parametros para la programacion
plottear1 = true;
plottear2 = false;
plottear3 = false;
plottear4 = false;
plottear5 = true;

%funcion que transforma
function y = fourier_trans(x)
    N = length(x);
    y = fft(x)/N;
    %y = fft(x);
endfunction

function dibujar(figura,x,y,color,titulo,labelx,labely)
    figure(figura);
    stem(x,y,color);
    title(titulo);
    xlabel(labelx);
    ylabel(labely);
endfunction


%senal del enunciado1
function y1 = senal1(A1,A2,f1,f2,phi1,phi2,t)
    y1 = A1*sin(2*pi*f1*t + phi1) + A2*sin(2*pi*f2*t + phi2);
endfunction

%senal del enunciado2
function y2 = senal2(A1,A2,f1,f2,phi1,phi2,K,t)
    y2 = A1*sin(2*pi*f1*t + phi1) + A2*sin(2*pi*f2*t + phi2) + K;
endfunction

%parametros de la discretizacion
t0 = 0;
tf = 1;
Tm = 0.001;
t = t0:Tm:tf-Tm;
fm = 1/Tm;
N = length(t);
%parametros de las senales
A1 = 1;
A2 = 4;
f1 = 10;
f2 = 20;
phi1 = 0;
phi2 = 0;

%===================================FIN PARAMETROS======================================%
%PARTE 1: Generar senal y graficar==================
y1 = senal1(A1,A2,f1,f2,phi1,phi2,t);

%transformo
X1 = fourier_trans(y1);

%calculo magnitudes
mag1 = abs(X1);

%genero un eje mas lindo
ejex1 = 1:length(X1);

%dibuja, si quiero
if (plottear1 == true)
   dibujar(1,ejex1,mag1,'b','Transformada de X1','f','|X(f)|');
end

%PARTE 2: Verificar Parseval========================
%calculo Parseval en tiempo y frecuencia por separado
parseval_tiempo = sum(y1.^2);
parseval_frecuencia = sum(abs(X1).^2)*1*N; %multiplico por N en vez de dividir porque ya dividi al hacer la fft

EPS = 0.000000001; %tolerancia

%Comparo contra un Epsilon definido
if (abs(parseval_tiempo - parseval_frecuencia) < EPS)
    disp("Verifica Parseval")
else
    disp("No verifica Parseval")
end

%PARTE 3: Modificar parametros======================

%Inciso 1: En el grafico se ve que se agrega un pico en f0 de altura K=4.
K = 4;

y2 = senal2(A1,A2,f1,f2,phi1,phi2,K,t);

%transformo
X2 = fourier_trans(y2);

%calculo magnitudes
mag2 = abs(X2);

%genero un eje mas lindo
ejex2 = 1:length(X2);

%dibuja, si quiero
if (plottear2 == true)
    dibujar(2,ejex2,mag2,'r', 'Transformada de X2','f','|X(f)|');
end

%Inciso 2: Se mueve una barrita a f2=11 en vez de f2=20

y3 = senal1(A1,A2,10,11,phi1,phi2,t);
X3 = fourier_trans(y3);
mag3 = abs(X3);
ejex3 = 1:length(X3);
if (plottear3 == true)
    dibujar(3,ejex3,mag3,'g', 'Transformada de X3','f','|X(f)|');
end

%Inciso 3: Se generan un monton de frecuencias ya que el 10.5 se reparte entre los adyacentes..
y4 = senal1(A1,A2,10,10.5,phi1,phi2,t);
X4 = fourier_trans(y4);
mag4 = abs(X4);
ejex4 = 1:length(X4);
if (plottear4 == true)
    dibujar(4,ejex4,mag4,'b', 'Transformada de X4','f','|X(f)|');
end


%Inciso 4: Como no se analiza un periodo entero de la señal, en el espectro de frecuencias aparecen frecuencias
% que no deberian estar alli. Esto se conoce como aliasing.
tf2 = 0.72;
t = t0:Tm:tf2-Tm;
y5 = senal1(A1,A2,f1,f2,phi1,phi2,t);
X5 = fourier_trans(y5);
mag5 = abs(X5);
ejex5 = 1:length(X5);
if (plottear5 == true)
    dibujar(5,ejex5,mag5,'r', 'Transformada de X5','f','|X(f)|');
end

pause;
