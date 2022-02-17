function wrapped = partial(func, varargin)
%PARTIAL  Create a function closure
%
%   WRAPPED = PARTIAL(FUNC, VARARGIN) creates a closure WRAPPED around FUNC
%       that passes VARARGIN to FUNC when called (after any additional
%       arguments passed to WRAPPED).
%
%   Examples
%   --------
%
%   % Same as calling `disp([1 2 3])`
%   >> mydisp = partial(@disp, [1 2 3]);
%   >> mydisp()  % parentheses are required here, since `mydisp` is a handle
%        1     2     3
%
%   % Same as calling `zeros(2,3,'int8')`
%   >> int8zeros = partial(@zeros, 'int8');
%   >> int8zeros(2,3)
%
%   ans =
%
%     2×3 int8 matrix
%
%      0   0   0
%      0   0   0
%

partial_varargin = varargin;

function varargout = wrapped_func(varargin)
    [varargout{1:nargout}] = func(varargin{:}, partial_varargin{:});
end

wrapped = @wrapped_func;

end
