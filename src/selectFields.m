function filtered = selectFields(s, fields)
%SELECTFIELDS  return a copy of a struct with only the specified fields.
%
%   F = selectFields(S, FIELDS) returns F, a copy of struct S with only the
%       fields FIELDS.
%
%   See also filterFields, dropFields
%

filtered = filterFields(@(f) any(strcmp(f, fields)), s);

end
