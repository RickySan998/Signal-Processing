function pr_trans = compute_transition_probability(input_txt)
    pr_trans = zeros(27);
    count_alp = zeros([1 27]);
    for i = 1:(length(input_txt)-1)
        cur_ind = char2double(input_txt(i));
        next_ind = char2double(input_txt(i+1));
        count_alp(cur_ind) = count_alp(cur_ind) + 1;
        pr_trans(cur_ind,next_ind) = pr_trans(cur_ind,next_ind) + 1;
    end
    for i = 1:27
        pr_trans(i,:) = (pr_trans(i,:) + 1)/(27+count_alp(i));
    end
%     assignin('base','pr_trans',pr_trans);
%     assignin('base','cur_ind',cur_ind);
%     assignin('base','next_ind',next_ind);
%     assignin('base','count_alp',count_alp);
end

% Results: pr_trans(1,1) is 0.000098019996079
%          pr_trans(2,3) is 0.000495049504950

% Please write this function based on the following specifications.
%
% compute_transition_probability.m takes an input text and
% computes a matrix of transition probability.
%
% Input:
%	input_txt = 1 x N character array
%
% Output:
%    pr_trans = 27 x 27 matrix, where pr_trans(i, j)  = probability j-th letter in the alphabet occurs immediately after i-th letter in the alphabet
%                               e.g., pr_trans(1, 2)  = probability character b occurring immediately after character a
%                               e.g., pr_trans(1, 27) = probability character ' ' occurring immediately after character a
%
% pr_trans(i, j) is defined to be equal to
% (1 + #times j-th letter of alphabet appears after i-th letter of alphabet in input_txt) divided by
% (27 + #times i-th letter of alphabet appears in the text except at the last position in the text)
%
% For example, if the input_txt is 'aaabababa', then
%	# times 'a' appears not corresponding to last position is 5;
%   # times 'a' appears after 'a' is 2; # times 'b' appears after 'a' is 3.
%
%   Therefore pr_trans(1, 1) = (1 + 2)/(5 + 27) = 0.09375
%			  pr_trans(1, 2) = (1 + 3)/(5 + 27) = 0.125
%			  pr_trans(1, 3) = ... = pr_trans(1, 27) = 1/(5 + 27) = 0.03125...
%
%	Observe that sum(pr_trans(1, :)) is equal to 1