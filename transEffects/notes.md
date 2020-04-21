Trans Effects
---

The purpose of the code in this directory is to find the trans effects of CNVs using linear regressions, and then explore those effects and their patterns across cancer types.

## Finding trans effects
The file `workflow.txt` describes how to run linear regressions on genes and proteins and how to filter those regressions by Bonferroni-corrected p-value.

## Exploring patterns
The file `Effects_Across_Cancers.ipynb` describes the steps the researchers took to interpret the linear regression data. Please note that this code should be run with `transEffects` set as the working directory and that the folders `BonCorrect`, `CNV Tables`, `Protein tables 1` and `Protein tables 2` must be unzipped before running.
