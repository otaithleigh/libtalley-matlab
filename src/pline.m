function h = pline(ax, x, y, options, patchoptions)
%PLINE  line plotted using PATCH, allowing for more options
%
%   PLINE(AX, X, Y) plots the data in vectors X and Y as a line on axes AX
%   using the PATCH command which allows for some additional graphics options.
%
%   PLINE(..., "NAME", VALUE) plots the data using options specified as NAME,
%   VALUE pairs. PLINE accepts all valid PATCH properties, as well as the short
%   names "Color" and "Alpha", which map to the PATCH properties "EdgeColor" and
%   "EdgeAlpha" respectively. Note that "Face" properties will have no effect
%   since the patch has zero width; use "Edge" properties instead.
%
%   H = PLINE(...) returns the handle to the plotted patch object.
%
%   Since the line is technically a patch, a legend referencing it will draw a
%   box filled with the patch's face color (black, here). To get around this,
%   use `legendline` to create a fake line with no data but with the same line
%   style.
%
%   See also multipline, legendline
%
arguments
    ax
    x (:,1) double
    y (:,1) double
    options.Color
    options.Alpha
    patchoptions.?matlab.graphics.primitive.Patch
end
if isfield(options, "Color")
    patchoptions.EdgeColor = options.Color;
end
if isfield(options, "Alpha")
    patchoptions.EdgeAlpha = options.Alpha;
end
options = namedargs2cell(patchoptions);

% Facecolor = 'k' is (essentially) ignored here, but syntactically necessary
h = patch(ax, [x; NaN], [y; NaN], 'k', options{:});

if nargout == 0
    clear h
end
