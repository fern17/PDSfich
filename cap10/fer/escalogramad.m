function escalogramad(a,d,nx,niveles)
%
% Escalograma (Transformada Ondita Discreta Di�ica)
%
% escalogramad(a,d,nx,niveles)
% La grafica pone los niveles de menor a mayor. Para una descomposicion
% hasta nivel P, incluye P+1 niveles, donde los 1 a P son los coeficientes 
% de detalle en esas escalas y el numero P+1 corresponde a los
% coeficientes de aproximacion en la escala P.
%
% a:  Aproximaciones  
% d:  Detalles	      ( [a,d] = todd(se�l,coefs_ondita,niveles) )
% nx: Tama� de la se�l (potencia de 2)
% niveles:  Niveles de descomposici�
%
% 04/07 - Leandro D. Vignolo
% 05/07 - Leandro Di Persia

cnt=nx;
for j=1:niveles,
   cnt=[floor(cnt(1)/2) cnt];
end;

in2=1;
for j=1:niveles,
   in2=[in2 in2(length(in2))+cnt(j)];
end;

cfd = zeros(niveles+1,nx);
for k = 1:niveles,
   cf = d(in2(k):in2(k)+cnt(k)-1);
   cfd(niveles-k+1,:) = expande(cf',floor(nx/length(cf)));
end;

af=a(in2(1):in2(1)+cnt(1)-1);
cfd(niveles+1,1:nx) = expande(af',floor(nx/length(af)));


I = find(abs(cfd)<sqrt(eps));
cfd(I)=zeros(size(I));
cfd = reshape(cfd,niveles+1,nx);

% control de los ejes
xtics=1:floor(nx/11):nx;
ytics=1:niveles+1;
aux=abs(cfd);

if (chksft=='octave')
   imagesc(xtics,ytics,aux);
   title('Transformada Discreta Diadica, coeficientes absolutos.');
   ylabel('Nivel (Escala=2^(Nivel))');
   xlabel('Tiempo');
%   graph3(aux, xtics, ytics);
else
   colormap(jet(256));
   img = imagesc(xtics,ytics,wcodemat(cfd,256,'row'));
   title('Transformada Discreta Diadica, coeficientes absolutos.');
   ylabel('Nivel (Escala=2^(Nivel))');
   xlabel('Tiempo')
   colorbar;
   axis('xy');
end;
end
