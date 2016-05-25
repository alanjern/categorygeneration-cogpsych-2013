function [S_0_samples M_0_samples] = hierarchical_sampling(n_trials, sampler_burnin, condition, fullrange)
% Hierarchical sampling model
%
% n_trials: number of sampling iterations
% sampler_burnin: number of burn-in sample iterations to discard
% condition: r+ (1), r- (2), or r0 (3)
% fullrange: 0 if crystals only generated from half of length dimension (Expt 4)
%            1 if crystals generated from full space (Expt 3)
%
% Returns
% S_0_samples: A vector of covariance matrix posterior samples
% M_0_samples: A vector of mean posterior samples


% ===== Variables =====
% X -- matrix of observed crystal values
%       X(:,:,i) represents the ith set of crystals where each row
%                is a single crystal and each column is a dimension
% M -- matrix of means
%       M(:,i) represents the vector of means for the ith set of crystals
% S -- matrix of covariance matrices
%       S(:,:,i) represents the covariance matrix for the ith set of
%                crystals
% M_0 -- Mean mean values
%        M(j) represents the mean mean value for dimension j
% S_0 -- Mean (template) covariance matrix

% Task variables
n_sets = 2;         % number of crystal sets
n_dim = 3;          % number of dimensions per crystal

X_o = zeros(4,3,2);

if (fullrange == 1)
    switch condition
        % Condition 1 -- aligned
        case 1,
            X_o(:,:,1) = [0.15, 0.15, 0.05; ...
                          0.15, 0.35, 0.31; ...
                          0.15, 0.55, 0.57; ...
            		      0.15, 0.75, 0.83];
            X_o(:,:,2) = [0.60, 0.05, 0.15; ...
            		      0.60, 0.25, 0.41; ...
            		      0.60, 0.45, 0.67; ...
            		      0.60, 0.65, 0.93];
            % Hard-coded covariance matrices using the
            % empirical values observed from the data plus some smoothing to
            % produce positive-definite matrices. This reduces correlations 
            % slightly below 1 and increases SDs slightly above 0.
            %
            % Note that these values are for the transformed data
            S_l(:,:,1) = [.01 0 0; 0 1.2057 0; 0 0 1.9168];
            R_l(:,:,1) = [1 0 0; 0 1 .9961; 0 .9961 1];
            S_l(:,:,2) = [.01 0 0; 0 1.5292 0; 0 0 1.8236];
            R_l(:,:,2) = [1 0 0; 0 1 .9623; 0 .9623 1];
            
        % Condition 2 -- anti-aligned
        case 2,
            X_o(:,:,1) = [0.15, 0.15, 0.93; ...
                          0.15, 0.35, 0.67; ...
                          0.15, 0.55, 0.41; ...
            		      0.15, 0.75, 0.15];
            X_o(:,:,2) = [0.60, 0.05, 0.83; ...
            		      0.60, 0.25, 0.57; ...
            		      0.60, 0.45, 0.31; ...
            		      0.60, 0.65, 0.05];
            S_l(:,:,1) = [.01 0 0; 0 1.2057 0; 0 0 1.8263];
            R_l(:,:,1) = [1 0 0; 0 1 -.9989; 0 -.9989 1];
            S_l(:,:,2) = [.01 0 0; 0 1.5292 0; 0 0 1.9168];
            R_l(:,:,2) = [1 0 0; 0 1 -.9486; 0 -.9486 1];
            
        % Condition 3 -- uncorrelated
        case 3,
            X_o(:,:,1) = [0.15, 0.43, 0.53; ...
                          0.15, 0.57, 0.96; ...
                          0.15, 0.22, 0.13; ...
            		      0.15, 0.77, 0.35];
            X_o(:,:,2) = [0.60, 0.43, 0.53; ...
            		      0.60, 0.57, 0.09; ...
            		      0.60, 0.22, 0.70; ...
            		      0.60, 0.77, 0.92];
            S_l(:,:,1) = [.01 0 0; 0 1.0360 0; 0 0 2.1572];
            R_l(:,:,1) = [1 0 0; 0 1 .3775; 0 .3775 1];
            S_l(:,:,2) = [.01 0 0; 0 1.0360 0; 0 0 1.9791];
            R_l(:,:,2) = [1 0 0; 0 1 0.1965; 0 0.1965 1];
    end
