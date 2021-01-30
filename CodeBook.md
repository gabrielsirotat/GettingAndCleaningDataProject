---
# title: "CodeBook"
author: "Gabriel Sirota"
date: "1/29/2021"
---

## Process 
The run_analysis.R script performs the data cleanse and organization as required and described in the course project’s definition.

### 0) Download the dataset
-Dataset downloaded and extracted under the folder called UCI HAR Dataset

### 0.1) Assign each data to variables
- feat <- features.txt : The features on this database come from messurments of an  accelerometer and gyroscope (representing 3-axial raw signals tAcc-XYZ and tGyro-XYZ)
- activities <- activity_labels.txt :list all the activities performed
- subtest <- test/subject_test.txt : containing results of the volunteer test subjects observed
- xtest <- test/X_test.txt : contains recorded features test data
- ytest <- test/y_test.txt : contains test data of activities’code labels
- subtrain <- test/subject_train.txt :contains train data of the volunteer subjects that were observed
- xtrain <- test/X_train.txt : contains recorded features train data
- ytrain <- test/y_train.txt : contains train data of activities’code labels

### 1) Merges the training and the test sets to create one data set
- X  is created by merging data with the rbind function (xtrain and xtest) 
- Y  is created by merging data with the rbind function (ytrain and ytest)
- Subject is created by merging data with the rbind function (subtrain and subtest)
- MergedData is created by merging the data of Subject, Y and X using  the cbind function

### 2) Extracts only the measurements on the mean and standard deviation for each measurement
TidyData is created by subsetting MergedData, selecting only  the following columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

### 3) Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

### 4) Appropriately labels the data set with descriptive variable names
- code column in TidyData renamed into activities
- All start with character t in column’s name gets replaced by time
- All start with character f in column’s name gets replaced by frequency
- All Gyro in column’s name gets replaced by gyroscope
- All Acc in column’s name gets replaced by accelerometer
- All BodyBody in column’s name gets replaced by body
- All Mag in column’s name gets replaced by magnitude

### 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
- NewData is created by sumarizing our TidyData variable  this so it can take the means of each variable for each activity and each subject, after groupped by subject and activity.
- Finally we export NewData into NewData.txt file and it gets printed in a new window.
