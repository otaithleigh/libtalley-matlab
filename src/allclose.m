function tf = allclose(a, b, params)
%ALLCLOSE  Check if every element in two arrays is close within tolerance.
%
%   Equivalent to `all(isclose(a, b, options...))`.
%
%   See also isclose
%
arguments
    a
    b
    params.RelTol = 1e-5
    params.AbsTol = 1e-8
end

tf = all(isclose(a, b, 'RelTol', params.RelTol, 'AbsTol', params.AbsTol));

end
