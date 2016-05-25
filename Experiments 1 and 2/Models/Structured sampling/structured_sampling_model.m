function [deparsed_samples sample_counts] = structured_sampling_model(data, num_symbols, num_samples)

num_patterns = 15;          % Number of possible structures

pattern_posteriors = zeros(num_patterns, 1);
feature_counts = cell(1, num_patterns);

% Compute the pattern posteriors
% and collect feature counts
for i=1:num_patterns
    feature_counts{i} = parse_data(data, i, num_symbols);
    pattern_posteriors(i) = log_pattern_posterior_ssm(i, feature_counts{i});
end

pattern_posteriors = exp(pattern_posteriors);

% Eliminate invalid pattern posteriors
pattern_posteriors(isnan(pattern_posteriors)) = 0;

% Generate samples
samples = generate_samples_ssm(pattern_posteriors, feature_counts, num_samples, num_symbols, data);


% Deparse the samples so they can be displayed
[deparsed_samples sample_counts] = deparse_data2(samples, num_symbols);

