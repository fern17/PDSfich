1;

function cc = cconv(x,h)
    N = length(x);
    M = length(h);
    if( N != M)
        disp('ERROR. Dimension de x y h distinta');
    end
    cc = zeros(N,1);

    for n=1:N
        for m=1:N
            suma = 0;
            for k=1:N
                suma = suma + x(mod(n - m - k*N,N) + 1);
            end
        end
        cc(n) = h(n)*suma;
    end
endfunction

x = [1 2 2];
h = [2 1 0.5];

z = cconv(x,h);
z
