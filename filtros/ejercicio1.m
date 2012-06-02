2;
rp = 0.95;
rz = 0.8;
polos = [rp*exp(j*pi/4); rp*exp(j*-pi/4); rp*exp(j*pi/4); rp*exp(j*-pi/4)];
ceros = [rz*exp(j*pi/6); rz*exp(j*-pi/6); rz*exp(j*1/3*pi); rz*exp(j*-1/3*pi)];

%zplane(ceros, polos);

function h = transferencia(z,p,c)
    N = length(c);
    h1 = 1;
    for i=1:N
        h1 = h1*(z-c(i));
    end
    M = length(p);
    h2 = 1;
    for i=1:M
        h2 = h2*(z-p(i));
    end
    h = h1/h2;

endfunction

function [z,p] = normalizar(ceros, polos)
    N = length(ceros);
    M = length(polos);
    for i=1:N
        ceros(i) = ceros(i)/abs(ceros(i));
    end
    for i=1:M
        polos(i) = polos(i)/abs(polos(i));
    end
    z = ceros;
    p = polos;
endfunction

fm = 120;
df = 1/fm;
%t = [0:df:1-df];

w = [0:df:2*pi-df];
t = w;
fourier = exp(-j*w); %nosotros

%fourier = exp(j*t*2*pi); %escudero89

N = length(fourier);
dff = fm/N;

%[ceros,polos] = normalizar(ceros,polos);

h = zeros(1,length(fourier));
for i=1:length(fourier)
    h(i) = transferencia(fourier(i),polos,ceros);
end


h_norm = h/max(h); %normaliza

escala = [0:dff:length(h)*dff - dff];

senal = sin(2*pi*15*t) + 2*sin(2*pi*25*t);
y = real(ifft(fft(senal).*h_norm));
%y2 = conv(senal,real(ifft(h_norm)));

hold on;
figure(1);
stem(escala,abs(h_norm));
%figure(2);
%respuesta = freqz(ceros,polos,200,"whole");
%stem(abs(respuesta));
%stem(real(y));
figure(3);
plot(t,senal,'b');
figure(4);
plot(t,y,'g');
%figure(5);
%plot(y2,'w');

figure(6);
stem(abs(fft(senal)),'b');
figure(7);
stem(abs(fft(y)),'g');
%figure(8);
%stem(abs(fft(y2)),'w');


pause;
