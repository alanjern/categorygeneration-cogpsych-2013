function s = generatecrystals_nomodel(m, n, d, fullrange)
% Generate sets of crystal samples without any model assumptions / training
%
% n: number of crystal groups
% m: number of crystals per group
% d: the number of crystal dimensions
% fullrange: 0 if crystals only generated from half of length dimension (Expt 4)
%            1 if crystals generated from full space (Expt 3)
%
% Return an n-by-m matrix of samples
%
% In our experiments, we asked participants to 
% generate a set of m=6 crystals, each with d=3 dimensions

% Fixed parameter values
s_M = 0.5;
s_S = 0.05;

samples = zeros(n,m,d);

for i=1:n
    
    % Sample superordinate covariance matrix
    posdef = 0;
    S = zeros(d,d);
    while (posdef == 0)
        S(1,1) = rand()*10-5;
        S(1,2) = rand()*10-5;
        S(1,3) = rand()*10-5;
        S(2,1) = S(1,2);
        S(2,2) = rand()*10-5;
        S(2,3) = rand()*10-5;
        S(3,1) = S(1,3);
        S(3,2) = S(2,3);
        S(3,3) = rand()*10-5;
        
        [tt pd] = cholcov(S,0);
        if (pd == 0)
            posdef = 1;
        end
    end
    
    % Sample means
    for j=1:d
        M(j) = rand()*10-5; 
    end
    
    
    % Sample category covariance matrix
    posdef = 0;
    S_new = zeros(d,d);
    while (posdef == 0)
        S_new(1,1) = normrnd(S(1,1), s_S);
        S_new(1,2) = normrnd(S(1,2), s_S);
        S_new(1,3) = normrnd(S(1,3), s_S);
        S_new(2,1) = S_new(1,2);
        S_new(2,2) = normrnd(S(2,2), s_S);
        S_new(2,3) = normrnd(S(2,3), s_S);
        S_new(3,1) = S_new(1,3);
        S_new(3,2) = S_new(2,3);
        S_new(3,3) = normrnd(S(3,3), s_S);
        
        [tt pd] = cholcov(S_new,0);
        if (pd == 0)
            posdef = 1;
        end
    end

    
    % Sample means
    for j=1:d
        M_new(j) = normrnd(M(j), s_M);
    end
    
    
    % Now sample some crystals
    for j=1:m
        s_temp = mvnrnd(M_new,S_new);
        s(j,:,i) = s_temp;
    end
    
    if (fullrange == 1)
        % This maps all outputs onto [0 1] using the logistic
        % function
        s(:,:,i) = 1 ./ (1 + exp(-s(:,:,i)));
    else
        % Here, we map the restricted dimesion onto [0.5 1]
        s(:,1,i) = 1 ./ (1 + exp(-s(:,1,i)));
        s(:,3,i) = 1 ./ (1 + exp(-s(:,3,i)));
        s(:,2,i) = 1 ./ ((1 + exp(-s(:,2,i))))*0.5 + 0.5;
    end

end
