1;

function cc = cconv(x,h)
    N = length(x);
    M = length(h);
    R = max(N,M);
    if (M == R)
        chico = x;
        grande = h;
    else
        chico = h;
        grande = x;
    end
    inicio = length(chico);
    chico = resize(chico,1,R);
    
    for i=inicio:(R-1)
        chico(i+1) = chico(i - inicio + 1);
    end
    
    h = chico;
    x = grande;
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
