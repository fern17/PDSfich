clear;
clear plot;
hold off;
% El espacio de señales senoidales se define como:
% S = { y / y = A*sin(2*pi*f*t + phi) / A, f, phi pertenece a los Reales }
% En forma compleja:
%  S = {x; x(t) = Re(A*exp(phi+j*2*pi*f*t))} con  -inf<=t<=+inf, phi, A, f belongs \Real

% Pero debemos aclarar que f tiene que ser constante ya que sino, no cumple
% el axioma de cerradura con respecto a la suma por ejemplo la señal 
% s3 = 10*sin(2*pi*10*t + phi )  + 5*sin(2*pi*3*t + phi ) . A pesar de ser
% periodica, No pertenece al conjunto de senoidales.

x0 = -2;
dx = 0.001;
xf = 2;

% Parámetros senal1
A1 = 5;
f1 = 2/3;
phi1 = 0;

% Parametros senal2
A2 = 1;
f2 = 1/3;
phi2 = 3*pi/2;

% 
function y = senal(x,A,f,phi)
    %y = real(A*exp(phi+j*2*pi*f*x));
    y = A*sin(2*pi*f*x + phi);
endfunction

x = x0:dx:xf - dx;
y1 = senal(x,A1,f1,phi1);
y2 = senal(x,A2,f2,phi2);


hold on
plot(x,y1,'r');
plot(x,y2,'b');
plot(x,y1.+y2,'y');
legend('Seno con f1', 'Seno con f2', 'Seno con f1+f2');
