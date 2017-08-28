# Getting and Cleaning Data Course Project

This repository contains the submission for the Getting and Cleaning Data Course Project peer-graded assignment.

### R Code

`run_analysis.R` is a R script with the following functionality. 

1. Download and unzips the data archive if the data directory `UCI HAR Dataset` is not found
2. Read the files `subject_train.txt`, `subject_test.txt`, `X_train.txt`, `X_test.txt`, `y_train.txt`, `y_test.txt` using `read.table`
3. Merging all data sets into a variable called `activity` and clearing unused variables
4. Applying  the column names `subject` and `label` to first and second column and reading the remaining column names from the file 'features.txt'
5. Subsetting the data set to only include column that have `mean()`, `std()`, `subject` or `label` in their names using `grepl`
6. Using the `factor` function to replace the 'label' observations with the activity names from the file from `activity_labels.txt`
7. Remove the brackets form the variable names, and lowercase all `label` observations
8. Requiring the `dplyr` package, the script uses the `group_by` and `summarize_at` functions to generate a new tidy data set with the average of each variable for each activity and each subject
9. Writing out the resulting tidy data set into a file called `activity_mean.csv` and the data set features into a file named `activity_mean-features.txt` 

### Codebook

The codebook for the resulting tidy data set in provided in a file named `activity_mean-into.txt`, in the same format and style as the codebook `features_info.txt` from the original data UCI HAR Dataset set.