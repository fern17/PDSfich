1;

kaniche = wavread("kaniche.wav");
n = length(kaniche);
ruido = randn(n,1);
ruido = ruido/max(kaniche)/40;

result = kaniche + ruido;
plot(result);

wavwrite(result, 48000,"kanichemasruido.wav");
