function tf = isclose(a, b, params)
%ISCLOSE  Check if two matrices are equal within tolerance (per-element)
%
%   Elements evaluate to true if the following equation is satisfied:
%
%       abs(a - b) <= atol + rtol*abs(b)
%
%   Note that the equation is not symmetric, as b is assumed to be the
%   reference value. In certain cases the order of a and b can give
%   different results.
%
%   From the NumPy documentation:
%
%   > Furthermore, the default value of `atol` is not zero, and is used to
%   > determine what small values should be considered close to zero. The
%   > default value is appropriate for expected values of order unity: if
%   > the expected values are significantly smaller than one, it can result
%   > in false positives. `atol` should be carefully selected for the use
%   > case at hand. A zero value for `atol` will result in `False` if either
%   > `a` or `b` is zero.
%
%   Parameters
%   ----------
%   a, b : double
%       Matrices to check.
%   
%   Keyword Parameters
%   ------------------
%   RelTol
%       Relative tolerance. (default: 1e-5)
%   AbsTol
%       Absolute tolerance. (default: 1e-8)
%
%   Examples
%   --------
%   >> isclose([1e-14, 1e12], [1e-12, 1e10])
%   ans =
%
%     1×2 logical array
%
%      1   0
%
%   See also allclose
%
arguments
    a
    b
    params.RelTol = 1e-5
    params.AbsTol = 1e-8
end

rtol = params.RelTol;
atol = params.AbsTol;
tf = abs(a - b) <= (atol + rtol*abs(b));

end
