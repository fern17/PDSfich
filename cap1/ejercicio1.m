# Evitar que se tome como archivo de funciones
1;
# Para correr algunas funciones es necesario el paquete specfun
# sudo apt-get install octave-specfun

EPS = 0.000001;

#Ejercicio 1.1) Grafica la señal Seno
function graficaSeno(x0,dx,xf)
  x = x0:dx:xf-dx;
  y = sin(x);
  plot(x,y)
  pause
endfunction

#Ejercicio 1.2) Grafica la señal Sinc = sin(x)/x
function graficaSinc(x0,dx,xf)
  if (x0 == 0) #pequeño arreglo para el caso en que x0 = 0. 
    disp "Division por cero, arreglando"
    x0 = x0 + dx;
  end
  x = x0:dx:xf-x0;
  y = sin(x)./x; #Division miembro a miembro
  plot(x,y)
  pause
endfunction

#Ejercicio 1.3) Grafica la señal Onda Cuadrada
function graficaOndaCuadrada(x0,dx,xf)
  x = x0:dx:xf-x0;
  y = sign( sin(x) );
  plot(x,y)
  pause
endfunction


#Ejercicio 1.4) Grafica la señal Onda Triangular
#Fuente de la forma de hacerla: http://octave.1599824.n4.nabble.com/triangular-wave-td1631398.html
function graficaOndaTriangular(x0,dx,xf)
  x = x0:dx:xf-dx;
#  y = 2/pi*asin(sin(2*pi*x));
  y = 2*abs(2*((x-0.25) - floor(x-0.25))-1)-1;
  clf;
  plot(x,y);
  hold on;
 endfunction

#Ejercicio 1.5) Grafica la señal Delta de Dirac
function graficaDeltaDirac(x0,dx,xf)
  x = x0:dx:xf-dx;
  for i=1:length(x)
    if abs(x(i)) < EPS
      y(i) = 9999;
      break;
    endif
  end
  plot(x,y)
  pause
endfunction

#Ejercicio 1.6) Grafica Ruido Aleatorio
#Distribución normal: u=0 ; s=1;
function graficaRuido(x0,dx,xf)
  x = x0:dx:xf-dx;
  y = randn(length(x),1);
  plot(x,y)
  pause
endfunction

#inicializaciones
X0 = 0;
Xf = 2*pi;
DX = 0.01;


clear plot;

#llamado a funciones
#graficaSeno(X0,DX,Xf)
#graficaSinc(X0,DX,Xf)
#graficaOndaCuadrada(X0,DX,Xf)
graficaOndaTriangular(X0,DX,Xf)
#graficaDeltaDirac(X0,DX,Xf)
#graficaRuido(X0,DX,Xf)

