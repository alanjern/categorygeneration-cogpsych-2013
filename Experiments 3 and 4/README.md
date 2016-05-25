Experiments 3 and 4
===================

Models
------

The script `run_models.m` will generate sample sets of crystals from both the hierarchical sampling model and the independent category model for all three conditions (r\_+, r\_-, r\_0). To generate crystals for the task in Experiment 3, comment out the lines for Experiment 4 (parameters `fullrange` and `n_subjects`). To generate crystals for the task in Experiment 4, comment out the corresponding lines for Experiment 3.

This script generates the samples used to create Figures 14a and 17a. These samples can also be used to compute the predictions in Figures 14b, 15, and 17b. The number of posterior samples to draw is specified by the variable `n_samples` and the number of burn-in samples for the MCMC sampler is specified by the variable burnin. The other parameters specify how many sets of crystals to generate (`n_crystal_samples`), the number of crystals per set (`n_crystals_per_set`), the number of crystal dimensions (`n_crystal_dimensions`), and the sigma\_mu and sigma\_Sigma parameters described in section A.3.1 of the paper.

The models' samples are included in the following matrices.
* Hierarchical sampling (r\_+): `rplus_crystals_hsm`
* Hierarchical sampling (r\_-): `rminus_crystals_hsm`
* Hierarchical sampling (r\_0): `rzero_crystals_hsm`
* Independent categories (r\_+): `rplus_crystals_icm`
* Independent categories (r\_-): `rminus_crystals_icm`
* Independent categories (r\_0): `rzero_crystals_icm`

Each matrix is of size `n_crystals_per_set` X `n_crystal_dimensions` X `n_crystal_samples`. Thus, for example, `rplus_crystals_hsm(:,:,i)` returns the ith set of crystals, where each row contains the [hue length saturation] values of one crystal in the set.

Data
----

### Experiment 3

The Experiment 3 folder contains .mat files with complete recorded data for all participants. The script `plotresults.m` will extract the key data from these files and generate the plots that appear in Figure 14. In these plots, the length dimension only spans from 0.05 to 0.8 because these were the hard-coded endpoints of the length scale. Participants did not see these numbers, so the paper maps 0.05 and 0.8 to 0 and 1, respectively.

The script also generates a set of plots showing the generated crystal category hues plotted against their lengths. Note that most of the lines in these plots are horizontal, indicating that participants hardly varied the hues of their crystal categories. The matrix `huestdevs` contains the SDs for the hue dimensions of all participants' crystals and can be used to generate the plots in Figure 15a. `huestdevs` is an n x c matrix, where n is the number of subjects and c is the condition.

The file `explain.txt` contains all participants' written explanations.

### Experiment 4

The Experiment 4 folder contains .mat files with complete recorded data for all participants. The script `plotresults.m` will extract the key data from these files and generate the plots that appear in Figure 17.

### Follow-up experiment

The Follow-up experiment folder contains .mat files with complete recorded data for all participants in the follow-up experiment described in Section 7.2.1 of the paper. The script `showactions.m` extracts the key data from these files and generates a series of figures that depict the sequences of actions taken by each participant when generating crystals.

In the figures, a new panel is generated every time a participant created a new crystal, moved an existing crystal, or changed the value of one dimension of an existing crystal. There are 42 panels per figure. The titles of the panels indicate the participant, condition, figure number, and panel number. That is, the title of each panel is "P.C. - F.N.", which means participant P, condition C (1 = r\_+, 2 = r\_-, 3 = r\_0), figure F, panel N.