else
    switch condition
        % Condition 1 -- aligned
        case 1,
            X_o(:,:,1) = [0.15, 0.10, 0.05; ...
                          0.15, 0.20, 0.31; ...
                          0.15, 0.30, 0.57; ...
            		      0.15, 0.40, 0.83];
            X_o(:,:,2) = [0.60, 0.05, 0.15; ...
            		      0.60, 0.15, 0.41; ...
            		      0.60, 0.25, 0.67; ...
            		      0.60, 0.35, 0.93];
            S_l(:,:,1) = [.01 0 0; 0 .7713 0; 0 0 1.9168];
            R_l(:,:,1) = [1 0 0; 0 1 .9983; 0 .9983 1];
            S_l(:,:,2) = [.01 0 0; 0 1.0065 0; 0 0 1.8236];
            R_l(:,:,2) = [1 0 0; 0 1 .9575; 0 .9575 1];
        % Condition 2 -- anti-aligned
        case 2,
            X_o(:,:,1) = [0.15, 0.10, 0.93; ...
                          0.15, 0.20, 0.67; ...
                          0.15, 0.30, 0.41; ...
            		      0.15, 0.40, 0.15];
            X_o(:,:,2) = [0.60, 0.05, 0.83; ...
            		      0.60, 0.15, 0.57; ...
            		      0.60, 0.25, 0.31; ...
            		      0.60, 0.35, 0.05];
            S_l(:,:,1) = [.01 0 0; 0 .7713 0; 0 0 1.8236];
            R_l(:,:,1) = [1 0 0; 0 1 -.9971; 0 -.9971 1];
            S_l(:,:,2) = [.01 0 0; 0 1.0065 0; 0 0 1.9168];
            R_l(:,:,2) = [1 0 0; 0 1 -.9429; 0 -.9429 1];
        % Condition 3 -- uncorrelated
        case 3,
            X_o(:,:,1) = [0.15, 0.24, 0.53; ...
                          0.15, 0.31, 0.96; ...
                          0.15, 0.14, 0.13; ...
            		      0.15, 0.41, 0.35];
            X_o(:,:,2) = [0.60, 0.24, 0.53; ...
            		      0.60, 0.31, 0.09; ...
            		      0.60, 0.14, 0.70; ...
            		      0.60, 0.41, 0.92];
            S_l(:,:,1) = [.01 0 0; 0 .6132 0; 0 0 2.1572];
            R_l(:,:,1) = [1 0 0; 0 1 .4532; 0 .4532 1];
            S_l(:,:,2) = [.01 0 0; 0 .6132 0; 0 0 1.9791];
            R_l(:,:,2) = [1 0 0; 0 1 .1148; 0 .1148 1];
    end
end
        
% We assume that the observed data has been transformed by a logistic
% function. Therefore, the input to the actual model is the non-trans-
% formed data -- produced by applying the logit function to X_o
X = log(X_o) - log(1-X_o);


for i=1:n_sets
    S_prev(:,:,i) = S_l(:,:,i)*R_l(:,:,i)*S_l(:,:,i);
end


% Fixed parameter values
s_M = 0.5;
s_S = 0.05;


% Generate some initial parameter values
for i=1:n_sets
    M_prev(:,i) = mean(X(:,:,i))';
end
for j=1:n_dim
    for i=1:n_sets
        s_prev(j,i) = 0.1;
    end
end
% This creates an upper-triangular matrix in which the
% only correlations represented are 1-2, 1-3, and 2-3
for i=1:n_sets
    r_prev(:,:,i) = eye(n_dim,n_dim);
end



S1 = S_l(:,:,1) * R_l(:,:,1) * S_l(:,:,1);
S2 = S_l(:,:,2) * R_l(:,:,2) * S_l(:,:,2);
S_0_prev = (S1 + S2) / 2; % Starting point is mean of training covariance matrices
M_0_prev = mean([mean(X(:,:,1)); mean(X(:,:,2))])';


% Sample variables
proposal_variance = 0.01;
S_0_samples = zeros([size(S_0_prev) n_trials-sampler_burnin]);
M_0_samples = zeros([size(M_0_prev) n_trials-sampler_burnin]);

n_s1_small_samples = 0;
n_s1_small_ok_samples = 0;
n_s1_big_samples = 0; 
n_s1_big_ok_samples = 0;

n_s_samples = 0;
n_ok_s_samples = 0;

