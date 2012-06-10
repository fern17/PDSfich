function [a,d] = dwtstep(x,h0,h1)
% Compute sizes and shape.
lf = length(h0);
lx = length(x);

% Extend, Decompose &  Extract coefficients.
first = 2;
lenEXT = lf/2; last = 2*ceil(lx/2);
y = wexte(x,lenEXT);

% Compute coefficients of approximation.
z = wcon(y,h0,'valid'); 
a = z(first:2:last);

% Compute coefficients of detail.
z = wcon(y,h1,'valid'); 
d = z(first:2:last);
