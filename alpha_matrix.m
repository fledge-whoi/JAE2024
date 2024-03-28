% This matrix contains the alpha values (effect of personality on each demographic rate for each sex)

ALPHA = zeros(3,2); % 3 demographic rates (survival, breeding probability and breeding success) and 2 sexes (females, males)
ALPHA(:,1) = [Fs_mean.alpha_Fphi_ad Fb_mean.alpha_Frho_ad Fbs_mean.alpha_Fpi_ad]; % Females
ALPHA(:,2) = [Ms_mean.alpha_Mphi_ad Mb_mean.alpha_Mrho_ad Mbs_mean.alpha_Mpi_ad]; % Males


% For the uncertainty
% Read the alpha matrix, which contains the alpha values for each vital rate for each iteration (2400). This matrix was created in R
alpha_F = load("alpha_iteration_F.mat");
alpha_F = alpha_F.x;

alpha_M = load("alpha_iteration_M.mat");
alpha_M = alpha_M.x;

% Read the iteration matrices - contain 1000 iterations from the posterior distribution of intercepts for the three vital rates over the 54 ages
Rates_iterations_F = load("Rates_iterations_F.mat");
Rates_iterations_F = Rates_iterations_F.x;

Rates_iterations_M = load("Rates_iterations_M.mat");
Rates_iterations_M = Rates_iterations_M.x;
