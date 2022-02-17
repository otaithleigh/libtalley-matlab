function slug = slugify(value)
%SLUGIFY  Make a string safe for use as a path or URI.
%
%   Overly conservative in order to have broad application. The steps are as
%   follows:
%
%   1. All characters that aren't letters, whitespace, underscores, or hyphens
%      are simply dropped.
%   2. Whitespace and underscores are replaced by hyphens.
%   3. Any consecutive hyphens are replaced by a single hyphen.
%

% Drop everything that isn't a letter, whitespace, underscore, or hyphen,
% and strip whitespace
slug = strip(regexprep(value, '[^\w\s_-]', ''));
% Replace consecutive spaces, underscores, and hyphens with a single hyphen
slug = regexprep(slug, '[\s_-]+', '-');

end
