function rnd = wblrnd_octave(lambda, k, varargin)
% This function produces independent random variates from the Weibull distribution.

  if (nargin < 2)
    fprintf('Usage: wblrnd_octave(lambda, k)  or wblrnd_octave(lambda, k, size)\n');
  end

  if (nargin == 2)
    sz = 1;
  elseif (nargin == 3)
    sz = [varargin{1} varargin{1}];
  elseif (nargin == 4)
    sz = [varargin{1} varargin{2}];
  end  

  rnd = lambda.*(-log(rand(sz))).^(1./k);
end
