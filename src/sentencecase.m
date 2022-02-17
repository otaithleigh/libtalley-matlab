function s2 = sentencecase(s1)
%SENTENCECASE  transform strings to sentence case, where the first letter is
%   capitalized and the rest are lowercase
%
    arguments
        s1 string
    end
    s2 = arrayfun(@sentencecase_single, s1);
end

function s2 = sentencecase_single(s1)
    % Convert to char for slicing
    s = char(s1);

    % Uppercase first letter
    first = upper(s(1));

    % Lower case rest
    rest = lower(s(2:end));

    % Combine & return
    s2 = string([first rest]);
end
