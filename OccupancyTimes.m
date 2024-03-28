%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Occupancy times

% Rows where to find the states
PB_rows = 1:16;
SB_rows = 17:41;
FB_rows = 42:66;
PSB_rows = 67:91;
PFB_rows = 92:116;
NB_rows = 117:141;

adults_rows = 17: 66;
breeding_rows = 17:66;
non_breeding_rows = 67:141;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% MALES

% Shy
mean_prop_occ_shy_m = zeros(n_it,7);

for a=1:n_it
for p=personalities(1)
    
    % Draw an effect size
    alpha = zeros(1,3);
    alpha(1) = alpha_M.alpha_s(a);
    alpha(2) = alpha_M.alpha_b(a);
    alpha(3) = alpha_M.alpha_bs(a);
    
    % Draw the associated vital rates
    surv = zeros(50, 5);
    surv(:,1) = Rates_iterations_M.SB_s(a,1:50)'; % have to specify because its 54 in females and 50 in males
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
    outMAT_m = popmat(test_m);

    %create the fundamental matrix 
    U = outMAT_m.U;
    I = eye (tau);
    N = inv(I-U);
    
    % get the proportions of time in each state
    l_exp_adults = sum(N(:,adults_rows)); 
    
    occ_prop_SB = sum(N(SB_rows,adults_rows))./l_exp_adults; 
    occ_prop_FB = sum(N(FB_rows,adults_rows))./l_exp_adults; 
    occ_prop_PSB = sum(N(PSB_rows,adults_rows))./l_exp_adults; 
    occ_prop_PFB = sum(N(PFB_rows,adults_rows))./l_exp_adults; 
    occ_prop_NB = sum(N(NB_rows,adults_rows))./l_exp_adults; 
    occ_prop_Breed = sum(N(breeding_rows,adults_rows))./l_exp_adults; 
     occ_prop_NBreed = sum(N(non_breeding_rows,adults_rows))./l_exp_adults; 
    
    mean_prop_occ_shy_m(a,1) = mean(occ_prop_SB);
     mean_prop_occ_shy_m(a,2) = mean(occ_prop_FB);
     mean_prop_occ_shy_m(a,3) = mean(occ_prop_PSB);
     mean_prop_occ_shy_m(a,4) = mean(occ_prop_PFB);
     mean_prop_occ_shy_m(a,5) = mean(occ_prop_NB);
      mean_prop_occ_shy_m(a,6) = mean(occ_prop_Breed);
      mean_prop_occ_shy_m(a,7) = mean(occ_prop_NBreed);
    end
end

occ_m_shy = [
mean(mean_prop_occ_shy_m(:,1))
mean(mean_prop_occ_shy_m(:,2))
mean(mean_prop_occ_shy_m(:,3))
mean(mean_prop_occ_shy_m(:,4))
mean(mean_prop_occ_shy_m(:,5))
mean(mean_prop_occ_shy_m(:,6))
mean(mean_prop_occ_shy_m(:,7))
]';


% Bold
mean_prop_occ_bold_m = zeros(n_it,7);

for a=1:n_it
for p=personalities(2)
    
    % Draw an effect size
    alpha = zeros(1,3);
    alpha(1) = alpha_M.alpha_s(a);
    alpha(2) = alpha_M.alpha_b(a);
    alpha(3) = alpha_M.alpha_bs(a);
    
    % Draw the associated vital rates
    surv = zeros(50, 5);
    surv(:,1) = Rates_iterations_M.SB_s(a,1:50)'; % have to specify because its 54 in females and 50 in males
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
    outMAT_m = popmat(test_m);
 
    %create the fundamental matrix 
    U = outMAT_m.U;
    I = eye (tau);
    N = inv(I-U);
    
    % get the proportions of time in each state
       
    l_exp_adults = sum(N(:,adults_rows)); 
    
    occ_prop_SB = sum(N(SB_rows,adults_rows))./l_exp_adults; 
    occ_prop_FB = sum(N(FB_rows,adults_rows))./l_exp_adults; 
    occ_prop_PSB = sum(N(PSB_rows,adults_rows))./l_exp_adults; 
    occ_prop_PFB = sum(N(PFB_rows,adults_rows))./l_exp_adults; 
    occ_prop_NB = sum(N(NB_rows,adults_rows))./l_exp_adults; 
    occ_prop_Breed = sum(N(breeding_rows,adults_rows))./l_exp_adults; 
     occ_prop_NBreed = sum(N(non_breeding_rows,adults_rows))./l_exp_adults; 
    
    mean_prop_occ_bold_m(a,1) = mean(occ_prop_SB);
     mean_prop_occ_bold_m(a,2) = mean(occ_prop_FB);
     mean_prop_occ_bold_m(a,3) = mean(occ_prop_PSB);
     mean_prop_occ_bold_m(a,4) = mean(occ_prop_PFB);
     mean_prop_occ_bold_m(a,5) = mean(occ_prop_NB);
      mean_prop_occ_bold_m(a,6) = mean(occ_prop_Breed);
      mean_prop_occ_bold_m(a,7) = mean(occ_prop_NBreed);
    end
