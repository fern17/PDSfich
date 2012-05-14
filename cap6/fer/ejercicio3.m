1;
clear all;

function y = h(z)
    y = zeros(1,length(z));
    r3 = sqrt(3)/2;
    for i=1:length(z)
        y(i) = ( (z(i) - (0.5+r3*j)) * (z(i) - (0.5-r3*j)) ) / ( (z(i) - 0.5) * (z(i) - 0.2));
    end
endfunction

fm = 1000;
r = 1;

w = [0:1/fm:2*pi-1/fm];
z = r*e.^(j*w);

resp_freq = h(z);
%esto esta muy mal :). Revisar antes del fin del mundo.
resp_freq2 = freqz([1 -1 1], [1 -7/10 + 1/10], length(w),"whole") ;

resp_impulso = ifft(resp_freq);
resp_impulso2 = ifft(resp_freq2);

N = length(w);
x = zeros(1,N); x(1) = 1;
y = zeros(1,N);
y(1) = 1;
y(2) = -3/10;
for n=3:N
   y(n) = 1/10*(10*x(n)-10*x(n-1)+10*x(n-2)-(-7*y(n-1)+y(n-2)));
end


hold on;

figure(1);
stem(real(resp_impulso),'r');
%stem(abs(resp_freq),'b');
stem(y,'b');

figure(2);
diferencia = abs(real(resp_impulso) .- real(y));
stem(diferencia);
maxima_diferencia = max(abs(diferencia))

pause;
