clear;
hold off;
%Leo los archivos
merval = load('merval1.txt');
merval2 = load('merval2.txt');

%Calculo longitudes
N = length(merval);
N2 = length(merval2);

%Transformo
Ymerval = fft(merval);

%Inserto ceros en el medio, ya que Ymerval(N/2) corresponde a la frecuencia mas alta.
% Al agregar N ceros, estoy diciendo que tambien tenia N/2 frecuencias mas altas
% Recordar que esta espejado a partir de N/2+1, por eso se generan N/2 frecuencias nuevas en lugar de N.
Ymerval = [Ymerval(1:N/2); zeros(N,1); Ymerval(floor(N/2+1):N);];

%Antitransformo. Multiplico por 2 porque tengo el doble de muestras ahora
mervalLarga = ifft(Ymerval)*2; 

hold on;
%dibujo y soy feliz
figure(1);
plot(1:N,merval,'b');
plot(1:0.5:N+0.5,mervalLarga,'r');
plot(1:0.5:N,merval2,'k');
xlabel('Mes');
legend('Merval Original','Merval interpolado','Merval Doble');
pause;
