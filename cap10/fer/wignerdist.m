function afwig = wignerdist(sig)
% WignerDist -- Alias-Free Wigner-Ville Distribution
%  Usage
%    afwig = WignerDist(sig)
%  Inputs
%    sig     1-d signal
%  Outputs
%    afwig   complex-valued matrix representing the alias-free
%            Wigner-Ville distribution of zero-extended signal with
%            rows corresponding to frequencies and columns corresponding
%            to times.
%
%  Side Effects
%    Image Plot of the alias-free Wigner-Ville distribution
%
%  See Also
%	Interpol2
%
%  References
%   Mallat's book, sections 4.5.1 and 4.5.4
%
sig = sig(:);
N   = length(sig);
sig = interpol2(sig);
f = [zeros(2*N,1) sig zeros(2*N,1)];
afwig = zeros(N, N);
q  = (0 : 2*N-1);
p(1:N) = q(1:N);
p(N+1:2*N) = q(N+1:2*N) - 2*N;
for n=1:N,
     nplus    = 2*n + p;
     nminus   = 2*n - p;
    x = f(2*N+nplus) .* conj(f(2*N+nminus));
    aux = fft(x);
    afwig(:,n) = aux(1:2:2*N-1)';
end
% this should be zero :
max(max(abs(imag(afwig(1:N/2,:)))));
abstf = real(afwig(1:N/2,:));%.*(real(afwig(1:N/2,:))>=zeros(N/2,N));
tfmax = max(max(abstf));
tfmin = min(min(abstf));
[pp,qq]=size(abstf);
if (chksft!='octave')
   %graph3(abstf,linspace(0,N-1,11),linspace(0,N/2,10)/N);
   imagesc(linspace(0,N-1,11),linspace(0,N/2,10)/N,abstf);
   title('WignerVille Distribution');
   xlabel('Time');
   ylabel('Frequency');
else
   colormap(jet);
   %colormap(1-gray(256))
   imagesc(linspace(0,N-1,N),linspace(0,N/2,N/2)/N,abstf);
   colorbar;
   axis('xy');
   title('WignerVille Distribution');
   xlabel('Time');
   ylabel('Frequency');
end
% Written by Maureen Clerc and Jerome Kalifa, 1997
% clerc@cmapx.polytechnique.fr, kalifa@cmapx.polytechnique.fr
    
    
    
%   
% Part of WaveLab Version 802
% Built Sunday, October 3, 1999 8:52:27 AM
% This is Copyrighted Material
% For Copying permissions see COPYING.m
% Comments? e-mail wavelab@stat.stanford.edu
%   
    
