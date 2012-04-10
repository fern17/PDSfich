1;
entrada = load("te.txt");

function fragmento = trim(senal, xi, xf)
   fragmento = senal(xi:xf);
endfunction

%fragmento = zeros(7, 5001);
fragmento(1,:) = trim(entrada, 16000, 21000);
fragmento(2,:) = trim(entrada, 30000, 35000);
fragmento(3,:) = trim(entrada, 39000, 44000);
fragmento(4,:) = trim(entrada, 48000, 53000);
fragmento(5,:) = trim(entrada, 58000, 63000);
fragmento(6,:) = trim(entrada, 70000, 75000);
fragmento(7,:) = trim(entrada, 80000, 85000);

global freq_vert = [697 770 852 941];
global freq_horiz = [1209 1336 1477];

freq_muestreo = 11025;
t0 = 0;
dt = 1/freq_muestreo;
tf = 0.7;
t = t0:dt:tf-dt;

verticales = length(freq_vert);
horizontales = length(freq_horiz);

numeros = zeros(verticales*horizontales, length(t));

contador = 1;
for i=1:verticales
    for j=1:horizontales
        numeros(contador,:) = sin(2*pi*t*freq_vert(i)) + sin(2*pi*t*freq_horiz(j));
        contador = contador+1;
    end
end
contador = contador - 1;

for k=1:7
    grafico_barra = zeros(10,1);
    for i=1:size(numeros,1)
        n = length(fragmento(k,:));
        num_trimed = numeros(i,1:n);
        grafico_barra(i) = dot(fragmento(k,:), num_trimed);
    end
    maxi = abs(grafico_barra(1));
    idx = 1;
    for l=2:12
        value = abs(grafico_barra(l));
        if(value > maxi)
            maxi = value;
            idx = l;
        end
    end
    resultado(k) = idx;
    if(idx > 9)
        if(idx == 10)
            disp(" *")
        elseif(idx == 11)
            disp(" 0")
        else
            disp(" #")
        end
    else
        disp(idx)
    end
end
pause
%plot(t, numeros(5,:))
