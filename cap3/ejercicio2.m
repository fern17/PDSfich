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


Fm = 100;
Tm = 1/Fm;
tolerancia = 0.000001;

% Dominio Temporal
t = 0:Tm:1-Tm;

sa = signala(t);
sb = signalb(t);
sc = signalc(t);

% Parte 1) Verificar ortogonalidad: <xi, xj> = 0 / i!=j

if (dot(sa,sb) < tolerancia)
	disp("a y b son ortogonales");
else
	disp("a y b no son ortogonales");
end

if (dot(sa,sc) < tolerancia)
	disp("a y c son ortogonales");
else
	disp("a y c no son ortogonales");
end

if (dot(sc,sb) < tolerancia)
	disp("c y b son ortogonales");
else
	disp("c y b no son ortogonales");
end


tfsa = fft(sa);
tfsb = fft(sb);
tfsc = fft(sc);


if (dot(tfsa,tfsb) < tolerancia)
	disp("TF de a y b son ortogonales");
else
	disp("TF a y b no son ortogonales");
end

if (dot(tfsa,tfsc) < tolerancia)
	disp("TF de a y c son ortogonales");
else
	disp("TF a y c no son ortogonales");
end


if (dot(tfsc,tfsb) < tolerancia)
	disp("TF de c y b son ortogonales");
else
	disp("TF c y b no son ortogonales");
end