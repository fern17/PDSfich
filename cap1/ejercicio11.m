1;

fuego = wavread("fuego.wav");
n = length(fuego);

constante_producto = 10;
fuegonuevo = constante_producto * fuego;
plot(fuegonuevo, 'b');
hold on;
plot(fuego,'r')
wavwrite(fuegonuevo, 48000,"fuegoporconstante.wav");
