function y=upsample(x,p);
%
% Sobremuestreo
%
% y = upsample(x,p)
% x: señal a sobremuestrear
% p: factor de sobremuestreo
%
% 03/07 - Leandro D. Vignolo
%

s = size(x);
if (s(1)>1), col=1; else col=0; end;
if (col==1), x = x'; end;

n = length(x);

y = [];
for l = 1:n,
	y = [y x(l)];
	y = [y zeros(1,p-1)];
end;

if (col==1), y = y'; end;

end
