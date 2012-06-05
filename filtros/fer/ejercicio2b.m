
%Calcula la ubicacion de los polos de butterworth, dado N y la frecuencia de corte deseada
function [sm] = polosButterworth(N)
    sm = zeros(1,2*N);
    for i=1:2*N
        sm(i) = exp(j*pi*(N+2*i-1)/(2*N));

    end
endfunction


function [nceros, npolos, nganancia] = pasaBajoAPasaAlto(polos, ganancia, wp)
    nceros = [];
    npolos = [];
    nganancia = ganancia;
    N = length(polos);
    for i=1:N
        polo = polos(i);
        nceros = [nceros 0];
        npolos = [npolos wp/polo];
        nganancia = nganancia * (-1/polo);
    end
endfunction

function zev = evaluarZeta(z, T, polos, ceros, ganancia)
    zev = ganancia;
    s = (2/T)*(1 - z^(-1))/(1 + z^(-1));
    for c = ceros
        zev = zev * (s - c);
    end

    for p = polos
        zev = zev / (s - p);
    end
endfunction


function resp = pasaAltosButter(frec_paso, frec_muestreo, orden)
    polos = polosButterworth(orden);
    ganancia = 1;
    T = 1/frec_muestreo;
    w_nueva = (2/T) * tan(pi*frec_paso*T); % WHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAT
    [ceros, polos, ganancia] = pasaBajoAPasaAlto(polos, ganancia, w_nueva);
    valores = [0:T:1 - T];
    z = exp(j*2*pi*valores);
    for i=1:length(z)
        resp(i) = evaluarZeta(z(i), T, polos, ceros, ganancia);
    end
endfunction

%------

%parametros
frec_paso = 500;
frec_muestreo = 2000;
orden = 10;

resp_frec = pasaAltosButter(frec_paso, frec_muestreo, orden);

%dibuja
nn = length(resp_frec);
T = 1/frec_muestreo;
dff = frec_muestreo/nn;
escala = [0:dff:nn*dff - dff];

figure(1); plot(abs(resp_frec));

pause;
