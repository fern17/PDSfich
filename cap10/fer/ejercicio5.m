
fm = 1000;
T = 1/fm;
t = [0:T:2.048-T]; %para que me de una longitud exponencial de 2
N = length(t);
nv_desc = 8;
senal = sin(2*pi.*exp(2*t).*t);
nivel = 8; %cantidad de niveles de onditas

%ordenes de las onditas
ordenh = 1; %haar
ordend = 6; %daubechies
ordens = 6; %symlets
ordenc = 4; %coiflets

%Dibuja Ondita continua discretizada
inicio = 1;
fin = 50;
paso = 1;
figure(1); tocon(senal,inicio,fin,paso);
title("Transformada Ondita Continua");

%Dibujamos onditas de distintas familias
[a,d] = todd(senal,ondita('haar',ordenh),nivel);
figure(2); escalogramad(a,d,length(senal),8);
title("Transformada Ondita Discreta - Haar");

%Dibujamos onditas de distintas familias
[a,d] = todd(senal,ondita('daubechies',ordend),nivel);
figure(3); escalogramad(a,d,length(senal),nivel);
title("Transformada Ondita Discreta - Daubechies. Orden 6");

%Dibujamos onditas de distintas familias
[a,d] = todd(senal,ondita('symlets',ordens),nivel);
figure(4); escalogramad(a,d,length(senal),nivel);
title("Transformada Ondita Discreta - Symlets. Orden 6");

%Dibujamos onditas de distintas familias
[a,d] = todd(senal,ondita('coiflets',ordenc),nivel);
figure(5); escalogramad(a,d,length(senal),nivel);
title("Transformada Ondita Discreta - Coiflets. Orden 4");

%Dibujamos el espectrograma de la señal
figure(6); specgram(senal); title("STFT de la senal");

pause;
