1;
#ejercicio5.m

# Discretice una señal arbitraria con frecuencia de muestreo de 10 Hz y sobremuestreela mednainte
# distintos tipos de interpoladores a 4 veces la frecuencia de muestreo.

# Definicion de una señal arbitraria "continua".
function y=senal_arbitraria(x)
	y = 2*sin(20*pi*x);
endfunction

# frecuencia_muestreo:	frecuencia de muestreo.
# x0:					inicio intervalo
# xf:					fin intervalo
function [xd,yd]=muestrear_senal(frecuencia_muestreo , x0, xf)
	intervalo = xf - x0;
	dx = 1 / (intervalo*frecuencia_muestreo);
	xd = x0:dx:xf-dx;

	for i=1:length(xd)
		yd(i) = senal_arbitraria(xd(i));
	end

	% clf;
	% clear plot;

	% figure(1);
	% hold on;
	% plot(xd,yd, 'b');
	% hold on;
	% plot(x,y, 'g');

	% legend('Muestreada', 'Original')


endfunction


### interpoladores
function y=interpolador_escalon(x)
	for i=1:length(x)
		if (x(i) <= 0 && x(i) < 1)
			y(i) = 1;
		else
			y(i) = 0;
		endif
	end
endfunction

function y=interpolador_lineal(x)
	for i=1:length(x)
		if (abs(x(i)) < 1) 
			y(i) = 1 - abs(x(i)) ;
		else
			y(i) = 0;
		endif
	end
endfunction

function y=interpolador_sinc(x)
	for i=1:length(x)
		if (abs(x(i)) < 1) 
			y(i) = 1 - abs(x(i)) ;
		else
			y(i) = 0;
		endif
	end
endfunction

function [x_continuo, y_continuo]=interpolador(xd, T, x_continuo)
	for i=1:length(x_continuo)
		y_continuo(i) = sum( i*T 
			* interpolador_lineal(
					(x_continuo(i) - i*T)) / T
		 );
	end
endfunction

#################### Fin declaración de funciones y procedimientos ####################
#################### Fin declaración de funciones y procedimientos ####################
#################### Fin declaración de funciones y procedimientos ####################
#################### Fin declaración de funciones y procedimientos ####################

x0 = -0.5; 
xf = 1;
dx_continuo = 0.0025;
frecuencia_muestreo = 10;
T = 1/frecuencia_muestreo;
% Graficamos la funcion arbitraria "continua"
x_continuo = x0:dx_continuo:xf-dx_continuo;

clf;
clear plot;
figure(1);
plot(x_continuo, senal_arbitraria(x_continuo) , 'y');

%Obtenemos la funcion discretizada
[xd, yd] = muestrear_senal(frecuencia_muestreo, x0, xf);

[intx, inty] = interpolador(xd, T, x_continuo);

hold on;
plot(intx,inty, 'b');


