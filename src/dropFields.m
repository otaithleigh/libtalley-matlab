function filtered = dropFields(s, fields)
%DROPFIELDS  return a copy of a struct without specified fields.
%
%   F = dropFields(S, FIELDS) returns F, a copy of struct S without the fields
%       FIELDS.
%
%   See also filterFields, selectFields
%

filtered = filterFields(@(f) ~any(strcmp(f, fields)), s);

end
