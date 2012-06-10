%Funciones para el an�lisis Tiempo-Frecuencia:
% Compatible con octave y matlab
% 
% Autores: 
% Leandro Di Persia
% Leandro Vignolo
% Ultima versión: 30/05/2007
%
% demoft.m - Demostracion del uso de las funciones incluidas
%
% todd.m - Calcula y grafica la transformada wavelt diadica
% tocon.m - Calcula y grafica la transformada wavelet continua
% (discretizada)
% escalogramad - Funcion para graficar el resultado de todd.m
% viewwave - Funcion para graficar las funciones de escala y wavelet.
% cohendist.m - Distribuci�n de Choi-Williams
% windowft.m - Transformada de Fourier de tiempo corto ventaneada
% spectrogram.m - Espectrograma (STFT^2) calculado con una ventana cuadrada
% iwindowft.m - Transformada de Fourier de Tiempo corto inversa
% makewindow.m - Funci�n para generar ventanas 
% wignerdist.m - Distribuci�n de Wigner-Ville
%
%Funciones para generar formas de se�ales moduladoras
%
% amexpo1s.m - Genera se�al modulada en amplitud con exponencial unilateral.
% amexpo2s.m - Genera se�al modulada en amplitud con exponencial bilateral.
% amgauss.m  - Genera se�al modulada en amplitud con una gausiana.
% amrect.m   - Genera se�al modulada en amplitud con una rectangular.
% amtriang.m - Genera se�al modulada en amplitud con una triangular.
%   
%Funciones para generar se�ales de frecuencia instantanea variable
%   
% fmconst.m  - Se�al con modulaci�n de frecuencia constante.
% fmhyp.m    - Se�al con modulaci�n de frecuencia hiperbolica.
% fmlin.m    - Se�al con modulaci�n de frecuencia lineal.
% fmodany.m  - Se�al con modulaci�n de frecuencia arbitraria.
% fmpar.m    - Se�al con modulaci�n de frecuencia parabolica.
% fmpower.m  - Se�al con modulaci�n de frecuencia con una ley potencial.
% fmsin.m    - Se�al con modulaci�n de frecuencia sinusoidal.
%
%Generacion de funciones especiales
%
% atoms.m    - Combinaci�n lineal de �tomos tiempo-frecuencia gaussianos. 
%
%Adicion de ruidos aleatorios
%
% sigmerge.m - Suma dos se�ales con una dada relaci�n se�al ruido (SNR) en dB.
%
%
%Las demas funciones del directorio son funciones auxiliares para el c�lculo de �stas.
%
% El toolbox como esta, funciona perfectamente tanto en octave como en
% matlab.
% Si se tiene disponible el toolbox de wavelets de matlab:
%Para las transformadas Wavelets, utilizar (vienen con el toolbox de wavelets que incluye 
% matlab):
%
% cwt.m - Transformada Wavelet Continua (en realidad es la versi�n discretizada)
% dwt.m - Transformada wavelet discreta (es la diadica, descompone en un nivel de 
%         aproximaci�n y detalle, hay que pasarle los filtros H y G ya generados)
% wfilters.m - Genera los filtros para la transformada diadica
% idwt.m - Transformada wavelt diadica inversa, reconstruye un niver a partir de los 
%          coeficientes de aproximacion y detalle a esa escala
% wavedec.m - Hace la descomposici�n wavelet diadica hasta el nivel deseado, usando la 
%             wavelet indicada
% waverec.m - Reconstruye la se�al a partir de la transformada wavelet diadica
%
% OTras �tiles:
% Waveinfo.m - Informaci�n sobre varias familias de wavelets
% wmaxlev.m - Determina el nivel m�ximo de descomposici�n para una se�al dada (ayuda a 
%             elegir el nivel �ptimo de decomposici�n)
%
%
% Se han tomado algunas funciones del Toolbox WaveLab 8.02:
% Part of WaveLab Version 802
% Built Sunday, October 3, 1999 8:52:27 AM
% This is Copyrighted Material
% For Copying permissions see COPYING.m
% Comments? e-mail wavelab@stat.stanford.edu
%   
%Otras funciones pertenecen al Toolbox de analisis Tiempo- Frecuencia
% Time-Frequency Toolbox.
% Version 1.0 January 1996
% Copyright (c) 1994-96 by CNRS (France) - RICE University (USA).
%
% Y otras del wavekit de Harri Ojanen
% (C) 1993-1997 Harri Ojanen
