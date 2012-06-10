function soft=chksft
%
% Averigua si se está utilizando Octave o Matlab
%
% 04/07 - Leandro D. Vignolo
%
 
p = path;
m = strfind(p,'octave');
octave = length(m);
m = strfind(p,'matlab');
matlab = length(m); 
if (octave>=matlab) soft='octave'; else soft='matlab'; end;

end 
