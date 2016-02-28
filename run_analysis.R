#Call libraries and set wd
library(data.table)
library(dplyr)
library(tidyr)

setwd('C:/Users/HP/Documents/0_Sandra_Yojana/Data_Science/Tasks/GetCleanData_CourseProject')

#Download the data if necessary
path <- "UCI HAR Dataset"
if (!dir.exists(path)) {
    url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile <- "getdata-projectfiles-UCI HAR Dataset.zip"
    download.file(url, destfile = zipfile)
    unzip(zipfile)
}

##1.Merges the training and the test sets to create one data set.

##Extract files training data
x_train <- data.table(read.csv(file.path(path, "train", "X_train.txt"),sep="",header=FALSE))
y_train <- data.table(read.csv(file.path(path, "train", "Y_train.txt"),sep="",header=FALSE))
s_train <- data.table(read.csv(file.path(path, "train", "subject_train.txt"),sep="",header=FALSE))

##Extract files test data
x_test <- data.table(read.csv(file.path(path, "test", "X_test.txt"),sep="",header=FALSE))
y_test <- data.table(read.csv(file.path(path, "test", "Y_test.txt"),sep="",header=FALSE))
s_test <- data.table(read.csv(file.path(path, "test", "subject_test.txt"),sep="",header=FALSE))

##Creat datasets with all variables
train <- cbind(s_train,y_train,x_train)
test <- cbind(s_test,y_test,x_test)

#Merge all in one data set
dt <- rbind(train, test)

#Extract and set names of variables
features <- read.csv(file.path(path, "features.txt"),sep="",header=FALSE)
setnames(dt, c("subject", "activity",as.vector(features[, 2])))

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
dt_sub <- select(dt, subject, activity,contains("-mean()"), contains("-std()"))

##3.Uses descriptive activity names to name the activities in the data set
activities <- read.csv(file.path(path, "activity_labels.txt"),  sep="", header=FALSE)
dt_sub$activity <- as.character(activities[match(dt_sub$activity, activities$V1), 'V2'])

##4.Appropriately labels the data set with descriptive variable names.
##Separate signal, function and axis
dt_sub_gather <- gather(dt_sub,signal_variable_axis,Magnitud,-subject, -activity)
dt_sub_separate <- separate(dt_sub_gather,signal_variable_axis,c("signal","variable","axis"))

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dt_sub_summary <- dt_sub_separate %>%
                group_by(subject, activity,signal,variable,axis) %>%
                summarise_each(funs(mean))

write.table(dt_sub_separate, file="data_tidy.txt", row.name=FALSE)
write.table(dt_sub_summary, file="data_summary.txt", row.name=FALSE)
