function x = wexte(x,lf)
      sx = length(x);
      if rem(sx,2) , x(sx+1) = x(sx); sx = sx+1; end
      I = getPerIndices(sx,lf);
      x = x(I);

%-------------------------------------------------------------------------%
% Internal Function(s)
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
function I = getPerIndices(lx,lf)

      I = [lx-lf+1:lx , 1:lx , 1:lf];

if lx<lf
    I = mod(I,lx);
    I(I==0) = lx;
end
%-------------------------------------------------------------------------%
