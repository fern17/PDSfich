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
x = zeros(1,n);
x(1) = 1;

h = sistema(x);
hold on;
figure(1);
plot(h,'b');

x = ones(1,n);
%y = convolucion_lineal(x,h);
y2 = conv(x,h);
figure(2);
plot(y2,'r')

%figure(3);
%plot(y.-y2);

pause;
