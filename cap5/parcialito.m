1;

x = [1 2 2 4 6 13];
y = [0.5 3 1];

xconvy = conv(x,y)

%se usa la propiedad: fft(x * y) = fft(x)fft(y)
function cf = conv_fft(x,y)
    M = length(x);
    N = length(y);
    R = N+M-1;
    
    %rellena con ceros hasta tener longitud R
    x = [x zeros(1,R-M)];
    y = [y zeros(1,R-N)];

    %aplica propiedad de convolucion
    cf = ifft(fft(x).*fft(y)); 

endfunction

conv_fft(x,y)

pause;
