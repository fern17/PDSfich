clear;
hold off

%Define delta Dirac
function y = delta(x)
    N = length(x);
    y = zeros(1,N);
    y(1) = 1;
endfunction

%Define un seno
function y = seno(A,f,phi,t)
    y = A*sin(2*pi*f*t+phi);
endfunction

%Definicion de ventanas
%Rectangular
function wr = ventanaRectangular(N)
    wr = ones(1,N);
endfunction

%Hanning
function wh = ventanaHanning(N)
    for n=1:N
        wh(n) = 1/2 - 1/2*cos(2*pi*n/N);
    end
endfunction

%Hamming
function wH = ventanaHamming(N)
    for n=1:N
        wH(n) = 27/50 - 23/50*cos(2*pi*n/N);
    end
endfunction

%Bartlett
function wB = ventanaBartlett(N)
    for n=1:N
        if(n <= N/2)
            wB(n) = 2*n/N;
        else
            wB(n) = 2 - 2*n/N;
        end
    end
endfunction

%Blackman
function wk= ventanaBlackman(N)
    for n=1:N
        wk(n) = 21/50 - 1/2*cos(2*pi*n/N) + 2/25*cos(4*pi*n/N);
    end
endfunction

%Definir parametros
t0 = 0;
tf = 1;
fm = 100;
Tm = 1/fm;
t = t0:Tm:tf-Tm;
N = length(t);
df = fm/N;

A = 1;
f = 9;
phi = 0;

ejef = -fm/2:df:fm/2-df;

%Calcula la funcion
y = seno(A,f,phi,t);

%Calcula la ventana
%ventana = ventanaRectangular(N);
%ventana = ventanaHanning(N);
ventana = ventanaHamming(N);
%ventana = ventanaBartlett(N);
%ventana = ventanaBlackman(N);

%redimensiona la ventana, rellenando con ceros si es mas chica que lo que tengo muestreado de la señal
ventana = resize(ventana,1,N); 

%Aplica la ventana multiplicando punto a punto
yventana = y .* ventana;

%Transforma y calcula las magnitudes
Ytrans = fftshift(fft(yventana)/N);
mag = abs(Ytrans);

%Grafica
hold on;

figure(1);
subplot(1,2,1);
plot(t,y,'r');
legend('y original');

subplot(1,2,2);
plot(1:N,ventana,'b');
legend('ventana');

figure(2);
subplot(1,2,1);
plot(t,yventana,'b');
legend('Y Ventaneada');

subplot(1,2,2);
stem(ejef,mag,'r');
legend('Magnitudes');

pause;

