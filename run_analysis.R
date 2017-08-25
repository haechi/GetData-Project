## Getting and Cleaning Data Course Project

# Download archive if data directory is missing
if (!(file.exists("./UCI HAR Dataset"))) {
  download.file(
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
    "getdata-projectfiles-UCI HAR Dataset.zip")
  unzip(zipfile="getdata-projectfiles-UCI HAR Dataset.zip")
}

## 1. Merges the training and the test sets to create one data set.

# Read all data sets
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                           header = F, stringsAsFactors = F, fill = T)
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                          header = F, stringsAsFactors = F, fill = T)
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt",
                     header = F, stringsAsFactors = F, fill = T)
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt",
                    header = F, stringsAsFactors = F, fill = T)
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt",
                     header = F, stringsAsFactors = F, fill = T)
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt",
                    header = F, stringsAsFactors = F, fill = T)

# Merge data sets and remove originals from memory
activity <- cbind(rbind(trainSubject, testSubject), 
                  rbind(trainLabel, testLabel), rbind(trainSet, testSet))
rm(trainSubject,testSubject,trainSet,testSet,trainLabel,testLabel)


# Name first two colums "subject" and "label" and all others according to the 2nd column 
# of "features.txt"
colnames(activity)[1:2] <- c("subject", "label")
colnames(activity)[3:563] <- read.table("./UCI HAR Dataset/features.txt",
                                        header = F, stringsAsFactors = F)[, 2]

## 2. Extracts only the measurements on the mean and standard deviation for each 
## measurement.

# Subset to only include columns that have "mean()", "std()", "subject" or "label" 
activity <- activity[, grepl("mean\\(\\)|std\\(\\)|subject|label", colnames(activity))]


## 3. Uses descriptive activity names to name the activities in the data set

# Read 2nd column from activity_labels.txt and apply the lables to the data set
activity$label <- factor(activity$label, 
                         labels = read.table("./UCI HAR Dataset/activity_labels.txt", 
                                             header = F, stringsAsFactors = F)[, 2])

## 4. Appropriately labels the data set with descriptive variable names

# Clean up the brackets in the variable names and lowercasing all labels
names(activity) <- gsub("\\(\\)", "", names(activity)) 
activity$label <- tolower(activity$label)


## 5. From the data set in step 4, creates a second, independent tidy data set 

# Average of each variable for each activity and subject
require(dplyr)
activityMean <- activity %>% group_by(subject,label) %>% 
                summarize_at(.var = names(activity)[3:ncol(activity)], .funs = funs(mean))

# Write out resulting data set and the features
write.csv(activityMean, "./activity_mean.csv", row.names = F, quote = F)
write.table(names(activityMean), "./activity_mean-features.txt", row.names=F, quote = F)




