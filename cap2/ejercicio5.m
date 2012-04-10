1;

function r = y(t)
    for i=1:length(t)
        if(t(i) < 0)
            r(i) = -1;
        else
            r(i) = 1;
        end
    end
endfunction

function r = y_aprox(t)
    for i=1:length(t)
        term1 = 3/2 * t(i);
        term2 = -sqrt(7/32)*sqrt(7/2)*(5/2*t(i)^3 - 3/2*t(i));
        r(i) = 45/16*t(i) - 35/16*t(i)^3;
%       r(i) = term1 + term2;
    end
endfunction

t0 = -1;
dt = 0.01;
tn = 1;
t = t0:dt:tn-dt;
y_orig = y(t);
y_aproximada = y_aprox(t);
plot(t, y_orig, 'b');
hold on
plot(t, y_aproximada, 'r');
error_cuadratico_medio = norm(y_orig - y_aproximada,2)^2

