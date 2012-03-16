# Evitar que se tome como archivo de funciones
1;
# Para correr algunas funciones es necesario el paquete specfun
# sudo apt-get install octave-specfun

#Grafica la señal Seno
function graficaSeno(x0,dx,xf)
  x = x0:dx:xf-dx;
  y = sin(x);
  plot(x,y)
  pause
endfunction

#Grafica la señal Sinc = sin(x)/x
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

#Grafica la señal Onda Cuadrada
function graficaOndaCuadrada(x0,dx,xf)
  x = x0:dx:xf-x0;
  y = sign( sin(x) );
  plot(x,y)
  pause
endfunction


#Grafica la señal Onda Triangular usando la funcion de Heaviside
function graficaOndaTriangular(x0,dx,xf)
  pkg load specfun;
  x = x0:dx:xf-dx;
  for i=1:length(x)
    if (mod(i,2) == 0)
      y(i) = 1;
    else
      y(i) = 0;
    endif
  end
  plot(x,y)
  pause
endfunction

#Grafica la señal Delta de Dirac
function graficaDeltaDirac(x0,dx,xf)
  pkg load specfun;
  x = x0:dx:xf-dx;
  y = dirac(x);
  for i=1:length(x)
    if x(i) == 0
      y(i) = 9999;
      break;
    endif
  end
  plot(x,y)
  pause
endfunction

#Grafica Ruido Aleatorio
function graficaRuido(x0,dx,xf)
  x = x0:dx:xf-dx;
  y = randn(length(x),1);
  plot(x,y)
  pause
endfunction

#inicializaciones
X0 = -20*pi;
Xf = 20*pi;
DX = 0.01;


clear plot;
#llamado a funciones
#graficaSeno(X0,DX,Xf)
#graficaSinc(X0,DX,Xf)
#graficaOndaCuadrada(X0,DX,Xf)
#graficaOndaTriangular(X0,DX * 600,Xf)
graficaDeltaDirac(-2,DX,2)
#graficaRuido(X0,DX,Xf)

