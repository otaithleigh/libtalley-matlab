classdef arrayConstructor
% Mix-in that provides an interface similar to that of ZEROS, ONES, etc.
%
%   ARRAY() returns a scalar.
%
%   ARRAY(N) returns an N-by-N matrix.
%
%   ARRAY(M,N) or ARRAY([M N]) returns an M-by-N matrix.
%
%   ARRAY(M,N,P,...) or ARRAY([M N P ...]) returns an M-by-N-by-P-by-... array.
%
%   M, N, P, ... must all be scalars.
%
methods
    function obj = arrayConstructor(sz)
        arguments (Repeating)
            sz {mustBePositive(sz), mustBeInteger(sz)}
        end
        if isempty(sz)
            % No arguments, return scalar
            return
        elseif isscalar(sz)
            % Single argument has been passed. Scalar or matrix?
            if isscalar(sz{1})
                % ARRAY(N) -> ARRAY(N, N)
                sz = {sz{1}, sz{1}};
            else
                % ARRAY([M N P ...]) -> ARRAY(M, N, P, ...)
                sz = num2cell(sz{1});
            end
        end
        % After conversion, all elements in sz must be scalars.
        if ~all(cellfun(@isscalar, sz))
            error('MATLAB:NonScalarInput', 'Size inputs must be scalar.')
        end
        obj(sz{:}) = obj;
    end
end
end
