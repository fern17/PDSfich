1;

function cc = cconv(x,h)
    N = length(x);
    M = length(h);
    if( N != M)
        disp('ERROR. Dimension de x y h distinta');
    end
    cc = zeros(N,1);
    ht = fliplr(h);
    for n=1:N
        ht = shift(ht,1);
        cc(n) = dot(x,ht);
    end
endfunction

x = [1 2 3];
h = [4 2 1];

z = cconv(x,h)
