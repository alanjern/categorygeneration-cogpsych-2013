% Function takes inputs:
%     - pattern_posteriors: vector of pattern probabilities conforming to a
%           multinomial distribution
%     - feature_counts: a cell array (size n) of cell arrays (size f) of
%           vectors (length k^(m_i)) of observed feature counts, where
%           n is number of patterns, f is number of feature dimensions of
%           a pattern, m_i is the number of squares in piece i, and k is
%           the total number of symbols.
%     - num_samples: number of samples to generate
%
% Returns a cell array where each element is a vector of samples for a
% single pattern. Thus, the resulting cell array is of length n. Each 
% element is a s x f matrix where s is the number of samples and f is the
% number of features. Each row in the matrix is therefore a set of feature
% values.

function samples = generate_samples(pattern_posteriors, feature_counts, num_samples, ...
                                    num_symbols, training_set)

samples = cell(1, length(pattern_posteriors));
for i = 1:length(pattern_posteriors)
    samples{i} = [];
end

s = 1;
%for s=1:num_samples
while (s <= num_samples)
    % First, sample a pattern
    pattern = find(mnrnd(1, pattern_posteriors/sum(pattern_posteriors)) > 0);

    % Then sample its features
    pattern_counts = feature_counts{pattern};
    num_features = length(pattern_counts);
    feature_values = zeros(num_features,1);
    for i=1:num_features
        %feature_dist = dirichletrnd(1 + pattern_counts{i});
        num_values = length(pattern_counts{i});
        dirichlet_prior = zeros(num_values,1) + 1/(num_values);
        feature_dist = dirichletrnd(dirichlet_prior + pattern_counts{i});
        % Sample from the feature distribution
        feature_values(i) = find(mnrnd(1, feature_dist) > 0);
    end
    
    % Check that this wasn't one of the training items
    [deparsed_sample c] = deparse_data(feature_values', pattern, num_symbols);
    if (is_in(deparsed_sample{1}, training_set))
        continue;
    end
    
    
    samples{pattern} = [samples{pattern}; feature_values'];
    
    s = s+1;
    if (mod(s,100) == 0)
        fprintf('sample %d\n',s);
    end
end


