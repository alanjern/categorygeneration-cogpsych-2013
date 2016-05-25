function [deparsed_samples sample_counts] = rule_based_model(data, num_symbols, num_samples)

num_patterns = 15;

pattern_posteriors = zeros(num_patterns, 1);
feature_counts = cell(1, num_patterns);

% Compute the pattern posteriors
% and collect feature counts
for i=1:num_patterns
    feature_counts{i} = parse_data(data, i, num_symbols);
    pattern_posteriors(i) = log_pattern_posterior_rbm(i, feature_counts{i}, length(data));
end

% Because we assume that categories are only based on rules and that
% we have already seen all the valid pieces, we eliminate structure 1
% (i.e. each exemplar is a full piece) because this structure will not
% allow us to generate new exemplars.
pattern_posteriors = exp(pattern_posteriors);
pattern_posteriors(1) = 0;


% Eliminate invalid pattern posteriors
pattern_posteriors(isnan(pattern_posteriors)) = 0;

% Generate samples
samples = generate_samples_rbm(pattern_posteriors, feature_counts, num_samples, num_symbols, data);

% Deparse the samples so they can be displayed
[deparsed_samples sample_counts] = deparse_data2(samples, num_symbols);

