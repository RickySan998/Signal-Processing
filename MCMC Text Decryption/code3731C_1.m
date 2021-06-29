% Results Reports
% Question 1a)
NumericArray = double('Mary is good at math.')
CharacterArray = char(NumericArray)
CharacterArray = char([80 114 111 98 108 101 109 32 105 115 32 115 111 108 118 101 100 46])

% Question 1b)
char2double('Mary is good at math.')



% Question 1c)
double2char([20 15 15 27 13 1 14 25 27 2 21 7 19])

% Question 2a)
frank_original_double = char2double(frank_original_txt);
frank_encrypted_double = frank_encrypt_key(frank_original_double);
frank_encrypted_txt = double2char(frank_encrypted_double)

test_double = char2double('Mary is good at math.');
test_encrypted_double = frank_encrypt_key(test_double);
test_encrypted = double2char(test_encrypted_double)

% Question 2b)
frank_encrypted_double = char2double(frank_encrypted_txt);
frank_decrypted_double = frank_decrypt_key(frank_encrypted_double);
frank_decrypted_txt = double2char(frank_decrypted_double)

test_double = char2double('gvwdukdnagdvaza');
test_decrypted_double = frank_decrypt_key(test_double);
test_decrypted = double2char(test_decrypted_double)

% Question 3a)
pr_trans = compute_transition_probability(training_txt);
res1 = pr_trans(1,1)
res2 = pr_trans(2,3)
fprintf('pr_trans(1,1) = %f and pr_trans(2,3) = %f',res1,res2)

M = max(max(pr_trans));
ind = find(pr_trans==M);
[rm,cm] = ind2sub(size(pr_trans),ind);

fprintf('Highest Probability is from letter %s to %s with transition probability of %f',double2char(rm),double2char(cm),M);

% Question 3b)
logn_pr = logn_pr_txt(frank_encrypted_txt, pr_trans)
logn_pr_2 = logn_pr_txt(frank_original_txt, pr_trans)
fprintf('Frank encrypted text logn probability is %f and frank decrypted text logn probability is %f\n',logn_pr,logn_pr_2);

% Question 3c)
frank_d = double2char(frank_decrypt_key(char2double(frank_encrypted_txt)));
p1 = logn_pr_txt(frank_d,pr_trans) % probability using frank decrypt key
frank_d_myst = double2char(mystery_decrypt_key(char2double(frank_encrypted_txt)));
p2 = logn_pr_txt(frank_d_myst,pr_trans) % probabilty using mystery decrypt key
fprintf('with frank key p is %f.\nwith mystery key p is %f.\n',p1,p2);


% Question 4ai)
[accept,p_accept] = metropolis(frank_decrypt_key,mystery_decrypt_key,pr_trans,frank_encrypted_txt);
fprintf('Accept = %d, with probability %f\n',accept,p_accept);

% Question 4aii)
frank_decrypt_key_swap = frank_decrypt_key;
frank_decrypt_key_swap(12) = frank_decrypt_key(13);
frank_decrypt_key_swap(13) = frank_decrypt_key(12);
[accept,p_accept] = metropolis(frank_decrypt_key,frank_decrypt_key_swap,pr_trans,frank_encrypted_txt);
fprintf('Accept = %d, with probability %e\n',accept,p_accept);

% Question 4b)

% Probability of decrypted text using the key developed from sampling via
% MCMC algorithm
[decrypted_txt,decrypt_key] = mcmc_decrypt_text(frank_encrypted_txt,pr_trans);
p_dt = logn_pr_txt(decrypted_txt,pr_trans);
decrypted_txt

diff = (decrypt_key~=frank_decrypt_key);
I = find(diff);
l1 = double2char(I(1));
l2 = double2char(I(2));
fprintf('The decryption error on the MCMC key is at letter %s and %s\n',l1,l2);

% Probability of decrypted text using the actual frank decrypt key
p_act = logn_pr_txt(frank_decrypted_txt,pr_trans);

fprintf('The decrypted text has a log probability of %e with the frank decrypt key\n',p_act);
fprintf('The decrypted text has a log probability of %e with the decrypt key from MCMC Algorithm\n',p_dt);

% Given we are currently at the correct key, what is the probability of
% accepting the wrong key
[accept,prob_accept] = metropolis(frank_decrypt_key,decrypt_key,pr_trans,frank_encrypted_txt);
fprintf('Given we are currently at the correct key, the probability of accepting the key from MCMC for frank is %e\n',prob_accept);

% Given we are at the correct key, the probability of accepting the next
% key if the next key is the key from the MCMC algorithm is not so small,
% hence the algorithm has a probability of switching from the correct key
% to the wrong key. Hence, we may end up with a wrong decryption.

% Question 4c)
[decrypted_txt,decrypt_key] = mcmc_decrypt_text(mystery_encrypted_txt,pr_trans);
p_dt = logn_pr_txt(decrypted_txt,pr_trans);
decrypted_txt

diff = (decrypt_key~=mystery_decrypt_key);
I = find(diff);
l1 = double2char(I(1));
l2 = double2char(I(2));
fprintf('The decryption error on the MCMC key is at letter %s and %s\n',l1,l2);

% Probability of decrypted text using the actual frank decrypt key
mystery_decrypted_txt = double2char(mystery_decrypt_key(char2double(mystery_encrypted_txt)));
p_act = logn_pr_txt(mystery_decrypted_txt,pr_trans);
fprintf('The decrypted text has a log probability of %e with the correct decryption key\n',p_act);
fprintf('The decrypted text has a log probability of %e with the decrypt key from MCMC Algorithm\n',p_dt);

% Given we are currently at the correct key, what is the probability of
% accepting the wrong key
[accept,prob_accept] = metropolis(mystery_decrypt_key,decrypt_key,pr_trans,mystery_encrypted_txt);
fprintf('Given we are currently at the correct key, the probability of accepting the key from MCMC for mystery is %e\n',prob_accept);

% Since given we are at the correct key, the probability of accepting a new
% key which is the decrypt key obtained from MCMC, is 1, this means that
% the MCMC algorithm will definitely switch erroneously from the correct
% key to the key detected above, thereby giving an error on the decryption.

[accept,prob_accept] = metropolis(decrypt_key,mystery_decrypt_key,pr_trans,mystery_encrypted_txt);
fprintf('Given we are currently at the wrong key, the probability of accepting the correct key for mystery is %e\n',prob_accept);

% Q5
pr_trans_2 = compute_transition_probability(new_training_txt);
[t1,k1] = mcmc_decrypt_text_modified(frank_encrypted_txt,pr_trans);
[t2,k2] = mcmc_decrypt_text_modified(mystery_encrypted_txt,pr_trans_2);