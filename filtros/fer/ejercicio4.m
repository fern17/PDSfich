
frec_muestreo = 300;
frec_ruido = 50; %Ruido de linea = 50 Hz.

orden = 50; %orden del filtro
tol = 3; %tolerancia de la frecuencia de rechazo... tol=3 => rechazamos de 47 a 53

resp_freq = ones(1,frec_muestreo); %rf va de 0 a 300 Hz.
for i=-tol:tol
    resp_freq(frec_ruido+i) = 0; %frecuencia positiva
    resp_freq(frec_muestreo-frec_ruido-i) = 0; %frecuencia negativa
end

%Obtenemos la respuesta en tiempo del filtro
filtro_tiempo = ifft(resp_freq);
N = length(filtro_tiempo); %longitud del filtro

%nos quedamos con su parte central (dada por el orden)
filtro_tiempo_corto = filtro_tiempo(orden:(N-orden+1));

%Definicion de ventana y ventaneado del filtro en tiempo
ancho_ventana = length(filtro_tiempo_corto);
ventana = bartlett(ancho_ventana)';
filtro_ventaneado = filtro_tiempo_corto .* ventana;

%transformo para encontrar el filtro final en frecuencia
filtro_final = abs(fft(filtro_ventaneado));

%lo normalizo
maximo = max(filtro_final);
filtro_final = filtro_final ./ maximo;

%señal de prueba
T = 1/frec_muestreo;
t = 0:T:1 - T;
s = sin(2*pi*t*50) + sin(2*pi*t*20);

s_f = filter(filtro_final,[1],s);
figure(4); plot(abs(fft(s_f)));
figure(5); plot(abs(fft(s)));

%stem(abs(fft(filtro_ventaneado)));
figure(1);plot(abs(freqz(filtro_final,[])));

%figure(3); plot(filtro_tiempo);
%figure(2); plot(filtro_tiempo_corto);


pause;
