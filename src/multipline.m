function h = multipline(ax, x, y, options, patchoptions)
%MULTIPLINE  draw multiple lines as a single patch object.
%
%   MULTIPLINE(AX, X, Y) plots the data in the arrays X and Y as a single patch
%   object on axes AX. The plot will appear to be separate lines that all have
%   the same appearance. X and Y may each be either vectors or matrices.
%
%   H = MULTIPLINE(...) returns the handle to the plotted patch object.
%
%   MULTIPLINE takes the same NAME, VALUE pair options as PLINE.
%
%   Since the line is technically a patch, a legend referencing it will draw a
%   box filled with the patch's face color (black, here). To get around this,
%   use `legendline` to create a fake line with no data but with the same line
%   style.
%
%   See also pline, legendline, patch
%
arguments
    ax
    x (:,:) double
    y (:,:) double
    options.Color
    options.Alpha
    patchoptions.?matlab.graphics.primitive.Patch
end

% max num of dimensions = 2 is set by arguments block, so checking with
% `isvector` is sufficient to get all possible combinations
vector = [isvector(x) isvector(y)];
if all(vector == [false false])
    % Both matrices
    if any(size(x) ~= size(y))
        error('if matrices, x and y must be the same size')
    end
    x = [x; nan(1, size(x, 2))];
    y = [y; nan(1, size(y, 2))];
    x = x(1:end-1);
    y = y(1:end-1);
elseif all(vector == [true true])
    % Both vectors
    if length(x) ~= length(y)
        error('if vectors, x and y must be the same length')
    end
    x = x(:);
    y = y(:);
elseif all(vector == [true false])
    % vector x, matrix y
    if length(x) ~= size(y, 1)
        error('if vector, x must be the same length as the columns of y')
    end
    x = repmat([x(:); nan], 1, size(y, 2));
    y = [y; nan(1, size(y, 2))];
    x = x(1:end-1);
    y = y(1:end-1);
elseif all(vector == [false true])
    % matrix x, vector y
    if length(y) ~= size(x, 1)
        error('if vector, y must be the same length as the columns of x')
    end
    x = [x; nan(1, size(x, 2))];
    y = repmat([y(:); nan], 1, size(x, 2));
    x = x(1:end-1);
    y = y(1:end-1);
end

options = namedargs2cell(options);
patchoptions = namedargs2cell(patchoptions);
h = pline(ax, x, y, options{:}, patchoptions{:});

if nargout == 0
    clear h
end
end
