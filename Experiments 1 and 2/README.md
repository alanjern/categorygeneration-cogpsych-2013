Experiments 1 and 2
===================

Models
------

The script `run_models.m` will generate samples from all three models (structured sampling, rule-based, independent features). These are the predictions used in Figures 6 and 7. The number of samples generated is specified by the variable `n_samples`. This script also prints the top 10 most probable items under each model.

The models' samples and their frequencies are included in the following matrices:
* Structured sampling: `ssm_samples` and `ssm_sample_counts`
* Rule-based: `rbm_samples` and `rbm_sample_counts`
* Independent features: `ifm_samples` and `ifm_sample_counts`

Each row of the samples matrices is a unique 4-element vector. Each element contains the feature value for one of the four features.

Data
----

### generation.xls

This spreadsheet contains the data from the generation tasks. The first sheet ("All data") shows each participant's responses. The responses are coded as follows. The first piece was coded A through D and the second piece was coded 1 through 4. If a subject generated a piece that did not have an alphanumeric label, it appears as an X in this sheet. The second sheet ("Invalid responses") includes all the invalid responses. These data were used to compute the number of times each specific invalid response was produced.

### classification.csv

This spreadsheet contains the data from the classification tasks. Each column corresponds to one of the rating items. Note that some cells are blank because the participant failed to rate every item.

* Items 1-4: valid items
* Items 5-6: tweaked items
* Items 7-8: rotated items
* Items 9-10: three seen pairings
* Items 11-12: two seen pairings
* Items 13-14: one seen pairing

### timing.mat

This Matlab file contains the timing data described in sections 4.4.4 and 5.2.4 of the paper. Loading the file reads in a cell array named `subjectData`. For each subject (for whom timing data was available), the cell contains a Dx3 matrix where D is the number of the participant's responses that were drawn one piece at a time. Each column includes three time recordings: (1) the time between starting the first letter of the first piece and the second letter of the first piece, (2) the time between starting the second letter of the first piece and the first letter of the second piece, and (3) the time between starting the first letter of the second piece and the second letter of the second piece.