1;
clear all;

function y = h(z)
    y = zeros(1,length(z));
    for i=1:length(z)
        y(i) = z(i)^2 / (z(i)^2 - 0.5*z(i) + 0.25);
    end
endfunction

fm = 10000;
r = 1;

w = [0:1/fm:2*pi-1/fm];
z = r*e.^(j*w);

resp_freq = h(z);

hold on;
stem(abs(resp_freq),'b');
pause;