for t=1:n_trials
    if (mod(t,100) == 0)
        fprintf('Iteration %d\n',t);
    end
    
    % Draw proposals for the parameters of S_0
    % Keep sampling until a positive definite matrix is produced
    ok = 0;
    while (ok == 0)
        S_0_curr = S_0_prev;
        for j=1:n_dim
            for k=j:n_dim
                S_0_curr(j,k) = normrnd(S_0_prev(j,k), proposal_variance);
                S_0_curr(k,j) = S_0_curr(j,k);
            end
        end
        
        n_s_samples = n_s_samples + 1;
        
        [tt pd] = cholcov(S_0_curr,0);
        if (pd == 0)
            ok = 1;
            n_ok_s_samples = n_ok_s_samples + 1;
        end
                        
    end

            % Compute probabilities
            p_curr = 1;
            for i=1:n_sets
                p_curr = p_curr * prod(mvnpdf(X(:,:,i), M_prev(:,i)', S_prev(:,:,i))) * ...
                                    prod(normpdf(M_prev(:,i)', M_0_prev', s_M));
                p_curr = p_curr * normpdf(S_prev(1,1,i), S_0_curr(1,1), s_S) * ...
                                    normpdf(S_prev(1,2,i), S_0_curr(1,2), s_S) * ...
                                    normpdf(S_prev(1,3,i), S_0_curr(1,3), s_S) * ...
                                    normpdf(S_prev(2,2,i), S_0_curr(2,2), s_S) * ...
                                    normpdf(S_prev(2,3,i), S_0_curr(2,3), s_S) * ...
                                    normpdf(S_prev(3,3,i), S_0_curr(3,3), s_S);
            end
            

            p_prev = 1;
            for i=1:n_sets
                p_prev = p_prev * prod(mvnpdf(X(:,:,i), M_prev(:,i)', S_prev(:,:,i))) * ...
                                    prod(normpdf(M_prev(:,i)', M_0_prev', s_M));
                p_prev = p_prev * normpdf(S_prev(1,1,i), S_0_prev(1,1), s_S) * ...
                                    normpdf(S_prev(1,2,i), S_0_prev(1,2), s_S) * ...
                                    normpdf(S_prev(1,3,i), S_0_prev(1,3), s_S) * ...
                                    normpdf(S_prev(2,2,i), S_0_prev(2,2), s_S) * ...
                                    normpdf(S_prev(2,3,i), S_0_prev(2,3), s_S) * ...
                                    normpdf(S_prev(3,3,i), S_0_prev(3,3), s_S);                        
            end

            LR = p_curr / p_prev;
            if (isnan(LR))
                LR = 0;
            end
    
            u = rand(1);
            if (u < min(LR,1))
                S_0_prev = S_0_curr;
            end
    
    
    % Draw proposals for the parameters of M_0
    for j=1:n_dim
        M_0_curr = M_0_prev;
        M_0_curr(j) = normrnd(M_0_prev(j), proposal_variance);


        % Compute probabilities
        p_curr = 1;
        for i=1:n_sets
            p_curr = p_curr * prod(mvnpdf(X(:,:,i), M_prev(:,i)', S_prev(:,:,i))) * ...
                                prod(normpdf(M_prev(:,i)', M_0_curr', s_M));
            p_curr = p_curr * normpdf(S_prev(1,1,i), S_0_prev(1,1), s_S) * ...
                                normpdf(S_prev(1,2,i), S_0_prev(1,2), s_S) * ...
                                normpdf(S_prev(1,3,i), S_0_prev(1,3), s_S) * ...
                                normpdf(S_prev(2,2,i), S_0_prev(2,2), s_S) * ...
                                normpdf(S_prev(2,3,i), S_0_prev(2,3), s_S) * ...
                                normpdf(S_prev(3,3,i), S_0_prev(3,3), s_S);                                        
        end

        p_prev = 1;
        for i=1:n_sets
            p_prev = p_prev * prod(mvnpdf(X(:,:,i), M_prev(:,i)', S_prev(:,:,i))) * ...
                                prod(normpdf(M_prev(:,i)', M_0_prev', s_M));
            p_prev = p_prev * normpdf(S_prev(1,1,i), S_0_prev(1,1), s_S) * ...
                                normpdf(S_prev(1,2,i), S_0_prev(1,2), s_S) * ...
                                normpdf(S_prev(1,3,i), S_0_prev(1,3), s_S) * ...
                                normpdf(S_prev(2,2,i), S_0_prev(2,2), s_S) * ...
                                normpdf(S_prev(2,3,i), S_0_prev(2,3), s_S) * ...
                                normpdf(S_prev(3,3,i), S_0_prev(3,3), s_S);                
        end


        LR = p_curr / p_prev;
        if (isnan(LR))
            LR = 0;
        end

        u = rand(1);
        if (u < min(LR,1))
            M_0_prev = M_0_curr;
        end

    end
    
   
    % Store samples
    if (t > sampler_burnin)
        S_0_samples(:,:,t-sampler_burnin) = S_0_curr;
        M_0_samples(:,:,t-sampler_burnin) = M_0_curr;
    end
    

    
end


