% Get theta (parameters), u and f matrices and lambda for each personality trait simulated
theta_f = zeros(n_p, n_sim); 
a_female = zeros(tau, tau, n_sim);
u_female = zeros(tau,tau,n_sim); %transition matrix
f_female = zeros(tau,tau,n_sim); %fertility matrix, stage specific
lambdas_f = zeros(n_sim, 1)';

theta_m = zeros(n_p, n_sim); 
a_male = zeros(tau, tau, n_sim);
u_male = zeros(tau,tau,n_sim); %transition matrix
f_male = zeros(tau,tau,n_sim); %fertility matrix, stage specific
lambdas_m = zeros(n_sim, 1)';

for i=1:n_sim
    test_f = parameter_persoF(PERSONALITY(i), ALPHA(:,1));
    test_f(isnan(test_f))=0;
    theta_f(:,i) = test_f;
    outMAT_f = popmat(test_f);
    lambdas_f(i) = max(eig(outMAT_f.A));
    a_female(:,:,i) = outMAT_f.A;
    u_female(:,:,i) = outMAT_f.U;
    f_female(:,:,i) = outMAT_f.F;

    test_m = parameter_persoM(PERSONALITY(i), ALPHA(:,2));
    test_m(isnan(test_m))=0;
    theta_m(:,i) = test_m;
    outMAT_m = popmat(test_m);
    lambdas_m(i) = max(eig(outMAT_m.A));
    a_male(:,:,i) = outMAT_m.A;
    u_male(:,:,i) = outMAT_m.U;
    f_male(:,:,i) = outMAT_m.F;
end
