%HHSPECTRUM  compute Hilbert-Huang spectrum
% 
% [A,f,tt] = HHSPECTRUM(x,t,l,aff) computes the Hilbert-Huang spectrum
%
% inputs:
%   - x   : matrix with one signal per row
%   - t   : time instants
%   - l   : estimation parameter for instfreq (integer >=1 (1:default))
%   - aff : if 1, displays the computation evolution
%
% outputs:
%   - A   : instantaneous amplitudes 
%   - f   : instantaneous frequencies
%   - tt  : truncated time instants
%
% calls:
%   - hilbert  : computes the analytic signal
%   - instfreq : computes the instantaneous frequency
%   - disprog : displays the computation evolution
%
%Examples:
%
%s = randn(1,512);
%imf = emd(s);
%[A,f,tt] = hhspectrum(imf(1:end-1,:));
%
%s = randn(10,512);
%[A,f,tt] = hhspectrum(s,1:512,2,1);
%
% rem: need the Time-Frequency Toolbox (http://tftb.nongnu.org)
%
% See also
%  emd, toimage, disp_hhs
%
% G. Rilling, last modification 3.2007
% gabriel.rilling@ens-lyon.fr

function [A,f,tt] = hhspectrum(x,t,l,aff)

error(nargchk(1,4,nargin));

if nargin < 2

  t=1:size(x,2);

end

if nargin < 3

  l=1;

end

if nargin < 4

  aff = 0;

end

if min(size(x)) == 1
	if size(x,2) == 1
		x = x';
		if nargin < 2
			t = 1:size(x,2);
		end
	end
	Nmodes = 1;
else
	Nmodes = size(x,1);
end

lt=length(t);

tt=t((l+1):(lt-l));

for i=1:Nmodes

  an(i,:)=hilbert(x(i,:)')';
  f(i,:)=instfreq(an(i,:)',tt,l)';
  A=abs(an(:,l+1:end-l));

  if aff
	disprog(i,Nmodes,max(Nmodes,100))
  end

end
