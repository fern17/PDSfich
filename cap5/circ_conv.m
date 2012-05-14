1;

function cc = cconv(x,h)
    N = length(x);
    M = length(h);
    R = max(N,M);
    x = resize(x,1,R);
    h = resize(h,1,R);
    pivotex = 1;
    pivotey = 1;
    for i=1:R
        if(pivotex > N) 
            pivotex = 1;
        end
        if(pivotey > M)
            pivotey = 1;
        end
        x(i) = x(pivotex);
        pivotex = pivotex + 1;
        h(i) = h(pivotey);
        pivotey = pivotey + 1;
    end
    cc = zeros(R,1);
    ht = fliplr(h);
    for n=1:R
        ht = shift(ht,1);
        cc(n) = dot(x,ht);
    end

endfunction

x = [3 1 1 2];
h = [2 1];

z = cconv(x,h)
z2 = ifft(fft(x).*fft([h 2 1]))
