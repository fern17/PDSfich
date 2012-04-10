1;

global f =   [1 2 3 4 5 6 7 8 9 10];
global phi = [0 0 0 0 0 0 0 0 0 0];

function y = senal(t,f,phi)
    y = zeros(length(f), length(t));
    for i=1:length(f)
        y(i,:) = sin(2*pi*f(i)*t + phi(i));
    end
endfunction

function y = senal_cuadrada(t, f)
    y = sign(sin(2*pi*t*f));
endfunction

function [combinacion,senales] = combinacion_lineal(t, alfa)
    global f;
    global phi;
    senales = senal(t, f, phi);
    combinacion = zeros(length(t),1);
    for i=1:length(t)
        suma = 0;
        for j=1:length(alfa)
            suma = suma+senales(j,i);
        end
        combinacion(i) = suma;
    end

endfunction

t0 = -1;
dt = 0.01;
tn = 1;
fcuadrada = 5.5;
t = t0:dt:tn-dt;

alfa = rand(10,1);
[combinacion, senales] = combinacion_lineal(t, alfa);
%plot(t, combinacion);
%pause;
grafico_barras = zeros(length(f),1);
cuadrada = senal_cuadrada(t, fcuadrada);

for i=1:length(f)
    grafico_barras(i) = dot(cuadrada(:), senales(i,:));
end

%bar(grafico_barras);
plot(t, senales(8,:), 'r');
hold on
plot(t, cuadrada, 'b');

