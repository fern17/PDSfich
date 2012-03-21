1;
#ejercicio5.m

# Discretice una señal arbitraria con frecuencia de muestreo de 10 Hz y sobremuestreela mednainte
# distintos tipos de interpoladores a 4 veces la frecuencia de muestreo.

# Definicion de una señal arbitraria "continua".
function y=senal_arbitraria(x)
	y = 2*sin(2*pi*x);
endfunction

# frecuencia:	frecuencia de muestreo.
# x0:			inicio intervalo
# xf:			fin intervalo
function [xd,yd]=muestrear_senal(frecuencia, x0, xf)
	intervalo = xf - x0;
	dx = 1 / (intervalo*frecuencia);
	xd = x0:dx:xf-dx;

	for i=1:length(xd)
		yd(i) = senal_arbitraria(xd(i));
	end

	#Ploteamos algo "continuo" para ver diferencias
	x = x0:0.01:xf-0.01;
	for i=1:length(x)
		y(i) = senal_arbitraria( x(i) );
	end


	clf;
	clear plot;

	figure(1);
	hold on;
	stem(xd,yd, 'b');
	hold on;
	#plot(x,y, 'g');

	legend('Muestreada', 'Original')


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

#################### Fin declaración de funciones y procedimientos ####################
#################### Fin declaración de funciones y procedimientos ####################
#################### Fin declaración de funciones y procedimientos ####################
#################### Fin declaración de funciones y procedimientos ####################


muestrear_senal(0.13, -5, 4);