1;

kaniche = wavread("kaniche.wav");
fuego = wavread("fuego.wav");

longitud_corto = min(length(kaniche), length(fuego));

kaniche = resize(kaniche,longitud_corto, 1);
fuego = resize(fuego,longitud_corto, 1);

result = kaniche + fuego;
plot(result);

wavwrite(result, 48000,"kanichemasfuego.wav");
