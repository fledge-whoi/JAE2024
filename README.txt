README

Data and code to conduct the demographic analyses in the manuscript The impact of boldness on demographic rates and life-history outcomes in the wandering albatross, published in Journal of Animal Ecology by J. Van de Walle, R. Sun, R. Fay, S. C. Patrick, C. Barbraud, K. Delord, H. Weimerskirch, and S. Jenouvrier

Description of the files:

##########################
Datasets:
WA_5Fb_a_mean_2008_SCALE.mat: MECMR outpout containing posterior distributions of the demographic parameters for females; with a boldness as a covariate on breeding probability. 
WA_5Fbs_a_mean_2008_SCALE.mat: MECMR outpout containing posterior distributions of the demographic parameters for females; with a boldness as a covariate on breeding success.
WA_5Fs_a_mean_2008_SCALE.mat: MECMR outpout containing posterior distributions of the demographic parameters for females; with a boldness as a covariate on survival.
WA_5Mb_a_mean_2008_SCALE.mat: MECMR outpout containing posterior distributions of the demographic parameters for males; with a boldness as a covariate on breeding probability. 
WA_5Mbs_a_mean_2008_SCALE.mat: MECMR outpout containing posterior distributions of the demographic parameters for males; with a boldness as a covariate on breeding success.
WA_5Ms_a_mean_2008_SCALE.mat: MECMR outpout containing posterior distributions of the demographic parameters for males; with a boldness as a covariate on survival.
F_juv_mean_cohortremoved.mat: MECMR outpout containing posterior distributions of the demographic parameters for juvenile females.
M_juv_mean_cohortremoved.mat: MECMR outpout containing posterior distributions of the demographic parameters for juvenile males.

alpha_iteration_F.mat: Random draws in the posterior distribution of the impact of boldness on female demographic rates. This is used to generate the confidence intervals around the estimates in the figures. 
alpha_iteration_M.mat: Random draws in the posterior distribution of the impact of boldness on male demographic rates. This is used to generate the confidence intervals around the estimates in the figures. 
Rates_iterations_F.mat: Random draws in the posterior distribution of the demographic rates for females. This is used to generate the confidence intervals around the estimates in the figures. 
Rates_iterations_M.mat: Random draws in the posterior distribution of the demographic rates for males. This is used to generate the confidence intervals around the estimates in the figures. 


##########################
Code:
Main.mlx: Main code - workflow is presented.
Info_init.m: Code to describe the basic information needed to run the models.
parameters.m: Code to load demographic parameters.
alpha_matrix.m: Code to gather the alpha and demographic rates random draws.
figure_lambda_perso.m: Code to produce basic differences in population growth rate across boldness scores.
LHO.m: Code to calculate the life-history outcomes and population growth rate across boldness scores for males and females.
ReturnTimes.m: Code to calculate time to return to a breeding state for bold vs shy individuals of both sexes.
OccupancyTimes.m: Code to calculate occupancy times
invlogit.m: Function to calculate the invert logit of a value.
logit.m: Function to calculate the logit of a value.
parameter_persoF.m: Code to generate the boldness-specific demographic rates for females.
parameter_persoF_sto.m: Code to generate the boldness-specific demographic rates for females including uncertainties.
parameter_persoM.m: Code to generate the boldness-specific demographic rates for males.
parameter_persoM_sto.m: Code to generate the boldness-specific demographic rates for males including uncertainties.
popmat.m: Code to generate the boldness-specific population matrices.
pop_analysis_perso.m: Code to analyse the boldness-specific population matrices.



##########################
Figures:
LHO_Figures.R: Script to produce the life-history outcome figures.
OccupancyTimes.R: Script to produce the occupancy times figures.
ReturnTimes.R: Script to produce the return times figures.

Expectancy_pers_uncertaintiesF_2008_SCALE.txt: Matlab output to produce the life expectancy figure for females.
Expectancy_pers_uncertaintiesM_2008_SCALE.txt: Matlab output to produce the life expectancy figure for males.
Lambda_pers_uncertaintiesF_2008_SCALE.txt: Matlab output to produce the lambda figure for females.
Lambda_pers_uncertaintiesM_2008_SCALE.txt: Matlab output to produce the lambda figure for males.
OccupancySB_pers_uncertaintiesF_2008_SCALE.txt: Matlab output to produce the lifetime reproductive success figure for females.
OccupancySB_pers_uncertaintiesM_2008_SCALE.txt: Matlab output to produce the lifetime reproductive success figure for males.

ReturnTimes.R
returntimesFBB.mat: Matlab output to produce the return times (FB to B) figure for males.
returntimesFBB_f.mat: Matlab output to produce the return times (FB to B) figure for females.
returntimesSBB_f.mat: Matlab output to produce the return times (SB to B) figure for females.
returntimesSBSB.mat: Matlab output to produce the return times (SB to B) figure for males.

OccupancyF.txt: Matlab output to produce the occupancy times figure for females.
OccupancyM.txt: Matlab output to produce the occupancy times figure for males.
