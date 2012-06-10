
fm = 100;
T = 1/fm;
t = -1:T:1-T;

gabor1 = exp(-18/2*t.^2);
[spc, ff,tt] = specgram(gabor1);

imagesc(tt,ff,flipud(log(abs(spc))));

pause;
