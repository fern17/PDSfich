clear all;
fm = 8000;
T = 1/fm;
t = 0:T:1-T;
senal = sin(2*pi*(100+50*t).*t);
[spec, frec, time] = specgram(senal);
imagesc(time,frec,flipud(log(abs(spec))));
pause;
