1;

# Genere una señal aleatoria con distribución Gaussiana y verifique su ergodicidad.

function y=genera_aleatoria_matrix(t0, tf, dt, n)
	t=t0:dt:tf-dt;
	y=randn(n,length(t));
endfunction


function u=getMedia(x)
	n =length(x);
	suma = sum(x);
	u = suma/n;
endfunction


function v=getVarianza(x, u)
	n =length(x);
	suma = 0;
	for i=1:n
		suma = suma + (x(i)-u)^2;
	end
	v = suma/n;
endfunction

#Verifica estacionareidad comprobando verticalmente las muestras de la señal 
# original con una frecuencia que puede ir desde 1 hasta 1/dt de la funcion original
function estacionareidad(y, frecuencia_test)
  if( frecuencia_test < 1 | frecuencia_test > columns(y))
    disp("frecuencia de testeo invalida");
    return
  end
  [n,m] = size(y);

	medias = zeros(m);
	varianzas = zeros(m);
  contador = 0;
	for j=1:frecuencia_test:m
		contador = contador + (comprobarNormal(y(:,j))); #true = 1, false = 0
	end
  
  printf("Fueron normales %d de %d muestras para estacionareidad \n", contador, ceil(m/frecuencia_test));
endfunction



function ergodicidad(y)
  [n,m] = size(y);

  contador = 0;
	for i=1:n
		contador = contador + (comprobarNormal(y(i,:))); #true = 1, false = 0
	end
  printf("Fueron normales %d de %d muestras para ergodicidad  \n", contador, n);
endfunction

function [resultado] = comprobarNormal(muestras)
  global CONFIANZA;
  media = getMedia(muestras);
  varianza = getVarianza(muestras, media);
  n = length(muestras);
  contador = 0;
  desvio = sqrt(varianza);
  for i=1:n
    if(abs(muestras(i) - media) < 2*desvio) #pedimos que este dentro del 90%
      contador = contador+1;
    end
  end
  if(contador >= n*0.95)
    resultado = true;
  else
    resultado = false;
  end
endfunction

dt = 0.01;
frecuencia_test = 1/dt/100;
M = genera_aleatoria_matrix(0,10,dt,500);

estacionareidad(M, frecuencia_test);
ergodicidad(M);
disp("Se esta usando 95% de confianza");
