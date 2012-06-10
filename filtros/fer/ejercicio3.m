
%pasabanda con frec de corte de 2500 y 3000.
% atenuacion maxima en banda de paso 0.7 dB
% atenuacion minima en banda rechazo 55 dB
% Banda de transicion < 200 Hz
% frec senales = 10kHz


fm = 10000;
fmax = fm/2;
f1 = 2500;
f2 = 3000;
delta = 200;
at_max = 0.7;
at_min = 55;
pasos = fmax;

[n_butter, Wc_butter] = buttord([f1/fmax f2/fmax],[(f1-delta)/fmax (f2+delta)/fmax], at_max, at_min);
%n_butter
[b_butter, a_butter] = butter(5, Wc_butter);
%[b_butter, a_butter] = butter(ceil(n_butter/2), Wc_butter);

[n_cheb1, w_cheb1] = cheb1ord([f1/fmax f2/fmax], [(f1-delta)/fmax (f2+delta)/fmax], at_max, at_min);
%n_cheb1
[b_cheb1, a_cheb1] = cheby1(5, at_max, w_cheb1);
%[b_cheb1, a_cheb1] = cheby1(n_cheb1, at_max, w_cheb1);

[n_cheb2, w_cheb2] = cheb2ord([f1/fmax f2/fmax], [(f1-delta)/fmax (f2+delta)/fmax], at_max, at_min);
%n_cheb2
[b_cheb2, a_cheb2] = cheby2(5, at_min, w_cheb2);
%[b_cheb2, a_cheb2] = cheby2(n_cheb2, at_min, w_cheb2);

[n_ellip, Wc_ellip] = ellipord([f1/fmax f2/fmax],[(f1-delta)/fmax (f2+delta)/fmax], at_max, at_min);
%n_ellip
[b_ellip, a_ellip] = ellip(n_ellip, at_max, at_min, Wc_ellip);

%figure(1); plot(abs(freqz(b_butter,a_butter,pasos))); title("Filtro de Butterworth. Orden 5"); xlabel("Frecuencia (Hz.)"); ylabel("|H(z)|"); ylim([0, 1]);
%figure(2); plot(abs(freqz(b_cheb1,a_cheb1,pasos))); title("Filtro de Chevyshev Tipo 1. Orden 5"); xlabel("Frecuencia (Hz.)"); ylabel("|H(z)|"); ylim([0, 1]);
%figure(3); plot(abs(freqz(b_cheb2,a_cheb2,pasos))); title("Filtro de Chevyshev Tipo 2. Orden 5"); xlabel("Frecuencia (Hz.)"); ylabel("|H(z)|"); ylim([0, 1]);
figure(4); plot(abs(freqz(b_ellip,a_ellip,pasos))); title("Filtro Eliptico. Orden 5"); xlabel("Frecuencia (Hz.)"); ylabel("|H(z)|");

pause;
