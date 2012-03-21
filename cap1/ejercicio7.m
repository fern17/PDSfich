1;

# Genere una señal aleatoria con distribución Gaussiana y verifique su ergodicidad.

function y=genera_aleatoria_matrix(t0, tf, dt, n)
	t=t0:dt:tf-dt;
	y=randn(length(t),n);
endfunction


function u=getMedia(x)
	n =length(x);
	suma = sum(x);
	u = suma/n;
endfunction


function v=getVarianza(x, u)
	n =length(x);
	suma = 0;
	for i=1:n
		suma = suma + (x(i)-u)^2;
	end
	v = suma/n;
endfunction

function estacionariedad(y)
	[n,m] = size(y);

	medias = zeros(m);
	varianzas = zeros(m);

	for j=1:m
		medias(j) = getMedia(y(:,j));
		varianzas(j) = getVarianza(y(:,j), medias(j));
	end

	clf;
	clear plot;
	figure(1);

	plot(medias, 'b');
	hold on;
	plot(varianzas, 'r');

endfunction


M = genera_aleatoria_matrix(0,20,0.5,1000);
estacionariedad(M);
