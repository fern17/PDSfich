1; clf;

#Ejercicio 4  #Discretizacion de la funcion Seno de 5 Hz.

function discretiza_seno(A, f, phi, t0, tn, fm)
  x = t0:1/fm:tn-1/fm;
  y = A*sin(f*x*2*pi + phi);#Se elimina el 2pi porque se pasa a Radianes, que es el argumento del seno
  clear plot
  figure(1)
  z = t0:0.0001:tn-0.001;
  plot(z,A*sin(f*z*2*pi + phi),'r')
  hold on 
  plot(x,y)
  pause
endfunction

#Indique la frecuencia de muestreo deseada en Hertz
f_muestreo = 130;
discretiza_seno(1,4000,0,0,2,f_muestreo)

#Estimación de la Frecuencia de la señal muestreada:
# Gráficamente podemos observar que la señal posee 2 repeticiones en los dos segundos de duración, lo cual implica una frecuencia de 1 Hz.
# En el caso de algo más complicado, se podría hacer un algoritmo que cuente los cambios de pendiente durante el período de muestreo y así calcular la frecuencia.

#Análisis y Conclusiones:
# La señal a muestrear tiene una elevada frecuencia respecto a la frecuencia de muestreo. Es por ello que se pierde muchísima información sobre la señal
# original, y de ahí que la frecuencia de la muestra, poco tiene que ver con la original.

# POORQUE 129 Hz DA UNA SEÑAL TAN COHERENTE?
