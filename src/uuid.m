function id = uuid()
%UUID  Get a unique identifier.

% `tempname` generates a unique temporary filename using UUID if
% available and tries to get something as good as UUID if not.
% `fileparts` returns the folders, filename, and extension of a path.
% Don't care about about folders or extension though, just the filename.
[~, id, ~] = fileparts(tempname());

end
