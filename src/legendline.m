function h = legendline(ax, pline)
%LEGENDLINE  create a line object for a legend based on a patch
%
%   H = LEGENDLINE(PLINE) adds a fake line with no data to the current axes,
%       with line style based on the patch PLINE, returned in the handle H.
%
%   H = LEGENDLINE(AX, PLINE) adds a fake line with no data to the axes AX, with
%       line style based on the patch PLINE, returned in the handle H.
%
%   Intended for use with `pline` or `multipline`, which draw lines using the
%   `patch` command. Attempting to use the patch objects directly in a legend
%   won't look right, so instead a fake line that has the same line style as the
%   patch can be used.
%
%   See also pline, multipline
%
if nargin == 1
    pline = ax;
    ax = gca();
end

args = struct;
args.Color = pline.EdgeColor;
args.LineStyle = pline.LineStyle;
args.LineWidth = pline.LineWidth;
args.Marker = pline.Marker;
args.MarkerEdgeColor = pline.MarkerEdgeColor;
args.MarkerFaceColor = pline.MarkerFaceColor;
args.MarkerSize = pline.MarkerSize;
args = namedargs2cell(args);

h = line(ax, NaN, NaN, args{:});

end
