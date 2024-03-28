function [theta] = parameter_personalityF(personality, alpha)
% vector theta
theta = zeros(423, 1); 

% load parameters
parameters

%% Survival, S
% Pre-breeders - No effect of personality here
theta(1:16, 1) = F_juv_mean.mean_phi_Pre(1:16)';
% Successful breeders
theta_S_SB = Fs_mean.mean_Fphi_SB(7:31)';
theta(17:41) = invlogit(logit(theta_S_SB) + alpha(1)*personality);
% Failed breeders
theta_S_FB = Fs_mean.mean_Fphi_FB(7:31)';
theta(42:66) = invlogit(logit(theta_S_FB) + alpha(1)*personality);
% Post-successful breeders
theta_S_PSB = Fs_mean.mean_Fphi_PSB(7:31)';
theta(67:91) = invlogit(logit(theta_S_PSB) + alpha(1)*personality);
% Post-failed breeders
theta_S_PFB = Fs_mean.mean_Fphi_PFB(7:31)';
theta(92:116) = invlogit(logit(theta_S_PFB) + alpha(1)*personality);
% Non-breeders
theta_S_NB = Fs_mean.mean_Fphi_NB(7:31)';
theta(117:141) = invlogit(logit(theta_S_NB) + alpha(1)*personality);

%% Breeding probability, B
% Pre-breeders - No effect of personality here
theta(142:157) = F_juv_mean.mean_rho_Pre(1:16)'; 
% Successful breeders 
theta_B_SB = Fb_mean.mean_Frho_SB(7:31)';
theta(158:182) = invlogit(logit(theta_B_SB) + alpha(2)*personality);
% Failed breeders 
theta_B_FB = Fb_mean.mean_Frho_FB(7:31)';
theta(183:207) = invlogit(logit(theta_B_FB) + alpha(2)*personality);
% Post-successful breeders
theta_B_PSB = Fb_mean.mean_Frho_PSB(7:31)';
theta(208:232) = invlogit(logit(theta_B_PSB) + alpha(2)*personality);
% Post-failed breeders 
theta_B_PFB = Fb_mean.mean_Frho_PFB(7:31)';
theta(233:257) = invlogit(logit(theta_B_PFB) + alpha(2)*personality);
% Non-breeders 
theta_B_NB = Fb_mean.mean_Frho_NB(7:31)';
theta(258:282) = invlogit(logit(theta_B_NB) + alpha(2)*personality);

%% Breeding success, BS
% Pre-breeders - No effect of personality here
theta(283:298) = F_juv_mean.mean_pi_Pre(1:16)';
% Successful breeders 
theta_BS_SB = Fbs_mean.mean_Fpi_SB(7:31)';
theta(299:323) = invlogit(logit(theta_BS_SB) + alpha(3)*personality);
% Failed breeders 
theta_BS_FB = Fbs_mean.mean_Fpi_FB(7:31)';
theta(324:348) = invlogit(logit(theta_BS_FB) + alpha(3)*personality);
% Post-successful breeders 
theta_BS_PSB = Fbs_mean.mean_Fpi_PSB(7:31)';
theta(349:373) = invlogit(logit(theta_BS_PSB) + alpha(3)*personality);
% Post-failed breeders 
theta_BS_PFB = Fbs_mean.mean_Fpi_PFB(7:31)';
theta(374:398) = invlogit(logit(theta_BS_PFB) + alpha(3)*personality);
% Non-breeders
theta_BS_NB = Fbs_mean.mean_Fpi_NB(7:31)';
theta(399:423) = invlogit(logit(theta_BS_NB) + alpha(3)*personality);


end

