function [fig, t, ax] = newgrid(x, y, options, tileoptions)
%
%   [FIG, T, AX] = NEWGRID(X, Y) returns a new figure FIG with an X-by-Y
%       tiledlayout T, with the axes in the X-by-Y array AX.
%
%   Name-value arguments
%   --------------------
%   "Hold" : {"on" (default), "off"}
%       Whether the axes in AX are held or not.
%
%   "Style" : {"display" (default), "paper"}
%       The style to use for the figure. "display" optimizes for on-screen use;
%       "paper" optimizes for printing.
%
%   "Height" : double  (default: 2.25)
%       The height of individual "paper"-style subfigures, in inches.
%
%   "Width" : {"single" (default), "double"}
%       The width of "paper"-style figures. "single" produces 3.5" wide figures,
%       "double" produces 7" wide figures. No effect on "display"-style figures.
%
%   NEWGRID also accepts all the same name-value arguments as the TILEDLAYOUT
%   function.
%
%   See also TILEDLAYOUT
%
arguments
    x (1,1) {mustBeInteger(x)}
    y (1,1) {mustBeInteger(y)}
    options.Hold (1,1) matlab.lang.OnOffSwitchState = "on"
    options.Style (1,1) string {mustBeMember(options.Style, ["display", "paper"])} = "display"
    options.Height (1,1) double = 2.25
    options.Width (1,1) string {mustBeMember(options.Width, ["single", "double"])} = "single"
    tileoptions.?matlab.graphics.layout.TiledChartLayout
    tileoptions.Padding = 'compact'
    tileoptions.TileSpacing = 'compact'
end

% Styling
axesoptions = struct;
figureoptions = struct;

axesoptions.Box = "on";
axesoptions.TickLength = [0.02 0.02];

widths = containers.Map(["single", "double"], [3.5, 7.0]);
paperwidth = widths(options.Width);
paperheight = options.Height*x;

switch options.Style
case "display"
    axesoptions.FontSize = 12;
    figureoptions.Units = "pixels";
    figureoptions.Position = [0 0 1920 1080];
    figureoptions.PaperUnits = "points";
    figureoptions.PaperSize = [1920 1080];
case "paper"
    figureoptions.Units = "inches";
    figureoptions.Position = [1 1 paperwidth paperheight];
    figureoptions.PaperUnits = "inches";
    figureoptions.PaperSize = [paperwidth paperheight];
    axesoptions.FontSize = 8;
    axesoptions.DefaultLineLineWidth = 1;
end
figureoptions = namedargs2cell(figureoptions);
tileoptions = namedargs2cell(tileoptions);

% Create the grid
fig = figure(figureoptions{:});
t = tiledlayout(fig, x, y, tileoptions{:});
ax = gobjects(x, y);
for i = 1:x
    for j = 1:y
        ax(i,j) = nexttile(t, (i - 1)*y + j);
        set(ax(i,j), axesoptions);
        hold(ax(i,j), options.Hold);
    end
end

end
