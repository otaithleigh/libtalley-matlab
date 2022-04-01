function writestring(s, filename, options)
%WRITESTRING  Write a string (vector) to a file on disk.
%
%   WRITESTRING(s, FILENAME) writes the string S to the file FILENAME. The file
%       is created if it does not already exist, and is overwritten if it does.
%       If S is a vector, elements are joined by newlines before writing.
%
%   WRITESTRING(..., 'Delimiter', DELIMITER) writes the string S to the
%       file FILENAME, joining elements of S with DELIMITER before writing.
%       (default: "\n")
%
%   WRITESTRING(..., 'ForceFinalNewline', FORCE) controls whether the joined
%       string is forced to have a final "\n" character or not. (default: true)
%
%   WRITESTRING(..., 'Mode', MODE) selects between append ('a') and overwrite
%       ('w') mode for writing to the file. (default: 'w')
%
arguments
    s (:,1) string
    filename (1,1) string
    options.Delimiter string = "\n"
    options.ForceFinalNewline (1,1) logical = true
    options.Mode (1,1) string {mustBeMember(options.Mode, ["a", "w"])} = "w"
end

stringToWrite = join(s, options.Delimiter);
if options.ForceFinalNewline && ~endsWith(stringToWrite, newline)
    stringToWrite = append(stringToWrite, newline);
end

fid = fopen(filename, options.Mode);
if fid == -1
    error('Could not open %s for writing', filename)
end

try
    fprintf(fid, '%s', stringToWrite);
catch err
    fclose(fid);
    rethrow(err);
end
fclose(fid);

end
