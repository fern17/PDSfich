1;

% Escriba una función que permita realizar la cuantización en P niveles de 
%  una señal de valores tanto positivos como negativos.


function z = cuantizar(x, H)
    z = H*floor(x/H);
endfunction

function yc = cuantizacion(x,y,P)
    n = length(x);
    yc = zeros(n,1);
    maxi = max(y)-min(y);
    H = 2*maxi/(P);
    for i=1:n
        yc(i) = cuantizar(y(i), H);
    end
    plot(x,y,'r');
    hold on;
    plot(x,yc,'b');
    legend('original','cuantizada');
endfunction

x0 = 0;
xn = 0.5;
dx = 0.005;
x = x0:dx:xn-dx;
y = sin(2*pi*x*4);

#yc = cuantizacion(x,y,8);


% Escriba una función que tome como entrada una señal x[n], un ruido r[n], ambos de igual longitud N 
% y un valor de relación señal ruido en decibeles SNR, y permita estimar el valor de una constante alfa 
% tal que la señal resultante y[n] = x[n] + alfa*r[n] tenga una relación señal ruido igual a la deseada, SNR.

function alfa = calculaAlfa(yi,ri,snr)
    potencia_senal = norm(yi,2)^2;
    potencia_ruido = norm(ri,2)^2;
    alfa = sqrt(10^(-snr/10)*potencia_senal/potencia_ruido);
endfunction

xi = 0:0.01:1-0.01;
n = length(xi);
yi = sin(2*pi*x);
ri = randn(1,n);

snr = 25;
alfa = calculaAlfa(yi, ri, snr);
zi = yi + alfa*ri;
plot(xi,zi)
pause
