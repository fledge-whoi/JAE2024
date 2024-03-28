%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Return time


% Rows where to find the states
PB_rows = 1:16; SB_rows = 17:41; FB_rows = 42:66; PSB_rows = 67:91; PFB_rows = 92:116; NB_rows = 117:141; TNB_rows = 67:141; B_rows = 17:66;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MALES (females at L approxé 950)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Successful breeder to successful breeder 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Failed breeder to Breeder & SB to B
B = B_rows;
personalities = [1 100];
returntimesSBB = zeros(n_it, length(B)/2, length(personalities));
returntimesFBB = zeros(n_it, length(B)/2, length(personalities));

returnprobSBB = zeros(n_it, length(B)/2, length(personalities));
returnprobFBB = zeros(n_it, length(B)/2, length(personalities));

for a=1:n_it
for perso=1:length(personalities)
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
    
    test_m = parameter_persoM_sto(PERSONALITY(personalities(perso)), alpha, surv, breed, success);
    outMAT_m = popmat(test_m);
  
    % Return time
    U = outMAT_m.U;
    
    % Useful information
    siz=size(U);
    s=siz(1);                   %size of U
    sa=length(B);               %number of states in the subset B
    st=s-sa;                    %number of states in the complement of B

    %useful vectors
    es=ones(1,s);
    esa=ones(1,sa);
    est=ones(1,st);

%permutation vector, used to rearrange the matrix U
p=(1:s);
for i=1:sa
    p(p==B(i))=[];
end
p=[p,B];
    
%Rearranging the indices of the transient states such that the last states are the states in B
        Utemp=U;
        for i=1:s
            Utemp(:,i)=U(:,p(i));
        end
        Utemp2=Utemp;
        for i=1:s
        Utemp2(i,:)=Utemp(p(i),:);
        end
        Uprime=Utemp2; %rearranged transition matrix

%Decomposing the transition matrix and computing useful matrices

        U_k=Uprime(1:st,1:st);  %transitions from B^c to B^c
        K=Uprime(st+1:end,1:st);%transitions from B^c to B
        L=Uprime(1:st,st+1:end);%transitions from B to B^c
        Q=Uprime(st+1:end,st+1:end);%transitions from B to B
        
        U_sub=Uprime(:,st+1:end); %transition probabilities from states in B to any states (except death)
        
        Nprime=inv(speye(s)-Uprime); %fundamental matrix of the original chain (rearranged)
        N=inv(speye(s)-U); %fundamental matrix of the original chain (non rearranged)
        
        N_k=inv(eye(st)-U_k); %fundamental matrix for of the killed MC

%Absorbtion probabilities, via the killed MC

        A_k=K*N_k;
        Atilde_k=[A_k,eye(sa)]; %extension of the absorbing probability matrix
        
         p_a=esa*A_k;     %probabilities of abosrbition by B = reaching B probabilities
         ptilde_a=esa*Atilde_k; %extension of p_a

%creating the conditonal Markov chain  
         D_a=diag(p_a);
            
        %transient matrix and mortality matrix
         invpa=p_a.^(-1);
         invpa(isinf(invpa)) = 0; %replace NaN by zero
         invDa=diag(invpa);
         U_c=D_a*U_k*invDa;
         c=(esa*K)/D_a;
         
         %fundamental matrix
         N_c=inv(speye(st)-U_c);

%creating the sub Markov chain 

        %transient matrix
        U_B=Atilde_k*U_sub;

        %fundamental matrix
        N_B=inv(speye(sa)-U_B);
        
%computing the measures

        %longevity
        nuMatrix=N;
        eta=sum(N);
        vareta=es*N*(2*N-eye(s))-eta.*eta;
        varMatrix=(2*diag(diag(N))-eye(s))*N-N.*N;
        
        %Occupancy time in B
            
        tau_B=sum(N_B);
        tau2_B=esa*N_B*(2*N_B-eye(sa));
        nuMatrix_Q=N_B;
        varMatrix_Q=(2*diag(diag(N_B))-eye(sa))*N_B-N_B.*N_B;
        
        tau=tau_B*Atilde_k;
        tau2=tau2_B*Atilde_k;
        vartau=tau2-tau.*tau;

        %Reaching the subset B

        t_B=est*N_c;        %mean time to reach
        t2_B=est*N_c*(2*N_c-eye(st));
        vart_B=t2_B-t_B.*t_B;   

        %Returning to the subset B

        p_r=esa*U_B;  %return probabilities 
        D_r=diag(p_r);
        
        W_Bc=(D_a*L)/D_r;   %conditional transition probabilities B to B^c given individual returns in B
        W_B=(Q)/D_r;   %conditional transition probabilities B to B given individual returns in B
        
        lambda=esa+t_B*W_Bc;    %mean time to return
        
        returntimesSBB(a,:,perso) = lambda(1:25); % these are the SB columns
        returntimesFBB(a,:,perso) = lambda(26:50); % these are the FB columns
        
        returnprobabilitiesSBB(a,:,perso) =  p_r(1:25);
        returnprobabilitiesFBB(a,:,perso) =  p_r(26:50);
end
end


% SB - B
return_timesSBB_shy = mean(returntimesSBB(:,:,1));
return_timesSBB_bold = mean(returntimesSBB(:,:,2));

