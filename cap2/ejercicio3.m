1;
% El espacio de señales senoidales se define como:
% S = { y / y = A*sin(2*pi*f*t + phi) / A, f, phi pertenece a los Reales }

x0 = -1;
dx = 0.001;
xf = 2;
% Parámetros senal1
A1 = 2;
f1 = 8;
phi1 = 0;

% Parametros senal2
A2 = 2;
f2 = 8;
phi2 = 0;

% 
function y = senal(x,A,f,phi)
    y = A*sin(2*pi*f*x + phi);
endfunction

x = x0:dx:xf - dx;
y1 = senal(x,A1,f1,phi1);
y2 = senal(x,A2,f2,phi2);
disp("Producto Punto")
parecido = dot(y1, y2)


clf;
clear plot;
figure(1);
plot(x,y1,'r');
hold on
plot(x,y2,'b');


% Podemos observar que si tienen frecuencia distinta el valor del
% producto punto es chico y negativo, en cambio si las señales tienen la misma frecuencia
% y por lo tanto son iguales, el valor del producto punto es grande y positivo.