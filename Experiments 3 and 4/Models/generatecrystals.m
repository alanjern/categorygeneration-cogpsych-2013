function s = generatecrystals(M_0_samples, S_0_samples, m, n, d, s_M, s_S, fullrange)
% Generate sets of crystal samples.
%
% M_0_samples: a vector of category mean samples
% S_0_samples: a vector of covariance matrix samples
% m: number of crystals per group
% n: number of crystal groups
% d: the number of crystal dimensions
% fullrange: 0 if crystals only generated from half of length dimension (Expt 4)
%            1 if crystals generated from full space (Expt 3)
%
% Return an n-by-m matrix of samples
%
% In our experiments, we asked participants to 
% generate a set of m=6 crystals, each with d=3 dimensions


samples = zeros(n,m,d);

for i=1:n

    % Sample values for the hyperparameters
    nsamples = length(M_0_samples);
    sample_index = randsample(nsamples,1);
    %M_0 = M_0_samples(:,:,sample_index);
    M_0_transformed(1) = rand(); % sample mean on dim 1 from unif(0,1)
    M_0_transformed(2) = rand() * 0.5 + 0.5; % sample mean on dim 2 from unif(0.5,1)
    M_0_transformed(3) = rand(); % sample mean on dim 3 from unif(0,1)
    M_0 = log(M_0_transformed) - log(1-M_0_transformed);
    S_0 = S_0_samples(:,:,sample_index);
    
    
    validset = 0;
    
    % Sample covariance matrix
    posdef = 0;
    S = zeros(d,d);
    while (posdef == 0 || validset == 0)
        S(1,1) = normrnd(S_0(1,1), s_S);
        S(1,2) = normrnd(S_0(1,2), s_S);
        S(1,3) = normrnd(S_0(1,3), s_S);
        S(2,1) = S(1,2);
        S(2,2) = normrnd(S_0(2,2), s_S);
        S(2,3) = normrnd(S_0(2,3), s_S);
        S(3,1) = S(1,3);
        S(3,2) = S(2,3);
        S(3,3) = normrnd(S_0(3,3), s_S);
        
        [tt pd] = cholcov(S,0);
        if (pd == 0)
            posdef = 1;
        else
            continue;
        end
    
        % Sample means
        for j=1:d 
            M(j) = normrnd(M_0(j), s_M);
        end
        
        % Now sample some crystals
        for j=1:m
            s_temp = mvnrnd(M,S);
            s(j,:,i) = s_temp;
        end
        
        if (fullrange == 1)
            % This maps all outputs onto [0 1] using the logistic
            % function
            s(:,:,i) = 1 ./ (1 + exp(-s(:,:,i)));
            validset = 1;
        else
            % Here, we map the restricted dimesion onto [0.5 1]
            s(:,1,i) = 1 ./ (1 + exp(-s(:,1,i)));
            s(:,3,i) = 1 ./ (1 + exp(-s(:,3,i)));
            s(:,2,i) = 1 ./ (1 + exp(-s(:,2,i)));
            if (any(s(:,2,i) < 0.5))
                validset = 0;
            else
                validset = 1;
            end
        end
    end
end


