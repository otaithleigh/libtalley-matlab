function s = namedformat(nfmt, input)
%NAMEDFORMAT  Format using Python-style named format identifiers.
%
%   In Python, you can do formatting with identifiers such as '%(foo)s',
%   and format this using a dictionary that has 'foo' as a key, instead of
%   relying on position. MATLAB lets you specify format by position, but
%   not name, such as '%1$s %2$s %1$s'. This function is a wrapper around
%   converting named positions to this style of formatting.
%
%   S = NAMEDFORMAT(FMT, M) returns the formatted string S using the format
%   string FMT and the containers.Map M, whose keys are the identifiers
%   specified by FMT.
%
%   >> fmt = 'test %(test.type)s %(test.incr)g';
%   >> m = containers.Map({'test.type', 'test.incr'}, {'NormDispIncr', 0.01});
%   >> s = namedformat(fmt, m);
%   >> disp(s)
%   test NormDispIncr 0.01
%
%   S = NAMEDFORMAT(FMT, ST) returns the formatted string S using the
%   format string FMT and the struct ST, whose fields are the identifiers
%   specified by FMT.
%
%   >> fmt = 'test %(type)s %(incr)g';
%   >> st = struct('type', 'NormDispIncr', 'incr', 0.01);
%   >> s = namedformat(fmt, st);
%   >> disp(s)
%   test NormDispIncr 0.01
%
%   S = NAMEDFORMAT(FMT, 'K1', V1, 'K2', V2, ...) returns the formatted
%   string S using the format string FMT and the name-value pair arguments
%   'K1', V1, 'K2', V2, etc.
%
%   >> fmt = 'test %(test.type)s %(test.incr)g'
%   >> s = namedformat(fmt, 'test.type', 'NormDispIncr', 'test.incr', 0.01);
%   >> disp(s)
%   test NormDispIncr 0.01
%
arguments
    nfmt string
end
arguments (Repeating)
    input
end

[fmt, map] = processformat(nfmt);

if isempty(input)
    % Empty input. Should only be valid if there are no identifiers.
    if isempty(map)
        inputargs = {};
    else
        error('namedformat:BadInput', ...
              'Empty input with non-empty format string')
    end
elseif length(input) == 1
    % Single input. Dispatch on type.
    input = input{1};
    switch class(input)
        case 'containers.Map'
            inputargs = getargs_Map(map, input);
        case 'struct'
            inputargs = getargs_struct(map, input);
        otherwise
            error('namedformat:BadInput', ...
                  'Unsupported input type "%s"', class(input))
    end
else
    % Name-value pairs.
    k = input(1:2:end);
    v = input(2:2:end);
    try
        m = containers.Map(k, v);
    catch err
        ME = MException('namedformat:BadInput', ...
            'Could not create input map from name-value pair arguments');
        ME = addCause(ME, err);
        throw(ME);
    end
    inputargs = getargs_Map(map, m);
end

try
    s = sprintf(fmt, inputargs{:});
catch err
    ME = MException('namedformat:FormattingFailed', 'Failed to format string');
    ME = addCause(ME, err);
    throw(ME);
end

end


%==========================================================================
% Process the format string
%==========================================================================
function [fmt, map] = processformat(nfmt)
%Convert Python-style named format identifiers to position-based format.

% Regex to match <odd number of %>(<identifier>), capturing the identifier.
% Python accepts... pretty much anything as an identifier.
%
% Valid identifier characters: anything that's not a parenthesis?
pat = '(?<!%)%(%%)*\((?<identifier>[^\(\)]*)\)';

matches = regexp(nfmt, pat, 'names');
if isempty(matches)
    fmt = nfmt;
    map = containers.Map();
    return
end

identifiers = unique(arrayfun(@(s) s.identifier, matches));
map = containers.Map(identifiers, 1:length(identifiers));

fmt = nfmt;
for i = 1:length(identifiers)
    named = sprintf("(%s)", identifiers(i));
    positional = sprintf("%d$", i);
    fmt = replace(fmt, named, positional);
end

end


%==========================================================================
% Type dispatch
%==========================================================================
function inputargs = getargs_Map(map, m)
% map - map of identifiers to positions
% m   - user-provided containers.Map of input values

nargs = length(map);
fields = keys(map);
inputargs = cell(nargs, 1);
for iField = 1:nargs
    field = fields{iField};
    index = map(field);
    try
        inputargs{index} = m(field);
    catch err
        if strcmp(err.identifier, 'MATLAB:Containers:Map:NoKey')
            ME = MException('namedformat:BadInput', ...
                'Identifier "%s" not found in input map', field);
            throwAsCaller(ME);
        else
            rethrow(err);
        end
    end
end

end


function inputargs = getargs_struct(map, st)
% map - map of identifiers to positions
% st  - user-provided struct of input values

nargs = length(map);
fields = keys(map);
inputargs = cell(nargs, 1);
for iField = 1:nargs
    field = fields{iField};
    index = map(field);
    try
        inputargs{index} = st.(field);
    catch err
        if strcmp(err.identifier, 'MATLAB:nonExistentField')
            ME = MException('namedformat:BadInput', ...
                'Identifier "%s" not found in input struct', field);
            throwAsCaller(ME);
        else
            rethrow(err);
        end
    end
end

end
