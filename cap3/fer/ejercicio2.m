1;
EPS = 0.00000001
t0 = 0;
Tm = 0.001;
tf = 1;
t = t0:Tm:tf-Tm;

%genero funciones de enunciado
yseno2 = sin(2*pi*2*t);
ycuadrada = sign(sin(2*pi*2*t));
yseno4 = sin(2*pi*4*t);

disp("1: seno 2 Hz")
disp("2: cuadrada 2 Hz")
disp("3: seno 4 Hz")
disp("4: seno 3.5 Hz")

%Inciso 1

%calculo ortogonalidad en el tiempo
dot12 = dot(yseno2,ycuadrada);
dot13 = dot(yseno2,yseno4);
dot23 = dot(ycuadrada,yseno4);


disp("Se calcula ortogonalidad en el tiempo")
if (abs(dot12) < EPS)
    disp("1 y 2 son ortogonales")
else
    disp("1 y 2 no son ortogonales")
end

if (abs(dot23) < EPS)
    disp("2 y 3 son ortogonales")
else
    disp("2 y 3 no son ortogonales")
end

if (abs(dot13) < EPS)
    disp("1 y 3 son ortogonales")
else
    disp("1 y 3 no son ortogonales")
end

%Inciso 2:
%transformo
Y_seno2 = fft(yseno2);
Y_cuadrada = fft(ycuadrada);
Y_seno4 = fft(yseno4);

%calculo ortogonalidad en la frecuencia
dot_12 = dot(Y_seno2,Y_cuadrada);
dot_13 = dot(Y_seno2,Y_seno4);
dot_23 = dot(Y_cuadrada,Y_seno4);

disp("Se calcula ortogonalidad en la frecuencia")

if (abs(dot_12) < EPS)
    disp("1 y 2 son ortogonales")
else
    disp("1 y 2 no son ortogonales")
end
if (abs(dot_23) < EPS)
    disp("2 y 3 son ortogonales")
else
    disp("2 y 3 no son ortogonales")
end

if (abs(dot_13) < EPS)
    disp("1 y 3 son ortogonales")
else
    disp("1 y 3 no son ortogonales")
end

%Inciso 3:
yseno35 = sin(2*pi*3.5*t);
Y_seno35 = fft(yseno35);

dot14 = dot(yseno2,yseno35);
dot_14 = dot(Y_seno2,Y_seno35);

disp("Se calcula ortogonalidad en el tiempo")
if (abs(dot14) < EPS)
    disp("1 y 4 son ortogonales")
else
    disp("1 y 4 no son ortogonales")
end

disp("Se calcula ortogonalidad en la frecuencia")
if (abs(dot_14) < EPS)
    disp("1 y 4 son ortogonales")
else
    disp("1 y 4 no son ortogonales")
end

pause;
