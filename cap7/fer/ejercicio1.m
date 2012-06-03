1;
clear all;

N = 1000;
%Genera la senal
x = rand(1,N)-0.5;
coef = [1 -0.3 0.4 -0.2];

%Calcula su respuesta
y = filter([1],coef,x);

%Vector de autocrrelacciones
r = autocov(y);

%orden inicial
orden = 1;

r0 = r(1);

%Criterio de corte
gamma = 0.000001;
TIPO_COMPARACION = 1; %1 para Vp1/Vp, 2 para Akaike

%Vp inicial
Vp = 2;

%Parametros para Akaike
Ne = N;
Ip = 1;


%bucle principal
while(true)
    %obtiene la solucion
    [A,G,Errores] = levinsonDurbin(r,orden);
    %compara el error
    Ep = Errores(orden);
    switch(TIPO_COMPARACION)
        case 1
            Vp1 = Ep/r0;
            if((1 - Vp1/Vp) < gamma) %si el error es chico
                break;
            end
            Vp = Vp1;
        case 2
            I = log(Ep) + 2*orden/Ne; %calcula error segun criterio de Akaike
            if(abs(1 - (I/Ip)) < gamma) %comparacion con paso anterior
                break
            end
            Ip = I;
    end
    %vuelve a iterar
    orden = orden+1;
end

%Calcula su respuesta con los resultados
yaprox = filter([1],A,x);

errores = (abs(y - yaprox));

hold on;

figure(1);
plot(yaprox,'r');
title("Respuesta aproximada con los coeficientes calculados");
xlabel("Tiempo (s)");
ylabel("Respuesta");

figure(2);
plot(y,'b');
xlabel("Tiempo (s)");
ylabel("Respuesta");
title("Respuesta real con los coeficientes reales");

figure(3);
plot(errores)
title("Errores");
xlabel("Tiempo (s)");
ylabel("Valor Absoluto del error");

pause;
