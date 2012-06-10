function [c,l,mat]=diadica(d,nivel,nombre)

% [c,l,mat]=diadica(x,nivel,wavelet)
% Calcula y grafica la TW diadica hasta el nivel especificado
%
%  Parametros de entrada: 
%  x = senal a analizar
%  nivel = nivel de descomposici�n deseado
%  nombre = nombre de la wavelet a usar (ej: 'db8', 'sym4','coif2')
%
%  Parametros de salida
%  c = coeficientes de la descomposici�n  [an dn dn-1 ..... d1]
%  l = indices de donde empieza y donde termina cada descomposicion
%  mat = matriz generada a parti de la descomposici�n (lo que se grafica)
%
% Por Leandro Di Persia

[c,l] = wavedec(d,nivel,nombre);
%h=ondita('daubechies',4);
%g=pasaalto(h);
%c=fwt1(d,h,g);
lv=length(d);
cfd = zeros(nivel,lv);
        for k = 1:nivel
                d = detcoef(c,l,k);
                d = d(:)';
                d = d(ones(1,2^k),:);
                cfd(k,:) = wkeep(d(:)',lv);
        end
        cfd =  cfd(:);
        I = find(abs(cfd)<sqrt(eps));
        cfd(I)=zeros(size(I));
	cfd = reshape(cfd,nivel,lv);
colormap(jet(256))
img = image(wcodemat(cfd,256,'row'));
        tics = 1:1:nivel;
        aux=[];
        for j=1:nivel,
           aux=strvcat(aux,int2str(j));
        end
        labs=aux;
         
        set(get(img,'parent'),                  ...
                'YTicklabelMode','manual',      ...
                'YTick',tics,                   ...
                'YTickLabel',labs,             ...
                'YDir','normal',	        ...
                'Box','On'                      ...
                );
        title('Transformada Discreta, coeficientes absolutos.')
        ylabel('level')
 
shading flat
ylabel('j=log2(s) (s=2^j)');
xlabel('Tiempo')
colorbar
mat=cfd;
