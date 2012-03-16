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
traslacion(10, 2, 0, -5, 0.01, 5, 0); 
traslacion(10, 2, 0, -5, 0.01, 5, 0.3, 'y');
traslacion(10, 2, 0, -5, 0.01, 5, -0.6, 'r');
legend('Original', 'Trasladada a Izq', 'Trasladada a Der') 