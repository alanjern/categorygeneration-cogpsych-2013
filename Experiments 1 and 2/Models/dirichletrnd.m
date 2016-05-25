function x = dirichletrnd(alpha)
%DIRICHLETRND Random vector from a dirichlet distribution.
%   x = dirichletrnd(alpha) returns a vector randomly selected
%   from the Dirichlet distribution with parameter vector alpha.
%
%   The algorithm used is the following:
%   For each alpha(i), generate a value s(i) with distribution
%   Gamma(alpha(i),1).  Now x(i) = s(i) / sum_j s(j).
%   
%   Reference: Luc Devroy. Non-Uniform Random Variate Generation
%   (originally published with Springer-Verlag, New York, 1986)
%   http://cgm.cs.mcgill.ca/~luc/rnbookindex.html, communicated
%   to me by Radford Neal and Iain Murray.
%
%   Author: David Ross
%   $Id$

%-------------------------------------------------
% Check the input
%-------------------------------------------------
error(nargchk(1,1,nargin));

if min(size(alpha)) ~= 1 | length(alpha) < 2
    error('alpha must be a vector of length at least 2');
end


%-------------------------------------------------
% Main
%-------------------------------------------------
gamma_vals = gamrnd(alpha, ones(size(alpha)), size(alpha));
denom = sum(gamma_vals);
x = gamma_vals / denom;