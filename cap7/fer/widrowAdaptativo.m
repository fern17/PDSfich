function [A, orden] = widrowAdaptativo(senal, tol)
    N = length(senal);
    A = zeros(1,N);
    A(1,1:2) = randn(1,2)/2;
    i = 2;
    delta = 0.5;
    for i=2:N
        orden = i;
        %salida original a procesar en esta iteracion
        sn = senal(1:i);
        
        %Setea el mu
        R = autocor(sn);
        mu = 1/trace(R)-delta;
        
        %salida calculada con los coeficientes actuales ante un delta dirac
        input = zeros(1,i);
        input(1) = 1;
        snh = filter([1],A(i-1,:),input);
        
        %error actual
        en = sn(i) - snh(i)
        size(sn);
        size(A);
        %proxima iteracion
        An = A(i-1) - 2*mu*en*sn;
        An = [An zeros(1,N-length(An))];
        %figure(1); plot(A(i-1),'r'); plot(An,'b'); plot(abs(A(i-1) - An),'k'); pause;
        pause
        if(max(abs(An - A(i-1,:))) < tol)
            break
        end
        A = [A; An];
       
        
        %trans_dirac = fft(input);
        %trans_salida = fft(snh);
    end
endfunction

