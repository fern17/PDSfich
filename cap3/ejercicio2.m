clear;
hold off;

%   ~~~~~~   TODO: Comprobar si está bien el calculo de ortogonalidad
%   ~~~~~~   TODO: Comprobar si está bien el calculo de ortogonalidad
%   ~~~~~~   TODO: Comprobar si está bien el calculo de ortogonalidad
%   ~~~~~~   TODO: Comprobar si está bien el calculo de ortogonalidad


% Definición de las señales
function y=signala(t)
	y = sin(2*pi*2*t);
endfunction

function y=signalb(t)
	y=sign(sin(2*pi*2*t));
endfunction

function y=signalc(t)
	y = sin(2*pi*4*t);
endfunction

function r=es_ortogonal(conjunto)
	N = length(conjunto);
	tolerancia = 0.00001;
	for i=1:N
		for j=1:N
			pinterno = dot(conjunto(i), conjunto(j) );
			if (i == j)
				if (abs(pinterno) < tolerancia )
					r=0;
					return;
				end
			else
				if (abs(pinterno) >= tolerancia )
					r=0;
					return
				end
			end
		end %for j
	end % for i
	r = 1;
endfunction


Fm = 100;
Tm = 1/Fm;
tolerancia = 0.000001;

% Dominio Temporal
t = 0:Tm:1-Tm;

sa = signala(t);
sb = signalb(t);
sc = signalc(t);

% Parte 1) Verificar ortogonalidad: <xi, xj> = 0 / i!=j

if (es_ortogonal( [sa sb] ))
	disp("a y b son ortogonales");
else
	disp("a y b no son ortogonales");
end

if (es_ortogonal( [sa sc] ))
	disp("a y c son ortogonales");
else
	disp("a y c no son ortogonales");
end

if (es_ortogonal( [sc sb] ))
	disp("c y b son ortogonales");
else
	disp("c y b no son ortogonales");
end


tfsa = fft(sa);
tfsb = fft(sb);
tfsc = fft(sc);


if (es_ortogonal( [tfsa tfsb] ))
	disp("TF de a y b son ortogonales");
else
	disp("TF a y b no son ortogonales");
end

if (es_ortogonal( [tfsa tfsc] ))
	disp("TF de a y c son ortogonales");
else
	disp("TF a y c no son ortogonales");
end


if (es_ortogonal( [tfsc tfsb] ))
	disp("TF de c y b son ortogonales");
else
	disp("TF c y b no son ortogonales");
end