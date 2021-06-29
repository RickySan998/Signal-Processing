function double_array = char2double(char_array)
    new = upper(char_array);
    sz = size(char_array);
    res = zeros(sz);
    for i = 1:sz(1,2)
        if(((double(new(i))) <= double('Z')) && (double(new(i)) >= double('A')))
            res(i) = new(i)-'A'+1;
        else
            res(i) = 27;
        end     
    end
    double_array = res;
end

% Please write this function based on the following specifications.
%
% This function char2double.m converts a character array into a double array. More specifically,
%
% Character 'a' or 'A' should be mapped to 1
% Character 'b' or 'B' should be mapped to 2
% ...
% Character 'z' or 'Z' should be mapped to 26
%
% All other characters and punctuations should be mapped to 27.
%
% Example:
% 	double_array = char2double('abc') gives [1 2 3]
% 	double_array = char2double('ABC') gives [1 2 3]
%   double_array = char2double('A YZ') gives [1 27 25 26]
%
% Input:
%   char_array = 1 x N character array
%
% Output:
%   double_array = 1 x N double array