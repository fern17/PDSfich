function viewwave(nombre,orden)

h=ondita(nombre,orden);
g=pasaalto(h);
lx=length(h);
[f,x]=dilation(h,8);
w=waveletd(f,x,g);

figure;
plot(x,f);
title(['Scaling function for ' nombre ' ' num2str(orden)]);

figure;
plot(x,w);
title(['Motehr wavelet for '  nombre ' ' num2str(orden)]);
