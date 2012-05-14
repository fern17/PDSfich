1;

%Convolución Lineal
function convolucion = convolucion_lineal(x,h) 
	M = size(x, 2);
	N = size(h, 2);
	
	R = M + N - 1;
	
	convolucion = zeros(1,R);

	for i=1:M 
		R_temp = zeros(1,R);
		for j=1:N %recorremos H
			R_temp(i+j-1) = x(i) * h(j);
		end
		R_temp
        convolucion = convolucion + R_temp
	end
endfunction

function y2 = convolucion_minita(x,h)
	M = size(x, 2);
	N = size(h, 2);
	R = M + N - 1;

	y2 = zeros(1, R);

	for n=0:R-1
		m = 0;
		for k=0:N
			j=n-k;
			if not (k+1 > N | j+1 > N | j<0)
				m = m + ( x(k+1) * h(j+1) );
			end
		end
		y2(n+1) = m;
	end
endfunction

x = [5 1 4 0];
h = [0.5 4 2 1 0];

convolucion_lineal(x,h)
conv(x,h)
%convolucion_minita(x,h)
