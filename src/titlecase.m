function s2 = titlecase(s1)
%TITLECASE  transform strings to title case, where the first letter of each word
%   is capitalized and the rest are lowercase
%
    arguments
        s1 string
    end

    s2 = arrayfun(@titlecase_single_string, s1);    
end

function s2 = titlecase_single_string(s1)
    arguments
        s1 (1,1) string
    end
    words = strsplit(s1);
    s2 = strjoin(arrayfun(@titlecase_single_word, words));
end

function Word = titlecase_single_word(word)
    arguments
        word (1,1) string
    end
    word = char(word);
    Word = string([upper(word(1)) lower(word(2:end))]);
end
