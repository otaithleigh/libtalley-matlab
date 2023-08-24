function wrapped = silentWarningWrapper(func, warnid)
%silentWarningWrapper  Wrap a function to run while suppressing warning
%
%   WRAPPED = silentWarningWrapper(FUNC, WARNID) returns a new function 
%       WRAPPED that takes the same inputs and outputs as FUNC, but
%       suppresses the warning specified by WARNID when called. The previous
%       warning state is restored when WRAPPED returns (or errors out).
%
% Use `[~,WARNID] = lastwarn` to get the warning ID of the last raised
% warning.
%
% See also: warning, lastwarn
%

function varargout = wrapped_func(varargin)
    warnstate = warning('off', warnid);
    cleanup = onCleanup(@()warning(warnstate));
    [varargout{1:nargout}] = func(varargin{:});
end

wrapped = @wrapped_func;

end
