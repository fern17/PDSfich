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

function r = y_aprox(t, alfa1, alfa3, alfa5)
    for i=1:length(t)
        term1 = alfa1 * sqrt(3/2) * t(i);
        term2 = alfa3 * sqrt(7/2) * (5/2*t(i)^3 - 3/2*t(i));
        term3 = alfa5 * sqrt(11/2)*1/8 * (63*t(i)^5 - 70*t(i)^3 + 15*t(i));
        r(i) = term1 + term2 + term3;
    end
endfunction

t0 = -1;
dt = 0.05;
tn = 1;
t = t0:dt:tn-dt;

alfa1 = sqrt(3/2);
alfa3 = -sqrt(7/32);
alfa5 = sqrt(11/2)*1/8;

y_orig = y(t);
y_aproximada2 = y_aprox(t, alfa1, alfa3, 0);
y_aproximada3 = y_aprox(t, alfa1, alfa3, alfa5);

plot(t, y_orig);
hold on
plot(t, y_aproximada2, 'r');
hold on
plot(t, y_aproximada3, 'g');
legend('Y original', 'Y aproximada con 2 alfa', 'Y aproximada con 3 alfa');
error_cuadratico_medio = norm(y_orig - y_aproximada,2)^2
