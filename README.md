# Getting a cleaning data - course assignment - week 4

This repository contains the analysis R code and generated tidy dataset for the assignment.

#### Files

* Codebook.md - the code book listing the columns in the tidy dataset.
* run_analysis.R - the code that downloads the dataset and generates the tidy dataset.

#### How the code works

* The R code automatically downloads the data into a folder called `data`.
* It unzips the downloaded folder and reads the train and test datasets into data frames.
* Then it merges train and test data to create a combined dataset which also includes descriptive
names for the activity labels.
* It then picks up the columns which has substrings `std` or `mean`.
* It then groups rows by subject and activity label and summarizes with average (mean) values for the variables to create the tidy dataset.

