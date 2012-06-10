1;
clear all;

N = 1000;
%Genera la senal
x = randn(1,N)-0.5;
coef = [1 -0.3 0.4 -0.2]

%Calcula su respuesta
y = filter([1],coef,x);
y = y .* hamming(length(y))';

%Vector de autocorrelacciones
r = xcorr(y); %lo da simetrico
r = r(ceil(length(r)/2):length(r)); %me quedo con una sola parte

%orden inicial
orden = 2;

%me quedo con el primer valor
r0 = r(1);

%Criterio de corte
gamma = 0.01;
TIPO_COMPARACION = 2; %1 para Vp1/Vp, 2 para Akaike

%Vp inicial
Vp = 2;

%Parametros para Akaike
Ne = 0.4*N;
Ip = 9999999;

Vp = zeros(1,10);
I = zeros(1,10);
for i=1:10
   [A,G,Errores,Ep] = levinsonDurbin(r,i);
   Vp(i) = Ep/r0    
   I(i) = log(Ep) + 2*i/Ne %calcula error segun criterio de Akaike
end
hold on;

[A,G,Errores,Ep] = levinsonDurbin(r,6);
A
yaprox = filter([1],A,x);
figure(4);
plot(yaprox);

figure(1); plot(Vp,'r'); 
plot(I,'b'); hold off;
title("Criterios de errores");
legend("Vp","Ip");
xlabel("orden");
ylabel("Amplitud relativa");
pause;
%bucle principal
while(true)
    %obtiene la solucion
    [A,G,Errores,Ep] = levinsonDurbin(r,orden);
    %compara el error
    switch(TIPO_COMPARACION)
        case 1
            Vp1 = Ep/r0
            if(abs(1 - Vp1/Vp) < gamma) %si el error es chico
                break;
            end
            Vp = Vp1;
        case 2
            I = log(Ep) + 2*orden/Ne; %calcula error segun criterio de Akaike
            if( I > Ip)
                break
            end
            Ip = I;
    end
    %vuelve a iterar
    orden = orden+1;
end
orden
A

%Calcula su respuesta con los resultados
yaprox = filter([1],A,x);
errores = (abs(y - yaprox));

hold on;
figure(1); plot(yaprox,'r'); title("Respuesta aproximada con los coeficientes calculados"); xlabel("Tiempo (s)"); ylabel("Respuesta"); 
figure(2); plot(y,'b'); xlabel("Tiempo (s)"); ylabel("Respuesta"); title("Respuesta real con los coeficientes reales");
figure(3); plot(errores); title("Errores"); xlabel("Tiempo (s)"); ylabel("Valor Absoluto del error");

pause;
