clear;
hold off;

% Ejercicio 1:

function y=signal(t)
	f1 = 10; % 10 hz
	f2 = 20; % 20 hz
	y = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t);
endfunction

%Señal para la parte 2..... Cambiar en la linea: s = signal(t);
function y=signal2(t)
	f1 = 10; 
	f2 = 20; 
	y = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t) + 4;
endfunction

function y=signal3(t)
	f1 = 10; 
	f2 = 11; 
	y = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t);
endfunction


function y=signal4(t)
	f1 = 10; 
	f2 = 10.5; 
	y = sin(2*pi*f1*t) + 4*sin(2*pi*f2*t);
endfunction


% Periodo de Muestreo
Tm = 0.001;
Fm = 1/Tm;

% Dominio Temporal
t = 0:Tm:0.72-Tm;
N = length(t);

% Muestreo la función
s = signal(t);
% Calculo la transformada de Fourier by Octave
S = fft(s);


% TDF y dividimos por N ya que matlab no implementa esto.
% abs es lo mismo que S = sqrt(real(S).^2 + imag(S).^2);
S_mod =  2 * fftshift(S) / N ;

% Dominio frecuencial df = 1/T0  tal que T0 es la duración total de la señal en el tiempo.
df = Fm/N;
f = -Fm/2:df:Fm/2-df;

figure(1);
stem(f, abs(S_mod));

figure(2);
plot(t,s);


% parte 2. Verificacion de la relación de Parseval

izquierda = sum(s.^2);

derecha = (1/N) * sum( abs(S).^2 );

if (izquierda-derecha < 0.00001) % comparacion tolerancia
	disp("Se cumple Parseval");
else
	disp("No se cumple Parseval");
end	

# 1.2) Cuando se agrega una componente continua a la señal +4 para normalizarlo no hay que 
# multiplicar por dos ya que no viene acompañado de un senoidal.

% 1.3) Se modificó la frecuencia y se observa claramente el pico en el espectro de frecuencia.
% 1.4) Lo que ocurre aquí es que nuestra resulcion del espectro de frecuencia no contempla esta fraccion
%	Es por ello que la componente de frecuencias 10.5 se distrubuye proporcionalmente en las
%	frecuencias más parecidas. Esto viene como consecuencia del producto interno entre la senal
%	y las exponenciales complejas de la base elegida.
%
% 1.5) Problemas de resolucion de frecuencia...
%		Cuando tenemos el limite superior de 0.72: La Fm siempre es 1000
%		y df = Fm/N = 1000/0.72 no es un multiplo de las frecuencias que qeuremos observar en la señal
%		Es por esto que no se ven como barras, sino como una dispercion en las frecuencias cercanas.
%
%
%
%
%
%
%
%
%
%
%
%
%
%