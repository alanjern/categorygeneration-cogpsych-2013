% Function takes inputs:
%     - pattern_index: index k of pattern (of which there is a finite number)
%     - feature_frequencies: a cell array with n elements where n is the
%           number of features given pattern k. Each element i of 
%           feature_frequencies is a vector of length f where f is the number 
%           of different observed feature values along dimension i. Element
%           i represents counts of each feature value.
%
% For example, if the pattern is of the form
%    +---+---+
%    | 1 | 1 |
%    +---+---+
%    | 2 | 2 |
%    +---+---+
% which has index k, and 3 different horizontal bars have been observed
% along the top and 2 different horizontal bars along the bottom, then
%
%     pattern_index = 4
%
% and feature_frequencies is a 2 element cell array in which the first
% element is a vector of length 3 representing the frequencies of the 3
% different horiztonal bars observed for feature 1. Similarly, the second
% element is a vector of length 2.
%
% The return value is the probability of pattern k given the observed
% feature frequencies.

function p = log_pattern_posterior_ssm(pattern_index, feature_frequencies)

% === Pattern Key ===
%
%    Pattern          |      Index
% --------------------+------------------
%    +---+---+        |
%    | 1 | 1 |        |
%    +---+---+        |       1
%    | 1 | 1 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 2 | 1 |        |
%    +---+---+        |       2
%    | 1 | 1 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 2 |        |
%    +---+---+        |       3
%    | 1 | 1 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 1 |        |
%    +---+---+        |       4
%    | 2 | 1 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 1 |        |
%    +---+---+        |       5
%    | 1 | 2 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 2 |        |
%    +---+---+        |       6
%    | 1 | 2 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 1 |        |
%    +---+---+        |       7
%    | 2 | 2 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 2 |        |
%    +---+---+        |       8
%    | 2 | 1 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 2 |        |
%    +---+---+        |       9
%    | 1 | 3 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 2 | 1 |        |
%    +---+---+        |       10
%    | 3 | 1 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 2 | 3 |        |
%    +---+---+        |       11
%    | 1 | 1 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 1 |        |
%    +---+---+        |       12
%    | 2 | 3 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 2 | 1 |        |
%    +---+---+        |       13
%    | 1 | 3 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 2 |        |
%    +---+---+        |       14
%    | 3 | 1 |        |
%    +---+---+        |
% --------------------+------------------
%    +---+---+        |
%    | 1 | 2 |        |
%    +---+---+        |       15
%    | 3 | 4 |        |
%    +---+---+        |
% --------------------+------------------

p = 0;

if (pattern_index == 1)
    if (length(feature_frequencies) ~= 1)
        error('Pattern 1 has 1 feature');
    end
    %p = 1/15;     % pattern prior
    for i=1:1
        feature_i = feature_frequencies{i};
        num_values = length(feature_i);
        %num_values = num_symbols^4;
        dirichlet_prior_param = zeros(num_values,1) + 1/(num_values);    % feature distribution prior parameter
        p = p + ... & (factorial(sum(feature_i)) / prod(factorial(feature_i))) * ...
            (log_beta_function(feature_i + dirichlet_prior_param) - ...
             log_beta_function(dirichlet_prior_param));
    end

elseif (pattern_index >= 2 && pattern_index <= 8)
    if (length(feature_frequencies) ~= 2)
        error('Pattern %d has 2 features', pattern_index);
    end
    %p = 1/15;     % pattern prior
    for i=1:2
        feature_i = feature_frequencies{i};
        num_values = length(feature_i);
        dirichlet_prior_param = zeros(num_values,1) + 1/(num_values);    % feature distribution prior parameter
        p = p + ... & (factorial(sum(feature_i)) / prod(factorial(feature_i))) * ...
            (log_beta_function(feature_i + dirichlet_prior_param) - ...
             log_beta_function(dirichlet_prior_param));
    end
    
elseif (pattern_index >= 9 && pattern_index <= 14)
    if (length(feature_frequencies) ~= 3)
        error('Pattern %d has 3 features', pattern_index);
    end
    %p = 1/15;     % pattern prior
    for i=1:3
        feature_i = feature_frequencies{i};
        num_values = length(feature_i);
        dirichlet_prior_param = zeros(num_values,1) + 1/(num_values);    % feature distribution prior parameter
        p = p + ... & (factorial(sum(feature_i)) / prod(factorial(feature_i))) * ...
            (log_beta_function(feature_i + dirichlet_prior_param) - ...
             log_beta_function(dirichlet_prior_param));
    end

elseif (pattern_index == 15)
    if (length(feature_frequencies) ~= 4)
        error('Pattern %d has 4 features', pattern_index);
    end
    %p = 1/15;     % pattern prior
    for i=1:4
        feature_i = feature_frequencies{i};
        num_values = length(feature_i);
        dirichlet_prior_param = zeros(num_values,1) + 1/(num_values);    % feature distribution prior parameter
        p = p + ... & (factorial(sum(feature_i)) / prod(factorial(feature_i))) * ...
            (log_beta_function(feature_i + dirichlet_prior_param) - ...
             log_beta_function(dirichlet_prior_param));
    end    
end

        
    
