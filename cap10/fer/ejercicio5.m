
fm = 1000;
T = 1/fm;
t = 0:T:1 - T;
t = [0:0.005:2.56-0.005]; % N=512

senal = sin(2*pi.*exp(t).*t);
nombre = "db8";
nivel = 10;

[a,d] = todd(senal,ondita('haar'),8);
escalogramad(a,d,length(senal),8);

figure(2); plot(senal);
pause;
