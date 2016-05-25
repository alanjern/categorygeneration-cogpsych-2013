clear all;
close all;

addpath(genpath('.'));

% Define the observations. stimuli is a cell array of 2x2 matrices. Each
% cell in the matrix is a numerical value corresponding to the feature
% in that position.
%
% For the following data sets, the first row is the first "piece" and
% the second row is the second "piece" of the genome.

% ===== Experiment 1: Balanced feature frequencies =====
 stimuli = {[1 2; 9 10], [1 2; 11 12], ...
            [3 4; 9 10], [3 4; 13 14], ...
            [5 6; 11 12], [5 6; 15 16], ...
            [7 8; 13 14], [7 8; 15 16]};

% ===== Experiment 2: Unbalanced feature frequencies =====
%stimuli = {[1 2; 11 12], [1 2; 13 14], [1 2; 15 16], ...
%           [3 4; 9 10], [3 4; 13 14], ...
%           [5 6; 9 10], [5 6; 11 12], ...
%           [7 8; 9 10]};


n_samples = 100000;       % Number of samples to draw from the posterior probability distribution
n_symbols = 16;           % Number of symbols (i.e. letters)


% Structured sampling model
fprintf('=== Structured sampling model ===\n');
[ssm_samples ssm_sample_counts] = structured_sampling_model(stimuli, n_symbols, n_samples);

% Rule-based model
fprintf('\n=== Rule-based model ===\n');
[rbm_samples rbm_sample_counts] = rule_based_model(stimuli, n_symbols, n_samples);

% Independent features model
fprintf('\n=== Independent features model ===\n');
[ifm_samples ifm_sample_counts] = independent_features_model(stimuli, n_symbols, n_samples);


% Sort samples by frequency
ssm_sorted_counts = sort(ssm_sample_counts,'descend');
rbm_sorted_counts = sort(rbm_sample_counts,'descend');
ifm_sorted_counts = sort(ifm_sample_counts,'descend');

% Print out top 10 most probable items for each model
fprintf('\n--------------------------------------------------------\n\n');

fprintf('=== Most probable structured sampling model items ===\n');
for i=1:10
    sample_set = ssm_samples(ssm_sample_counts==ssm_sorted_counts(i),:);
    for j=1:size(sample_set,1)
        fprintf('%d %d %d %d\t', sample_set(j,1), sample_set(j,2), ...
                                 sample_set(j,3), sample_set(j,4));
        fprintf('%f\n\n', ssm_sorted_counts(i) / n_samples);
    end
end

fprintf('=== Most probable rule-based model items ===\n');
for i=1:10
    sample_set = rbm_samples(rbm_sample_counts==rbm_sorted_counts(i),:);
    for j=1:size(sample_set,1)
        fprintf('%d %d %d %d\t', sample_set(j,1), sample_set(j,2), ...
                                 sample_set(j,3), sample_set(j,4));
        fprintf('%f\n\n', rbm_sorted_counts(i) / n_samples);
    end
end

fprintf('=== Most probable independent features model items ===\n');
for i=1:10
    sample_set = ifm_samples(ifm_sample_counts==ifm_sorted_counts(i),:);
    for j=1:size(sample_set,1)
        fprintf('%d %d %d %d\t', sample_set(j,1), sample_set(j,2), ...
                                 sample_set(j,3), sample_set(j,4));
        fprintf('%f\n\n', ifm_sorted_counts(i) / n_samples);
    end
end
