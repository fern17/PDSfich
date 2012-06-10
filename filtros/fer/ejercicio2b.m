
%Calcula la ubicacion de los polos de butterworth, dado N y la frecuencia de corte deseada
function [sm] = polosButterworth(N)
    sm = zeros(1,2*N);
    for i=1:2*N
        sm(i) = exp(j*pi*(N+2*i-1)/(2*N)); %genera los polos según la formula
    end
endfunction

%Convierte un filtro de pasa bajos normalizado a pasa altos
function [nceros, npolos, nganancia] = pasaBajoAPasaAlto(polos, ganancia, wp)
    nceros = [];
    npolos = [];
    nganancia = ganancia;
    N = length(polos);
    for i=1:N
        polo = polos(i);
        nceros = [nceros 0]; %agrega un cero 
        npolos = [npolos wp/polo]; %convierte un polo
        nganancia = nganancia * (-1/polo); %cambia la ganancia
    end
endfunction

%Evalua el polinomio en una posición del círculo unitario
function zev = evaluarZeta(z, T, polos, ceros, ganancia)
    zev = ganancia;
    s = (2/T)*(1 - z^(-1))/(1 + z^(-1)); %transformada bilineal
    for c = ceros
        zev = zev * (s - c);
    end

    for p = polos
        zev = zev / (s - p);
    end
endfunction

%Genera la respuesta en frecuencia para un filtro de Butterworth del orden y frecuencia de paso deseados
function resp = pasaAltosButter(frec_paso, frec_muestreo, orden)
    polos = polosButterworth(orden); %calcula los polos normalizados
    ganancia = 1;
    T = 1/frec_muestreo;
    w_nueva = (2/T) * tan(pi*frec_paso*T); %unwraping por el fenomeno de la transformada bilineal
    [ceros, polos, ganancia] = pasaBajoAPasaAlto(polos, ganancia, w_nueva); %obtiene el filtro deseado
    valores = [0:T:1 - T]; 
    z = exp(j*2*pi*valores); 	%valores a donde evaluar el filtro en Z
    for i=1:length(z)
        resp(i) = evaluarZeta(z(i), T, polos, ceros, ganancia);
    end
endfunction

%------

%parametros
frec_paso = 500;
frec_muestreo = 2000;
orden = 4;

resp_frec = pasaAltosButter(frec_paso, frec_muestreo, orden);

%dibuja
nn = length(resp_frec);
T = 1/frec_muestreo;
dff = frec_muestreo/nn;
escala = [0:dff:nn*dff - dff];

figure(1); plot(abs(resp_frec));
title("Respuesta en frecuencias. Orden 4");
xlabel("Frecuencia (Hz) ");
ylabel("|H_b(z)|");

pause;