end

occ_m_bold = [
mean(mean_prop_occ_bold_m(:,1))
mean(mean_prop_occ_bold_m(:,2))
mean(mean_prop_occ_bold_m(:,3))
mean(mean_prop_occ_bold_m(:,4))
mean(mean_prop_occ_bold_m(:,5))
mean(mean_prop_occ_bold_m(:,6))
mean(mean_prop_occ_bold_m(:,7))
]';




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% FEMALES

% Extreme cases only
% Shy

mean_prop_occ_shy_f = zeros(n_it,7);

for a=1:n_it
for p=personalities(1)
    
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
    outMAT_f = popmat(test_f);

    %create the fundamental matrix 
    U = outMAT_f.U;
    I = eye (tau);
    N = inv(I-U);
    
    % get the proportions of time in each state
    
    l_exp_adults = sum(N(:,adults_rows)); 
    
    occ_prop_SB = sum(N(SB_rows,adults_rows))./l_exp_adults; 
    occ_prop_FB = sum(N(FB_rows,adults_rows))./l_exp_adults; 
    occ_prop_PSB = sum(N(PSB_rows,adults_rows))./l_exp_adults; 
    occ_prop_PFB = sum(N(PFB_rows,adults_rows))./l_exp_adults; 
    occ_prop_NB = sum(N(NB_rows,adults_rows))./l_exp_adults; 
    occ_prop_Breed = sum(N(breeding_rows,adults_rows))./l_exp_adults; 
     occ_prop_NBreed = sum(N(non_breeding_rows,adults_rows))./l_exp_adults; 
    
    mean_prop_occ_shy_f(a,1) = mean(occ_prop_SB);
     mean_prop_occ_shy_f(a,2) = mean(occ_prop_FB);
     mean_prop_occ_shy_f(a,3) = mean(occ_prop_PSB);
     mean_prop_occ_shy_f(a,4) = mean(occ_prop_PFB);
     mean_prop_occ_shy_f(a,5) = mean(occ_prop_NB);
      mean_prop_occ_shy_f(a,6) = mean(occ_prop_Breed);
      mean_prop_occ_shy_f(a,7) = mean(occ_prop_NBreed);
    end
end

occ_f_shy = [
mean(mean_prop_occ_shy_f(:,1))
mean(mean_prop_occ_shy_f(:,2))
mean(mean_prop_occ_shy_f(:,3))
mean(mean_prop_occ_shy_f(:,4))
mean(mean_prop_occ_shy_f(:,5))
mean(mean_prop_occ_shy_f(:,6))
mean(mean_prop_occ_shy_f(:,7))
]';


% Bold
mean_prop_occ_bold_f = zeros(n_it,7);

for a=1:n_it
for p=personalities(2)
    
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
    outMAT_f = popmat(test_f);
 
    %create the fundamental matrix 
    U = outMAT_f.U;
    I = eye (tau);
    N = inv(I-U);
    
    % get the proportions of time in each state
       
    l_exp_adults = sum(N(:,adults_rows)); 
    
    occ_prop_SB = sum(N(SB_rows,adults_rows))./l_exp_adults; 
    occ_prop_FB = sum(N(FB_rows,adults_rows))./l_exp_adults; 
    occ_prop_PSB = sum(N(PSB_rows,adults_rows))./l_exp_adults; 
    occ_prop_PFB = sum(N(PFB_rows,adults_rows))./l_exp_adults; 
    occ_prop_NB = sum(N(NB_rows,adults_rows))./l_exp_adults; 
    occ_prop_Breed = sum(N(breeding_rows,adults_rows))./l_exp_adults; 
     occ_prop_NBreed = sum(N(non_breeding_rows,adults_rows))./l_exp_adults; 
    
    mean_prop_occ_bold_f(a,1) = mean(occ_prop_SB);
     mean_prop_occ_bold_f(a,2) = mean(occ_prop_FB);
     mean_prop_occ_bold_f(a,3) = mean(occ_prop_PSB);
     mean_prop_occ_bold_f(a,4) = mean(occ_prop_PFB);
     mean_prop_occ_bold_f(a,5) = mean(occ_prop_NB);
      mean_prop_occ_bold_f(a,6) = mean(occ_prop_Breed);
      mean_prop_occ_bold_f(a,7) = mean(occ_prop_NBreed);
    end
end

occ_f_bold = [
mean(mean_prop_occ_bold_f(:,1))
mean(mean_prop_occ_bold_f(:,2))
mean(mean_prop_occ_bold_f(:,3))
mean(mean_prop_occ_bold_f(:,4))
mean(mean_prop_occ_bold_f(:,5))
mean(mean_prop_occ_bold_f(:,6))
mean(mean_prop_occ_bold_f(:,7))
]';


% Summary
occ_males = [occ_m_shy occ_m_bold]';
occ_females = [occ_f_shy occ_f_bold]';