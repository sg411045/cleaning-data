# Getting and Cleaning Data
Getting and cleaning data project is an attempt to collect and clean data. The goal is to prepare a tiny data set.

# Script setup

This script assumes the data files are in the train and test sub folders as the script:
train
|_ X_train.txt
|_ y_train.txt
|_ subject_train.txt

test
|_ X_test.txt
|_ y_test.txt
|_ subject_test.txt

The script also assumes that the following 2 files are in the same folder as the script itself
- activity_labels.txt
- features.txt

# Running the script
Run the run_analysis.R script from the main directory. 

Running the script will create a tiny_data.txt in the same folder as the script. 