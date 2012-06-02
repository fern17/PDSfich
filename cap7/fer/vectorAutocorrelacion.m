function R = vectorAutocorrelacion(a)
    n = length(a);
    R = zeros(1,n);
    ashifted = a;
    for i=1:n
        R(i) = cor(a,ashifted);
        ashifted = shift(a,1);
    end
endfunction
