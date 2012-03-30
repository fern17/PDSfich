1;

kaniche = wavread("kaniche.wav");
n = length(kaniche);
ruido = randn(n,1);
ruido = ruido/max(kaniche)/40;

potencia_senal = norm(kaniche,2)^2/n;
potencia_ruido = norm(ruido,2)^2/n;

snr = potencia_senal/potencia_ruido;
snrdb = 10*log(snr);
snr_decibeles = 20;

%Beta es la constante que multiplica al ruido original para que cumpla la relacion a ruido
% establecida en snr_decibeles (por enunciado)
beta = sqrt(potencia_senal * 10^(-snr_decibeles/10) / potencia_ruido)

ruidonuevo = beta*ruido;
resultado = kaniche + ruidonuevo;

wavwrite(resultado, 48000,"kanichemasruidolimitado.wav");
