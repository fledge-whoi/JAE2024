%% LEX, LRS and Lambda - with uncertainties

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



%% Females
% initiate
theta_f = zeros(n_p, n_sim, n_it); 
lambdas_f = zeros(n_sim, n_it);
LEX_f = zeros(n_sim,n_it); %lifetime expectancy
Occup_sb_f = zeros(n_sim, n_it); % Occupancy time in the Successful breeder states

for a=1:n_it
for p=1:n_sim
    
    % Draw an effect size
    alpha = zeros(1,3);
    alpha(1) = alpha_F.alpha_s(a);
    alpha(2) = alpha_F.alpha_b(a);
    alpha(3) = alpha_F.alpha_bs(a);
    
    % Draw the associated vital rates
    surv = zeros(54, 5);
    surv(:,1) = Rates_iterations_F.SB_s(a,1:54)'; % have to specify because its 54 in females and 50 in males
    surv(:,2) = Rates_iterations_F.FB_s(a,1:54)';
    surv(:,3) = Rates_iterations_F.PSB_s(a,1:54)';
    surv(:,4) = Rates_iterations_F.PFB_s(a,1:54)';
    surv(:,5) = Rates_iterations_F.NB_s(a,1:54)';
    
    breed = zeros(54, 5);
    breed(:,1) = Rates_iterations_F.SB_b(a,1:54)';
    breed(:,2) = Rates_iterations_F.FB_b(a,1:54)';
    breed(:,3) = Rates_iterations_F.PSB_b(a,1:54)';
    breed(:,4) = Rates_iterations_F.PFB_b(a,1:54)';
    breed(:,5) = Rates_iterations_F.NB_b(a,1:54)';
    
    success = zeros(54, 5);
    success(:,1) = Rates_iterations_F.SB_bs(a,1:54)';
    success(:,2) = Rates_iterations_F.FB_bs(a,1:54)';
    success(:,3) = Rates_iterations_F.PSB_bs(a,1:54)';
    success(:,4) = Rates_iterations_F.PFB_bs(a,1:54)';
    success(:,5) = Rates_iterations_F.NB_bs(a,1:54)';
    
    test_f = parameter_persoF_sto(PERSONALITY(p), alpha, surv, breed, success);
    theta_f(:,p,a) = test_f;
    outMAT_f = popmat(test_f);
    lambdas_f(p,a) = max(eig(outMAT_f.A));

    %create the fundamental matrix 
    U = outMAT_f.U;
    I = eye (tau);
    N = inv(I-U);
    LEX_f(p,a) = sum(N(:,1));
    Occup_sb_f(p,a) = sum(N(pb+1:pb+adult_classes,1)); %*0.5 if we want the total number of offspring, not only females
  
end
end
%%




%% Males
% initiate
theta_m = zeros(n_p, n_sim, n_it); 
lambdas_m = zeros(n_sim, n_it);
LEX_m = zeros(n_sim,n_it); %lifetime expectancy
Occup_sb_m = zeros(n_sim, n_it); % Occupancy time in the Successful breeder states

for a=1:n_it
for p=1:n_sim
    
    % Draw an effect size
    alpha = zeros(1,3);
    alpha(1) = alpha_M.alpha_s(a);
    alpha(2) = alpha_M.alpha_b(a);
    alpha(3) = alpha_M.alpha_bs(a);
    
    % Draw the associated vital rates
    surv = zeros(50, 5);
    surv(:,1) = Rates_iterations_M.SB_s(a,1:50)';
    surv(:,2) = Rates_iterations_M.FB_s(a,1:50)';
    surv(:,3) = Rates_iterations_M.PSB_s(a,1:50)';
    surv(:,4) = Rates_iterations_M.PFB_s(a,1:50)';
    surv(:,5) = Rates_iterations_M.NB_s(a,1:50)';
    
    breed = zeros(50, 5);
    breed(:,1) = Rates_iterations_M.SB_b(a,1:50)';
    breed(:,2) = Rates_iterations_M.FB_b(a,1:50)';
    breed(:,3) = Rates_iterations_M.PSB_b(a,1:50)';
    breed(:,4) = Rates_iterations_M.PFB_b(a,1:50)';
    breed(:,5) = Rates_iterations_M.NB_b(a,1:50)';
    
    success = zeros(50, 5);
    success(:,1) = Rates_iterations_M.SB_bs(a,1:50)';
    success(:,2) = Rates_iterations_M.FB_bs(a,1:50)';
    success(:,3) = Rates_iterations_M.PSB_bs(a,1:50)';
    success(:,4) = Rates_iterations_M.PFB_bs(a,1:50)';
    success(:,5) = Rates_iterations_M.NB_bs(a,1:50)';
    
    test_m = parameter_persoM_sto(PERSONALITY(p), alpha, surv, breed, success);
    theta_m(:,p,a) = test_m;
    outMAT_m = popmat(test_m);
    lambdas_m(p,a) = max(eig(outMAT_m.A));
    
    %create the fundamental matrix 
    U = outMAT_m.U;
    I = eye (tau);
    N = inv(I-U);
    LEX_m(p,a) = sum(N(:,1));
    Occup_sb_m(p,a) = sum(N(pb+1:pb+adult_classes,1)); %*0.5 if we want the total number of offspring, not only females

end
end
%%