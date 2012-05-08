1;

function y = ha(n)
    y = sin(8*n);
endfunction

function y = hb(n,a)
    if(n >= 0)
        un = 1;
    else
        un = 0;
    end
    y = a^n*un;
endfunction


