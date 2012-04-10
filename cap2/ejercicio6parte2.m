1;

global f =   [1 2 3 4 5 6 7 8 9 10];
global phi = [10 -5 32 21 42 -50 20 0 0.52 100];

function y = senal(t,f,phi)
    y = zeros(length(f), length(t));
    for i=1:length(f)
        y(i,:) = sin(2*pi*f(i)*t + phi(i));
    end
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
dt = 0.1;
tn = 1;

t = t0:dt:tn-dt;

alfa = rand(10,1);
[combinacion, senales] = combinacion_lineal(t, alfa);
%plot(t, combinacion);
%pause;
grafico_barras = zeros(length(f),1);
for i=1:length(f)
    grafico_barras(i) = dot(combinacion(:),senales(i,:));
end

bar(grafico_barras);

