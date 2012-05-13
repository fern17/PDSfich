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
z = r*e.^(j*w*2*pi);

resp_freq = h(z);
resp_freq2 = freqz([1 -2 2 -1], [1 -17/10 4/5 -1/10], length(w),"whole");

resp_impulso = ifft(resp_freq);
resp_impulso2 = ifft(resp_freq2);

hold on;
%stem(abs(resp_freq),'b');

figure(1);
stem(real(resp_impulso),'r');
stem(real(resp_impulso2),'b');

figure(2);
diferencia = abs(real(resp_impulso)' .- real(resp_impulso2));
stem(diferencia);
maxima_diferencia = max(abs(diferencia))

pause;
