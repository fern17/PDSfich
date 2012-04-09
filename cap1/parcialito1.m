1;
%Realice el código para implementar una interpolación de orden 1 de una señal x[n]. 
% Para tal fin, no está permitido usar las funciones interp o interp1 de Matlab. 
% El usuario debe poder especificar la frecuencia de muestreo original y la de destino.


function y = senal(x)
    y = sin(2*pi*3*x);
endfunction

function y = interp_lineal(x)
    if (abs(x) < 1)
        y = 1 - abs(x);
    else
        y = 0;
    end
endfunction

function yc = interpola(x0, xn, fo, fi)
    intervalo = xn-x0;
    dx = 1/fo;
    xd = x0:dx:xn-dx;
    yd = senal(xd);

    T = 1/fi;
    
    dx2 = 1/fi;
    xc = x0:dx2:xn - dx2;
    n = length(xd);
    m = length(xc);
    yc = zeros(m,1); 
    for j=1:m
        suma = 0;
        for i=1:n
            arg = (xc(j) - xd(i))/T;
            suma = suma + yd(i)*interp_lineal(arg);
        end
        yc(j) = suma;
    end
    stem(xd,yd,'r');
    hold on;
    plot(xc,yc,'b');
    hold on;
    legend('Discreta','Continua');
endfunction

x0 = 0;
xn = 2*pi;
fo = 20;
fi = 10;

yc = interpola(x0, xn, fo, fi);

%====================================
% La frecuencia de la señal que se queria muestrear era de 4000 Hz. Esto quiere decir que tiene 4000 ciclos por segundo. 
%  Sin embargo, la frecuencia de muestreo utilizada es de 129 Hz, que es muy inferior a los 4000 originales.
%  Es por ello que la señal reconstruida poco tiene que ver con la original, ya que se perdio muchísima informacion en el muestreo.
%  La señal recostruida es totalmente diferente a la original.

