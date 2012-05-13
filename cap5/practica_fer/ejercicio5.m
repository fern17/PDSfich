1;

%calcula la convolucion lineal de x con h. y = x*h
function y = convolucion(x,h)
    M = length(x);
    N = length(h);
    R = N+M-1;
    y = zeros(1,R);

    for i=1:M
        R_t = zeros(1,R);
        for j=1:N
            R_t(i+j-1) = x(i)*h(j);
        end
        y = y + R_t;
    end
endfunction

x = [ 1 2 2];
h = [ 2 1 0.5];
N = length(x);

y1 = convolucion(x,h)

y2 = conv(x,h)

y3 = filter(h,[1],[x zeros(1,N-1)])

y4 = ifft(fft(x).*fft(h))

y5 = ifft(fft([x zeros(1,N-1)]).*fft([h zeros(1,N-1)]))


pause;
