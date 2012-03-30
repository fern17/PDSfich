1;

fuego = wavread("fuego.wav");
n = length(fuego);
fade_out = 1:-1/n:0 + 1/n ;
fade_out = fade_out';
fuegonuevo = fade_out .* fuego;
plot(fuegonuevo, 'b');
hold on;
wavwrite(fuegonuevo, 48000,"fuegofadeout.wav");
