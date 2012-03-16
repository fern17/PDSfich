1;


#Realizar una expansion.

function operacion_alfa(A, w, phi, t0, dt, tf, alfa, color = 'b')
	t = t0:dt:tf-dt;
	figure(1);
	plot(t, A*sin(w*t*alfa + phi), color)
	hold on;

endfunction


# alfa negativo 	=> inversion
# alfa > 1      	=> compresion
# 0 < alfa < 1      => expansion


clear plot;
#operacion_alfa(10, 2, 0, -5, 0.01, 5, 1);          #original
#operacion_alfa(10, 2, 0, -5, 0.01, 5, 5.3, 'r');   #compresion
#operacion_alfa(10, 2, 0, -5, 0.01, 5, 0.3, 'y');   #expansion
#operacion_alfa(10, 2, 0, -5, 0.01, 5, -1, 'm');   #inversion
#legend('Inversion', 'Expansion');
#grid off;


function traslacion(A, w, phi, t0, dt, tf, tita, color = 'b')
	t = t0:dt:tf-dt;
	figure(1);
	plot(t, A*sin(w*(t + tita) + phi), color)
	hold on;

endfunction
clear plot;
#traslacion(10, 2, 0, -5, 0.01, 5, 0); 
#traslacion(10, 2, 0, -5, 0.01, 5, 0.3, 'y');
#traslacion(10, 2, 0, -5, 0.01, 5, -0.6, 'r');
#legend('Original', 'Trasladada a Izq', 'Trasladada a Der') 

function rectificacion(A, w, phi, t0, dt, tf, color = 'b')
	t = t0:dt:tf-dt;
	#figure(1);
	plot(t, abs(A*sin(w*t + phi)), color)
	#hold on;

endfunction

#rectificacion(10, 2, 0, -5, 0.01, 5); 

#Definición de la funcion de Rectificacion
function y=ro(x, H, N) 
	if x < 0
		y = 0;
	elseif x < (N-1)*H 
		y = H*floor(x/H);
	else
		y = (N -1 ) * H;
	end
endfunction


function cuantizacion(A, w, phi, t0, dt, tf, H = 8, color = 'b')
	#Ferdi dijo: Mientras H se acerca a dt entonces la grafica cuantizada se aproxima igual a la discretizada. 
    clf;
	t = t0:dt:tf-dt;
	figure(1);
	plot(t, A*sin(w*t + phi) , 'r');
	hold on;
	plot(t, ro(A*sin(w*t + phi), H, length(t) ), color);
	#hold on;

endfunction

cuantizacion(10, 2, 0, -5, 0.01, 5);