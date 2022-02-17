function fig2raster(figs, options)
%fig2raster  Convert a MATLAB figure to a raster image using export_fig
%
%   fig2raster(FIGS) converts the figures in FIGS to PNG files (300 DPI).
%
%   fig2raster(..., 'Background', BG_COLOR) uses BG_COLOR as the background
%       color for the saved images. (default: 'w')
%
%   fig2raster(..., 'Resolution', RES) specifies the resolution of the produced
%       raster in DPI. (default: 300)
%
%   fig2raster(..., 'Filename', FILENAME) if given, saves the produced raster
%       as FILENAME. If not given, a filename is produced from the 'Name'
%       property of the figure. If no 'Name' is present, a generic identifier is
%       used instead. (default: [])
%
%   fig2raster(..., 'SaveDirectory', DIR) saves all rasterized figures to DIR.
%
%   fig2raster(..., 'Format', FMT) specifies the raster image format to convert
%       to. Currently supported: 'jpg', 'png', 'tiff'. (default: 'png')
%
%   See also export_fig
%
arguments
    figs
    options.Background = 'w'
    options.Resolution = 300
    options.Filename
    options.SaveDirectory
    options.Format {mustBeMember(options.Format, {'jpg', 'png', 'tiff'})} = 'png'
end

% If path, open that figure
if ~isa(figs, 'matlab.ui.Figure')
    figpaths = string(figs);
    figs = gobjects(size(figpaths));
    for i = 1:length(figpaths)
        figs(i) = openfig(figpaths(i));
    end
end

for i = 1:length(figs)
    single_fig2raster(figs(i), i, options)
end

end

function single_fig2raster(fig, fignum, options)
arguments
    fig (1,1) matlab.ui.Figure
    fignum (1,1) uint64
    options
end

fig.Color = options.Background;

% If filename given, use that. Else get from figure. If both are empty, use
% "figure.png"
if isfield(options, 'Filename')
    filename = options.Filename;
else
    filename = slugify(fig.Name);
end

if isempty(filename)
    filename = sprintf('figure%03d', fignum);
end

% Append format
if ~endsWith(filename, options.Format)
    filename = strjoin(string({filename, options.Format}), '.');
end

% Add directory
if isfield(options, 'SaveDirectory')
    if ~isfolder(options.SaveDirectory)
        mkdir(options.SaveDirectory)
    end
    filename = fullfile(options.SaveDirectory, filename);
end

% Handle options
figoptions = {
    '-nocrop'                            % Respect actual figure size
    '-q101'                              % Lossless compression
    sprintf('-r%d', options.Resolution)  % DPI
};

% Silence deprecation warning; nothing *I* can do about it!
export = silentWarningWrapper(@export_fig, ...
                              'MATLAB:ui:javaframe:PropertyToBeRemoved');
export(filename, figoptions{:}, fig);

end
