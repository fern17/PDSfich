%lectura de datos
eeg = load("eeg.txt")';
eeg = eeg(1:200); %ventana para no procesar todo
N = length(eeg);
tol = 0.1;
[A,orden] = widrowAdaptativo(eeg, tol);
orden
N = length(A);
coeficientes = A(N,:);
entrada = zeros(1,N);
entrada(1) = 1;
resp_dirac = filter([1],coeficientes,entrada);
trans_dirac = fft(resp_dirac);

hold on;
figure(1);
plot(eeg,'r');
figure(2);
plot(resp_dirac);
%figure(3);






pause;
