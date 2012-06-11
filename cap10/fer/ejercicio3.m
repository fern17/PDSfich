
fm = 1000;
T = 1/fm;
t = -1:T:1-T;
sigma = 0.3;
gabor1 = exp((-18/2)*t.^2);
gabor2 = exp((-5/2)*t.^2);

%afwig1 = wignerdist(gabor1);
%afwig2 = wignerdist(gabor2);
cohendist(gabor1,sigma);
cohendist(gabor2,sigma);
pause;
