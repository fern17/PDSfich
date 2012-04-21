1;
clear;
hold off;
clf;
t0 = 0;
tf1 = 1;
tf2 = 2;
Tm = 0.01;
n1 = t0:Tm:tf1 - Tm;
n2 = t0:Tm:tf2 - Tm;
N1 = length(n1);
N2 = length(n2);

%Las frecuencias deben tener esta forma para ser periodicas: omega_k = 2*pi*k/N con 0 <= k <= N-1 donde 
%  N: cantidad de muestras
%  k: exponencial numero k

%Defino los K
k1 = 3;%esta cumple la formula de omega
k2 = 2.5; %esta no cumple la formula de omega

%Calculo los phi para n entre 0 y 1
omega_ok    = 2*pi*k1/N1;
omega_wrong = 2*pi*k2/N1; 

phi_ok = e.^(j*omega_ok*n1);
phi_wrong = e.^(j*omega_wrong*n1);

%Calculo los phi para n entre 0 y 2 (inciso 2)
omega_ok_2   = 2*pi*k1/N2;
omega_wrong_2 = 2*pi*k2/N2; 

phi_ok_2 = e.^(j*omega_ok_2*n2);
phi_wrong_2 = e.^(j*omega_wrong_2*n2);

%Inciso 1:

%concateno
phi_doble = [phi_ok,phi_wrong];

hold on;
figure(1);
stem3(n2, real(phi_ok_2), imag(phi_ok_2),'b');
stem3(n2, real(phi_wrong_2), imag(phi_wrong_2),'g');
stem3(n2, real(phi_doble), imag(phi_doble),'r');

pause;

