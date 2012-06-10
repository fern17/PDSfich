function [a,d]=todd(x,h0,p);
%
% Transformada Onditas Discreta Di�dica
%
% [a,d] = todd(x,h0,p);
% a:  Aproximaciones
% d:  Detalles
% x:  Se�al
% h0: Vector con los coeficientes del filtro pasa-bajos asociados a una ondita
%     (ver help ondita)
% p:  Niveles de descomposici�n
%
% S�lo para se�ales cuyo tama�o es potencia de 2.
% Utiliza periodizaci�n (convoluci�n circular).
%
% 03/07 - Leandro D. Vignolo
% 05/07 - Leandro Di Persia

[pp,qq]=size(x);
if pp>qq
   x=x';
end

if (p>floor(log2(length(x)))), p=floor(log2(length(x))); end;
a=[];
d=[];
h1=pasaalto(h0);

ap=x.';
a=[ap.' a.'].';
for j=1:p,
    [ap,de]=dwtstep(ap,h0,h1);          
    a=[ap.' a.'].';
    d=[de.' d.'].';
end;

end
