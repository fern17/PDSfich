#evitar que se tome como archivo de funciones
1;

#Grafica la señal Seno
function graficaSeno(x0,dx,xf)
  x = x0:dx:xf;
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
  x = x0:dx:xf;
  y = sin(x)./x;
  plot(x,y)
  pause
endfunction

#Grafica la señal Onda Cuadrada
function graficaOndaCuadrada(x0,dx,xf)
  x = x0:dx:xf;
  y = sign(sin(x));
  plot(x,y)
  pause
endfunction


#Grafica la señal Onda Triangular usando la funcion de Heaviside
function graficaOndaTriangular(x0,dx,xf)
  pkg load specfun;
  x = x0:dx:xf;
  y = x.*(heaviside(x) - 2 * heaviside(x-1)) + 2*heaviside(x-1);
  plot(x,y)
  pause
endfunction

#Grafica la señal Delta de Dirac
function graficaDeltaDirac(x0,dx,xf)
  pkg load specfun;
  x = x0:dx:xf;
  y = dirac(x);
  plot(x,y)
  pause
endfunction

#Grafica Ruido Aleatorio
function graficaRuido(x0,dx,xf)
  pkg load specfun;
  x = x0:dx:xf;
  y = randn(length(x),1);
  plot(x,y)
  pause
endfunction

#inicializaciones
X0 = 0;
Xf = 20*pi;
DX = 0.01;

#llamado a funciones
#graficaSeno(X0,DX,Xf)
#graficaSinc(X0,DX,Xf)
graficaOndaCuadrada(X0,DX,Xf)
#graficaOndaTriangular(X0,DX,Xf)
#graficaDeltaDirac(-2,DX,2)
#graficaRuido(X0,DX,Xf)

