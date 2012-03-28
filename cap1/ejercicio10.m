1;

kaniche = wavread("kaniche.wav");
n = length(kaniche);
ruido = randn(n,1);
ruido = ruido/max(kaniche)/40;

potencia_senal = norm(kaniche,2)^2/n;
potencia_ruido = norm(ruido,2)^2/n;

snr = potencia_senal/potencia_ruido
snrdb = 10*log(snr)


