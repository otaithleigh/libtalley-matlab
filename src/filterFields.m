function filtered = filterFields(func, s)
%FILTERFIELDS  Select fields from a struct based on a filter function.
%
%   F = filterFields(FILTER, S) applies the function FILTER to the fieldnames of
%       struct S. FILTER should take a single field name as an argument and
%       return true or false. The fields that return true when passed through
%       FILTER are added to the return struct F.
%
%   See also dropFields, selectFields
%

fields = fieldnames(s);
whichfields = cellfun(func, fields);
nfields = sum(whichfields);

s_cell = struct2cell(s);
s_cell_size = size(s_cell);
s_cell_which = repmat(whichfields, [1, s_cell_size(2:end)]);
s_cell_picked = reshape(s_cell(s_cell_which), [nfields, size(s)]);

filtered = cell2struct(s_cell_picked, fields(whichfields));

end
