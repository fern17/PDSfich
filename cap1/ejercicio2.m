1;


#Ejercicio 2)

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
#original
#operacion_alfa(10, 2, 0, -5, 0.01, 5, 1);

#Ejercicio 2.1  #expansión
#operacion_alfa(10, 2, 0, -5, 0.01, 5, 0.3, 'y');   

#Ejercicio 2.2  #compresión
#operacion_alfa(10, 2, 0, -5, 0.01, 5, 5.3, 'r');

#Ejercicio 2.3  #inversión
#operacion_alfa(10, 2, 0, -5, 0.01, 5, -1, 'm');

#Ejercicio 2.4 #Rectificación

function rectificacion(A, w, phi, t0, dt, tf, color = 'b')
	t = t0:dt:tf-dt;
	#figure(1);
	plot(t, abs(A*sin(w*t + phi)), color)
	#hold on;
endfunction
#rectificacion(10, 2, 0, -5, 0.01, 5); 

#Ejercicio 2.5  #cuantización
#La cuantizacion usa potencias de dos, donde L=2^H
function y=ro(x, H, N) #Definición de la funcion de Cuantizacion
  n = length(x);
  for i=1:n
    if x(i) < 0
      y(i) = 0;
    elseif x(i) < (N-1)*H
      y(i) = H*floor(x(i)/H);
    else
      y(i) = (N-1)*H;
    end
  end
endfunction

#H es la altura de cada cuanto. H = Amplitud/niveles_de_cuantizacion
function cuantizacion(A, w, phi, t0, dt, tf, H, color = 'b')
	#Ferdi dijo: Mientras H se acerca a dt entonces la grafica cuantizada se aproxima igual a la discretizada. 
    clf;
	t = t0:dt:tf-dt;
	figure(1);
	plot(t, A*sin(w*t + phi) , 'r');
	hold on;
	plot(t, ro(A*sin(w*t + phi), H, length(t) ), color);
	hold on;

endfunction

amp = 10;
niveles = 8;
cuantizacion(amp, 2, 0, -5, 0.01, 5, amp/niveles)


#Ejercicio 2.6  #traslación
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
