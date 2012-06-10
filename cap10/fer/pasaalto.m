function h1 = pasaalto(h0);
% Coeficientes del filtro pasa-altos
%
% ha = pasaalto(hb);
%
% Obtiene los coeficientes del filtro pasa-altos a partir de 
% los coeficientes del filtro pasa-bajos de la misma ondita. 
%
% 03/07 - Leandro D. Vignolo
%

	l = length(h0);
	for n=1:l,
		h1(n)=((-1)^(n-1))*h0(l-n+1);
	end;

end
