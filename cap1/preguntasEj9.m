1;

function y = senal(t)
    y = cos(2*pi*10*t);
endfunction

function [x_d, y_d] = muestrear(x0, dx, xf)
    x_d = x0:dx:xf;
    y_d = senal(x_d);
    clf;
    plot(x_d,y_d);
    hold on;
endfunction
frecuencia = 10;
periodo = 1/frecuencia;

x0 = 0;
dx = 0.01;
xf = periodo;

muestrear(x0,dx,xf);
