1;
clear all;

[sound1,sr1] = wavread("kaniche.wav");
[sound2,sr2] = wavread("fuego.wav");
T = 0.6;

%calcula los picos de energia de un sonido
function [peaks1 peaks2] = calcularPicos(sound1,sr1,sound2,sr2,T)
    N1 = length(sound1);
    peaks1 = zeros(1,N1);
    j = 1;
    for i=1:length(sound1)
        if(abs(sound1(i)) < T)
            sound1(i) = 0;
        else 
            peaks1(j) = sound1(i);
            j = j+1;
        end
    end
    peaks1 = peaks1(1:(j-1));

    N2 = length(sound2);
    peaks2 = zeros(1,N2);
    j = 1;
    for i=1:length(sound2)
        if(abs(sound2(i)) < T)
            sound2(i) = 0;
        else 
            peaks2(j) = sound2(i);
            j = j+1;
        end
    end

    peaks2 = peaks2(1:(j-1));
endfunction

%   [peaks1 peaks2] = calcularPicos(sound1,sr1,sound2,sr2,T);
%   n = length(peaks1);
%   m = length(peaks2);
%   if(n > m)
%       r = n;
%   else
%       r = m;
%   end

%   peaks1 = [peaks1 zeros(1,r-n)];
%   peaks2 = [peaks2 zeros(1,r-m)];

%   dif = dot(peaks1,peaks2);
%   hold on;
%   figure(1);
%   hist(peaks1);
%   figure(2);
%   hist(peaks2);

specgram(sound1,8192,sr1);
length(sound1)
ffts1 = fftshift(fft(sound1));
hold on;
plot(abs(ffts1));

pause;
