1;
%pasa alto a 500 hertz

fc = 500; %frecuencia de corte
tolerancia = 50;
fr = fc-tolerancia; %frecuencia de rechazo
fp = fc+tolerancia; %frecuencia de paso
fm = 2000; %frecuenta de muestreo

%conversion a radianes
wc = fc;
wr = fr;
wp = fp;

lambda = 100; 
epsilon = 0.01;
A = lambda/epsilon;
K0 = wp/wr;

dw = 1;
w = 0:dw:fm-dw;

N = ceil(abs(log(A)/log(1/K0))) %por que le pusimos un abs ?? daba negativo si no!
P = 1;
%Q = 1 .+ epsilon^2 * (w./wp).^(2*N); 
Q = 1 .+ epsilon^2 * (wp./w).^(2*N); %se pone wp/w en vez de w/wp porque es un pasa alto, no un pasa bajo

H = P ./ Q;
M = length(H);
df = fm/M;

escala = 0:df:M*df-df;

hold on;
stem(escala,H);
stem(500,0.5,'r');
pause;
