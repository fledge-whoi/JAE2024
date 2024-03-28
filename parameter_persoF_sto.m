function [theta] = parameter_persoF_sto(personality, alpha, surv, breed, success)
% vector theta
theta = zeros(423, 1); 

% load parameters to get the juvenile estimates
parameters

%% Survival, S
% Pre-breeders - No effect of personality here
theta(1:16, 1) = F_juv_mean.mean_phi_Pre(1:16)'; % juvenile parameters stay the same
% Successful breeders
theta_S_SB = surv(7:31, 1)';
theta(17:41) = invlogit(logit(theta_S_SB) + alpha(1)*personality);
% Failed breeders
theta_S_FB = surv(7:31, 2)';
theta(42:66) = invlogit(logit(theta_S_FB) + alpha(1)*personality);
% Post-successful breeders
theta_S_PSB = surv(7:31, 3)';
theta(67:91) = invlogit(logit(theta_S_PSB) + alpha(1)*personality);
% Post-failed breeders
theta_S_PFB = surv(7:31, 4)';
theta(92:116) = invlogit(logit(theta_S_PFB) + alpha(1)*personality);
% Non-breeders
theta_S_NB = surv(7:31, 5)';
theta(117:141) = invlogit(logit(theta_S_NB) + alpha(1)*personality);

%% Breeding probability, B
% Pre-breeders - No effect of personality here
theta(142:157) = F_juv_mean.mean_rho_Pre(1:16)'; 
% Successful breeders 
theta_B_SB = breed(7:31,1)';
theta(158:182) = invlogit(logit(theta_B_SB) + alpha(2)*personality);
% Failed breeders 
theta_B_FB = breed(7:31, 2)';
theta(183:207) = invlogit(logit(theta_B_FB) + alpha(2)*personality);
% Post-successful breeders
theta_B_PSB = breed(7:31, 3)';
theta(208:232) = invlogit(logit(theta_B_PSB) + alpha(2)*personality);
% Post-failed breeders 
theta_B_PFB = breed(7:31, 4)';
theta(233:257) = invlogit(logit(theta_B_PFB) + alpha(2)*personality);
% Non-breeders 
theta_B_NB = breed(7:31, 5)';
theta(258:282) = invlogit(logit(theta_B_NB) + alpha(2)*personality);

%% Breeding success, BS
% Pre-breeders - No effect of personality here
theta(283:298) = F_juv_mean.mean_pi_Pre(1:16)';
% Successful breeders 
theta_BS_SB = success(7:31, 1)';
theta(299:323) = invlogit(logit(theta_BS_SB) + alpha(3)*personality);
% Failed breeders 
theta_BS_FB = success(7:31, 2)';
theta(324:348) = invlogit(logit(theta_BS_FB) + alpha(3)*personality);
% Post-successful breeders 
theta_BS_PSB =success(7:31, 3)';
theta(349:373) = invlogit(logit(theta_BS_PSB) + alpha(3)*personality);
% Post-failed breeders 
theta_BS_PFB = success(7:31, 4)';
theta(374:398) = invlogit(logit(theta_BS_PFB) + alpha(3)*personality);
% Non-breeders
theta_BS_NB = success(7:31, 5)';
theta(399:423) = invlogit(logit(theta_BS_NB) + alpha(3)*personality);


end

