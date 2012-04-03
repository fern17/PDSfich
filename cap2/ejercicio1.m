1;

function y = senal(x)
    #y = 10*sin(x); #seno
    #y = sign(sin(x));
    #y = randn(length(x),1);
    dx = 1/length(x)
    rampa = 0:dx:1;
    y = rampa;
endfunction



function m = valorMedio(x, y)
    m = sum(y)/length(y);
endfunction

function m = maximo(x, y)
    m = max(y);
endfunction

function m = minimo(x, y)
    m = min(y);
endfunction

function m = amplitud(x, y)
    m = max(abs(y));
endfunction

function m = energia(x, y)
    m = norm(y,2)^2;
endfunction

function m = accion(x, y)
    m = norm(y,1);
endfunction

function m = potenciaMedia(x, y)
    m = norm(y,2)/length(x);
endfunction

function m = rms(x, y)
    m = sqrt(norm(y,2)/length(x));
endfunction

x0 = -5;
xn = 6;
dx = 0.01;

x = x0:dx:xn-dx;
y = senal(x);

valorMedio(x, y)
maximo(x, y)
minimo(x, y)
amplitud(x, y)
energia(x, y)
accion(x, y)
potenciaMedia(x, y)
rms(x, y)
