1;
clear;
clf;

%definicion del sistema
function y = sistema(x,y1,y2)
    n = length(x);
    y = zeros(1,n);
    y(1) = y1;
    y(2) = y2;
    for i=3:n
        y(i) = 1/6 * (x(i) - 2*x(i-1) + x(i-2) + 4*y(i-1) - 5*y(i-2));
    end
endfunction

%cantidad de pasos
N = 100;

%definicion de funciones de entrada basicas, escalon e impulso unitario
escalon = ones(1,N)
impulso = zeros(1,N); impulso(1) = 1;

%calculo de las respuestas del sistema
rta_escalon = sistema(escalon,1/6,1/18);
rta_impulso = sistema(impulso,1/6,-2/9);

%convolucion entrada-respuesta
conv_in_rta = conv(escalon,rta_impulso);

hold on;

figure(1);
stem(escalon,'b');
stem(rta_escalon,'r');

figure(2);
stem(impulso,'b');
stem(rta_impulso,'r');

figure(3);
stem(conv_in_rta,'r');

pause;
