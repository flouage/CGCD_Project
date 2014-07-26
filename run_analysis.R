## General
setwd("C:\\AS\\Frank\\Courses\\CGCD\\Project\\Code")
library(data.table)
library(plyr)
library(reshape2)
## data saved on 20140716 (YYYYMMDD)

## Load data into R
## Load Test set: A 561-feature vector with time and frequency domain variables.
X_Test <- read.table("../Data/UCI HAR Dataset/test/X_test.txt", sep = "",header = FALSE)
## visual control first rows
head(X_Test)
## visual control last rows
tail(X_Test)
summary(X_Test)
dim(X_Test)
## [1] 2947  561

## Load training set: A 561-feature vector with time and frequency domain variables.
X_Training <- read.table("../Data/UCI HAR Dataset/train/X_train.txt", sep = "",header = FALSE)
## visual control first rows
head(X_Training)
## visual control last rows
tail(X_Training)
summary(X_Training)
dim(X_Training)
## [1] 7352  561

## 1) Merges the training and the test sets to create one data set.
## then merge test with training set
myX <- rbind(X_Test,X_Training)
dim(myX)
## [1] 10299   561
head(myX)

## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## Load features
myFeatures <- read.table("../Data/UCI HAR Dataset/features.txt", sep = "",header = FALSE)
dim(myFeatures)
## [1] 561   2
head(myFeatures)
tail(myFeatures)

## select features with mean or std (standard deviation) in their name
mySelection <- grepl("mean|std",myFeatures[,2])
head(mySelection)
tail(mySelection)
summary(mySelection)
## Mode   FALSE    TRUE    NA's 
## logical     482      79       0 
myXSelection <- myX[,mySelection]
dim(myXSelection)
## [1] 10299    79

## 3) Uses descriptive activity names to name the activities in the data set

## Load features
myActivities <- read.table("../Data/UCI HAR Dataset/activity_labels.txt", sep = "",header = FALSE)
dim(myActivities)
## [1] 6 2
head(myActivities)
tail(myActivities)
is.factor(myActivities[,2])

## Load test labels: class labels with their activity name.
Y_Test <- read.table("../Data/UCI HAR Dataset/test/y_test.txt", sep = "",header = FALSE)
## visual control first rows
head(Y_Test)
## visual control last rows
tail(Y_Test)
summary(Y_Test)
dim(Y_Test)
## [1] 2947    1

## Load training labels: class labels with their activity name.
Y_Training <- read.table("../Data/UCI HAR Dataset/train/y_train.txt", sep = "",header = FALSE)
## visual control first rows
head(Y_Training)
## visual control last rows
tail(Y_Training)
summary(Y_Training)
dim(Y_Training)
## [1] 7352    1

## then merge test labels with training labels
myY <- rbind(Y_Test,Y_Training)
dim(myY)
## [1] 10299   1
head(myY)

## Label the activities
myYLabelled <- factor(myY[,1], levels = myActivities[,1],  labels = myActivities[,2])
dim(myYLabelled)
## NULL
head(myYLabelled)

## bind the labels to the data set
myYXLabelled <- cbind(myYLabelled, myXSelection)
dim(myYXLabelled)
head(myYXLabelled)

## 4) Appropriately labels the data set with descriptive variable names. 

dim(myYXLabelled[,2:80])
myFeatures[mySelection,2]
dim(myFeatures[mySelection,2])
is.factor(myFeatures[mySelection,2])
#levels(myFeatures[mySelection,2])[mySelection]
colnames(myYXLabelled)[1] <- "Activity"
colnames(myYXLabelled)[2:80] <- as.character.factor(myFeatures[mySelection,2])
head(myYXLabelled)

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## add subject data

## Load subject test set: A 561-feature vector with time and frequency domain variables.
S_Test <- read.table("../Data/UCI HAR Dataset/test/subject_test.txt", sep = "",header = FALSE)
## visual control first rows
head(S_Test)
## visual control last rows
tail(S_Test)
summary(S_Test)
dim(S_Test)
## [1] 2947  1

## Load subject training set: A 561-feature vector with time and frequency domain variables.
S_Training <- read.table("../Data/UCI HAR Dataset/train/subject_train.txt", sep = "",header = FALSE)
## visual control first rows
head(S_Training)
## visual control last rows
tail(S_Training)
summary(S_Training)
dim(S_Training)
## [1] 7352  1

## then merge subject test with training set
myS <- rbind(S_Test,S_Training)
dim(myX)
## [1] 10299   1
head(myX)

## bind the subject to the labelled data set
myDataSetFinal <- cbind(myS, myYXLabelled)
## label
colnames(myDataSetFinal)[1] <- "Subject"
dim(myDataSetFinal)
## [1] 10299    81
head(myDataSetFinal)
tail(myDataSetFinal)

myTidyDataset <- melt(myDataSetFinal, id = c("Subject", "Activity"))
dim(myTidyDataset)
head(myTidyDataset)
tail(myTidyDataset)
colnames(myTidyDataset)[3] <- "Variablename"
myTidyDatasetFinal <- ddply(myTidyDataset, .(Subject, Activity, Variablename), summarise, mean(value))
colnames(myTidyDatasetFinal)[4] <- "mean of Variablename"
dim(myTidyDatasetFinal)
## 30*6*79 = 14220 4
head(myTidyDatasetFinal)

## export myTidyDatasetFinal
write.csv(myTidyDatasetFinal, file = "tidyDataSet.txt")
