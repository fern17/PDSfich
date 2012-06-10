function y = expande(x,factor)
% Devuelve un vector con cada elemento de 'x' repetido 'factor' veces
%
% 03/07 - Leandro D. Vignolo
%

n = length(x);

s = size(x);
if (s(1)>1), col=1; else col=0; end;
if (col==1), x = x'; end;

y = [];
for l=1:n,
	y = [y x(l)*ones(1,factor)];
end;

if (col==1), y = y'; end;

end
