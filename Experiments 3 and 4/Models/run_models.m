clear all;
close all;

n_samples = 2000; %200000;       % Number of samples to draw from the posterior probability distribution
burnin = 500; %50000;           % Number of burn-in samples to discard during the MCMC sampling process

n_crystal_samples = 500; %50000;   % Number of crystal sets to generate
n_crystals_per_set = 6;
n_crystal_dimensions = 3;
s_M = 0.5;                % sigma_mu
s_S = 0.05;               % sigma_Sigma

% Experiment 3: Generating crystals from the full sample space
% Comment out these lines to generate predictions for Experiment 4
fprintf('========= Experiment 3 =========\n');
fullrange = 1;
n_subjects = 22;

% ===== Experiment 4: Generating crystals from half of the length dimension =====
% Comment out these lines to generate predictions for Experiment 3
%fprintf('========= Experiment 4 =========\n');
%fullrange = 0;
%n_subjects = 23;

fprintf('====== r+ condition ======\n');
[rplus_S_0_samples rplus_M_0_samples] = hierarchical_sampling(n_samples, burnin, 1, fullrange);
fprintf('=== Hierarchical sampling model ===\n');
rplus_crystals_hsm = generatecrystals(rplus_M_0_samples, rplus_S_0_samples, n_crystals_per_set, n_crystal_samples, n_crystal_dimensions, s_M, s_S, fullrange);
plotsamples(rplus_crystals_hsm, n_subjects);
fprintf('=== Independent categories model ===\n');
rplus_crystals_icm = generatecrystals_nomodel(n_crystals_per_set, n_crystal_samples, n_crystal_dimensions, fullrange);

fprintf('====== r- condition ======\n');
[rminus_S_0_samples rminus_M_0_samples] = hierarchical_sampling(n_samples, burnin, 2, fullrange);
fprintf('=== Hierarchical sampling model ===\n');
rminus_crystals_hsm = generatecrystals(rminus_M_0_samples, rminus_S_0_samples, n_crystals_per_set, n_crystal_samples, n_crystal_dimensions, s_M, s_S, fullrange);
plotsamples(rminus_crystals_hsm, n_subjects);
fprintf('=== Independent categories model ===\n');
rminus_crystals_icm = generatecrystals_nomodel(n_crystals_per_set, n_crystal_samples, n_crystal_dimensions, fullrange);

fprintf('====== r0 condition ======\n');
[rzero_S_0_samples rzero_M_0_samples] = hierarchical_sampling(n_samples, burnin, 3, fullrange);
fprintf('=== Hierarchical sampling model ===\n');
rzero_crystals_hsm = generatecrystals(rzero_M_0_samples, rzero_S_0_samples, n_crystals_per_set, n_crystal_samples, n_crystal_dimensions, s_M, s_S, fullrange);
plotsamples(rzero_crystals_hsm, n_subjects);
fprintf('=== Independent categories model ===\n');
rzero_crystals_icm = generatecrystals_nomodel(n_crystals_per_set, n_crystal_samples, n_crystal_dimensions, fullrange);


