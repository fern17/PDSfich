1;

clear;
clf;
function y = sistema(x)
    n = length(x);
    if ( n < 2)
        disp('Muestra muy chica');
        return
    end
    y = zeros(1,n);
    
    y(1) = 1/6;
    y(2) = 1/18;

    for i = 3:n
        y(i) = 1/6 * (x(i) - 2*x(i-1) + x(i-2) + 4*y(i-1) - 5*y(i-2));
    end
endfunction

n = 100;
impulso = zeros(1,n);
impulso(1) = 1;

h = sistema(impulso);

x = 0:0.1:10;
senal_periodica = 3*sin(2*pi*x);

sconv = conv(senal_periodica, h);

hold on;
plot(x,senal_periodica, 'r')

figure(2);
plot(sconv, 'b')




