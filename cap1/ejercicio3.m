1; clf;

#Ejercicio 3  #Discretizacion de la funcion Seno de 5 Hz.

#function discretiza_seno(A, f, phi, t0, tn, fm)
#  x = t0:1/fm:tn-1/fm;
#  y = A*sin(f*x + phi); #Se elimina el 2pi porque se pasa a Radianes, que es el argumento del seno
#  clear plot
#  figure(1)
#  z = t0:0.001:tn-0.001;
#  plot(z,A*sin(f*z + phi),'r')
#  hold on 
#  plot(x,y)
#  pause
#endfunction

#Indique la frecuencia de muestroe deseada en Hertz
#f_muestreo = 10;
#discretiza_seno(1,5,0,0,1,f_muestreo)


#Si x es el tiempo, el seno no deberia estar entre 0 y 1 y tener una frecuencia de 5 (con muestreo grande)?

function discretiza_seno(A, f, phi, t0, tn, fm)
  x = t0:1/fm:tn;               #Que llegue hasta el final sino no se distigue para muestreos pequeños
  y = A*sin(f*x*2*pi + phi);
  clear plot
  figure(1)
  z = t0:0.00001:tn-0.001;
  plot(z,A*sin(f*z*2*pi + phi),'r')
  hold on 
  plot(x,y)
  pause
endfunction

#Indique la frecuencia de muestroe deseada en Hertz
f_muestreo = 25;
discretiza_seno(1,5,0,0,1,f_muestreo)