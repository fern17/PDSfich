hold off;
clear;

%Ejercicio 1.
function z = interpolar(x,B)
    N = 4;
    alfas = zeros(1,4);
    z = zeros(1,length(x));
    for i=1:N
        alfa(i) = dot(x,B(i,:))/dot(B(i,:),B(i,:));
        z = z + alfa(i)*B(i,:);
    end
    
endfunction

t = 0:0.01:1-0.01;
N = length(t);
B = zeros(4,N);
for i=1:4
    B(i,:) = sin(2*pi*i*t);
end

x = [-ones(1,N/2) ones(1,N/2)];

z = interpolar(x,B);

hold on;
plot(t,z);



%Ejercicio 2. Respuesta: d porque la a,b,c dan amplitud distinta
t0 = 0;
tf = 1;

fm = 20;
Tm = 1/fm;

t = t0:Tm:tf-Tm;
N = length(t);

df = fm/N;

a = 2;
b = 3;
f1 = 5;
f2 = 12;

y = a*sin(2*pi*f1*t) + b*sin(2*pi*f2*t);

Yt = fft(y);
hold on;
%stem(abs(Yt));
pause;
