function specgm = spectrogram(sig,w,m,titl)

% Spectrogram -- Time-Varying Spectrum
%  Usage
%    specgm = Spectrogram(sig,w,m,titl)
%  Inputs
%    sig      1-d signal
%    w        window half-length, default = n/2
%    m        inter-window spacing, default=1
%    titl     Optional Title String Modifier
%  Outputs
%    specgm   spectrogram
%
%  Side Effects
%    Image Plot of the spectrogram
%
%  See Also
%    WVDist, WVDist_AF, ImagePhasePlane
%
%
sig = sig(:);
%sig=sig'
	n = length(sig);
	f = [zeros(n,1); sig; zeros(n,1)];
%
	if nargin < 2,
		w = n/2;
	end
	if nargin < 3,
		m=1;
	end
	if nargin < 4,
		titl = [];
	end
%
	nw     = floor(n ./ m);
	specgm = zeros(w+1,nw);
	ix     = ((-w+1):w);
%
	for l=1:nw,
		t = 1+ (l-1)*m;
		%if m==1 & rem(t,16)==1,
		%	fprintf('Spectrogram: t=%i\n',t);
 		%end

		tim = n + t + ix;
		seg = f(tim);
		localspec = abs(fft(seg));
		specgm(:,l)  = localspec(1:(w+1));
	end
specgm=specgm.^2;
%
% Make Spectrogram Display

   spmax = max(max(specgm));
   spmin = min(min(specgm));
   [pp,qq]=size(specgm);
if (chksft=='octave')
   title(titl);
   xlabel('Time')
   ylabel('Frequency')
   graph3(specgm,linspace(0,n-1,11),linspace(0,pp,10)/(2*pp));
else
   colormap(jet);
   imagesc(linspace(0,n-1,n),linspace(0,n/2,n/2)/n,specgm);
   colorbar
   axis('xy')
   title(titl);
   xlabel('Time')
   ylabel('Frequency')
end

   
	if nargout==0,
		specgm = [];
	end

%
% Copyright (c) 1995, David Donoho
%
    
    
%   
% Part of WaveLab Version 802
% Built Sunday, October 3, 1999 8:52:27 AM
% This is Copyrighted Material
% For Copying permissions see COPYING.m
% Comments? e-mail wavelab@stat.stanford.edu
%   
    
