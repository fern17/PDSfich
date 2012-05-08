1;
clear;
clf;


% Respuesta al impulso de A
function y = ha(n)
    y = sin(8*n);
endfunction

% Respuesta al impulso de B
function y = hb(n,a)
    for i=1:length(n)
	    if(n(i) >= 0)
	        un = 1;
	    else
	        un = 0;
	    end
		y(i) = a^n(i)*un;
	end	
endfunction

% Definimos X
function x_in=xin(n, a)
	x_in = zeros(1, length(n) );
	x_in(1) = 1;
	x_in(2) = -a;
endfunction

a = 0.5;
n = [1:1:100];

W = conv( xin(n,a) ,  ha(n) );

hold on; 
plot(W, 'r')


Out = conv( W ,  hb(n,a) );

plot(Out);

pause;
