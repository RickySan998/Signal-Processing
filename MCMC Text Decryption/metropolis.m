function [accept_new_key, prob_accept] = metropolis(current_key, new_key, pr_trans, encrypted_txt)
    d1 = double2char(current_key(char2double(encrypted_txt)));
    d2 = double2char(new_key(char2double(encrypted_txt)));
    pcur = logn_pr_txt(d1,pr_trans);
    pnext = logn_pr_txt(d2,pr_trans);
    
    if pnext>=pcur
        accept_new_key = true;
        prob_accept = 1;
    else
        prob_accept = exp(pnext-pcur);
        accept_new_key = (rand(1)<prob_accept);        
    end    
end