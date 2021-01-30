## Load the packages before you start

library(dplyr)

## Check if the file exisits and if not download it and unzip it 

filename <- "DS3Project.zip"

# Checking if archieve already exists.

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## After downloading the zipfile create & assign all the different data frames

feat <- read.table("UCI HAR Dataset/features.txt", 
                   col.names = c("n","functions"))
act <- read.table("UCI HAR Dataset/activity_labels.txt",
                  col.names = c("code", "activity"))
subtest <- read.table("UCI HAR Dataset/test/subject_test.txt",
                      col.names = "subject")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt",
                    col.names = feat$functions)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subtrain <- read.table("UCI HAR Dataset/train/subject_train.txt",
                       col.names = "subject")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", 
                     col.names = feat$functions)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

## Part 1: Merges the training and the test sets to create one data set

X <- rbind(xtrain, xtest)
Y <- rbind(ytrain, ytest)
Subject <- rbind(subtrain, subtest)
MergedData <- cbind(Subject, Y, X)

## Part 2: Extracts only the measurements on the mean and standard deviation 
## for each measurement. 

TidyData <- MergedData %>% 
  select(subject, code, contains("mean"), contains("std"))

## Part 3: Uses descriptive activity names to name the activities in the
## data set

TidyData$code <- act[TidyData$code, 2]

## Part 4: Appropriately labels the data set with descriptive variable names

names(TidyData)[2] = "act"
names(TidyData)<-gsub("^t", "time", names(TidyData))
names(TidyData)<-gsub("^f", "frequency", names(TidyData))
names(TidyData)<-gsub("Gyro", "gyroscope", names(TidyData))
names(TidyData)<-gsub("Acc", "accelerometer", names(TidyData))
names(TidyData)<-gsub("BodyBody", "body", names(TidyData))
names(TidyData)<-gsub("Mag", "magnitude", names(TidyData))
names(TidyData)<-gsub("tBody", "timeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "mean", names(TidyData))
names(TidyData)<-gsub("-std()", "std", names(TidyData))
names(TidyData)<-gsub("-freq()", "frequency", names(TidyData))

## Part 5: From the data set in step 4, creates a second, independent tidy data
## set with the average of each variable for each activity and each subject

NewData <- TidyData %>%
  group_by(subject, act) %>%
  summarise_all(funs(mean))
write.table(NewData, "NewData.txt", row.name=FALSE)

## See how your data turned out

View(NewData)