return_probSBB_shy = mean(returnprobabilitiesSBB(:,:,1));
return_probSBB_bold = mean(returnprobabilitiesSBB(:,:,2));

% FB - B
return_timesFBB_shy = mean(returntimesFBB(:,:,1));
return_timesFBB_bold = mean(returntimesFBB(:,:,2));

return_probFBB_shy = mean(returnprobabilitiesFBB(:,:,1));
return_probFBB_bold = mean(returnprobabilitiesFBB(:,:,2));




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FEMALES

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Failed breeder to Breeder & SB to B
B = B_rows;
personalities = [1 100];
returntimesSBB_f = zeros(n_it, length(B)/2, length(personalities));
returntimesFBB_f = zeros(n_it, length(B)/2, length(personalities));

returnprobSBB_f = zeros(n_it, length(B)/2, length(personalities));
returnprobFBB_f = zeros(n_it, length(B)/2, length(personalities));

for a=1:n_it
for perso=1:length(personalities)
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
    
    test_f = parameter_persoF_sto(PERSONALITY(personalities(perso)), alpha, surv, breed, success);
    outMAT_f = popmat(test_f);
  
    % Return time
    U = outMAT_f.U;
    
    % Useful information
    siz=size(U);
    s=siz(1);                   %size of U
    sa=length(B);               %number of states in the subset B
    st=s-sa;                    %number of states in the complement of B

    %useful vectors
    es=ones(1,s);
    esa=ones(1,sa);
    est=ones(1,st);

%permutation vector, used to rearrange the matrix U
p=(1:s);
for i=1:sa
    p(p==B(i))=[];
end
p=[p,B];
    
%Rearranging the indices of the transient states such that the last states are the states in B
        Utemp=U;
        for i=1:s
            Utemp(:,i)=U(:,p(i));
        end
        Utemp2=Utemp;
        for i=1:s
        Utemp2(i,:)=Utemp(p(i),:);
        end
        Uprime=Utemp2; %rearranged transition matrix

%Decomposing the transition matrix and computing useful matrices

        U_k=Uprime(1:st,1:st);  %transitions from B^c to B^c
        K=Uprime(st+1:end,1:st);%transitions from B^c to B
        L=Uprime(1:st,st+1:end);%transitions from B to B^c
        Q=Uprime(st+1:end,st+1:end);%transitions from B to B
        
        U_sub=Uprime(:,st+1:end); %transition probabilities from states in B to any states (except death)
        
        Nprime=inv(speye(s)-Uprime); %fundamental matrix of the original chain (rearranged)
        N=inv(speye(s)-U); %fundamental matrix of the original chain (non rearranged)
        
        N_k=inv(eye(st)-U_k); %fundamental matrix for of the killed MC

%Absorbtion probabilities, via the killed MC

        A_k=K*N_k;
        Atilde_k=[A_k,eye(sa)]; %extension of the absorbing probability matrix
        
         p_a=esa*A_k;     %probabilities of abosrbition by B = reaching B probabilities
         ptilde_a=esa*Atilde_k; %extension of p_a

%creating the conditonal Markov chain  
         D_a=diag(p_a);
            
        %transient matrix and mortality matrix
         invpa=p_a.^(-1);
         invpa(isinf(invpa)) = 0; %replace NaN by zero
         invDa=diag(invpa);
         U_c=D_a*U_k*invDa;
         c=(esa*K)/D_a;
         
         %fundamental matrix
         N_c=inv(speye(st)-U_c);

%creating the sub Markov chain 

        %transient matrix
        U_B=Atilde_k*U_sub;

        %fundamental matrix
        N_B=inv(speye(sa)-U_B);
        
%computing the measures

        %longevity
        nuMatrix=N;
        eta=sum(N);
        vareta=es*N*(2*N-eye(s))-eta.*eta;
        varMatrix=(2*diag(diag(N))-eye(s))*N-N.*N;
        
        %Occupancy time in B
            
        tau_B=sum(N_B);
        tau2_B=esa*N_B*(2*N_B-eye(sa));
        nuMatrix_Q=N_B;
        varMatrix_Q=(2*diag(diag(N_B))-eye(sa))*N_B-N_B.*N_B;
        
        tau=tau_B*Atilde_k;
        tau2=tau2_B*Atilde_k;
        vartau=tau2-tau.*tau;

        %Reaching the subset B

        t_B=est*N_c;        %mean time to reach
        t2_B=est*N_c*(2*N_c-eye(st));
        vart_B=t2_B-t_B.*t_B;   

        %Returning to the subset B

        p_r=esa*U_B;  %return probabilities 
        D_r=diag(p_r);
        
        W_Bc=(D_a*L)/D_r;   %conditional transition probabilities B to B^c given individual returns in B
        W_B=(Q)/D_r;   %conditional transition probabilities B to B given individual returns in B
        
        lambda=esa+t_B*W_Bc;    %mean time to return
        
        returntimesSBB_f(a,:,perso) = lambda(1:25); % these are the SB columns
        returntimesFBB_f(a,:,perso) = lambda(26:50); % these are the FB columns
        
        returnprobabilitiesSBB_f(a,:,perso) =  p_r(1:25);
        returnprobabilitiesFBB_f(a,:,perso) =  p_r(26:50);
end
end










