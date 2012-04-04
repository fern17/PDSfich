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

function r = y_aprox(t, alfa1, alfa3)
    for i=1:length(t)
        term1 = alfa1 * sqrt(3/2)*t(i);
        term2 = alfa3*sqrt(7/2)*(5/2*t(i)^3 - 3/2*t(i));
        r(i) = term1 + term2;
    end
endfunction

t0 = -1;
dt = 0.05;
tn = 1;
t = t0:dt:tn;

alfa_ini = -1;
delta_alfa = 0.05;
alfa_fin = 1;
restadores = alfa_ini:delta_alfa:alfa_fin;

alfa1 = sqrt(3/2);
alfa3 = -sqrt(7/32);

cantidad_alfas = length(restadores);
cantidad_t = length(t);

y_orig = y(t);
error_cuadratico = zeros(cantidad_alfas, cantidad_alfas);
for i=1:cantidad_alfas
    for j=1:cantidad_alfas
        y_aproximada = y_aprox(t, alfa1+restadores(i), alfa3+restadores(j));
        error_cuadratico(i,j) = norm(y_orig - y_aproximada,2)^2;
    end
end

mesh(restadores(1,:), restadores(1,:), error_cuadratico);
hold on;
