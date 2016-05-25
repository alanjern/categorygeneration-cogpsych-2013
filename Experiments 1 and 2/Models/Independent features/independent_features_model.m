function [deparsed_samples sample_counts] = independent_features_model(data, num_symbols, num_samples)

num_patterns = 15;

pattern_posteriors = zeros(num_patterns, 1);
feature_counts = cell(1, num_patterns);

% Compute the pattern posteriors
% and collect feature counts
for i=1:num_patterns
    feature_counts{i} = parse_data(data, i, num_symbols);
end

pattern_posteriors = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];

% Generate samples
samples = generate_samples_ifm(pattern_posteriors, feature_counts, num_samples, num_symbols, data);

% Deparse the samples so they can be displayed
[deparsed_samples sample_counts] = deparse_data2(samples, num_symbols);


