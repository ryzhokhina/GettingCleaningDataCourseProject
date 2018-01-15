## Prepare data
####################################################################

# download data
fileName<-"dataset.zip"
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists(fileName)){
  download.file(url,fileName, mode = "wb") 
}
# unpack zip
dir<- "UCI HAR Dataset"
if(!file.exists(dir))
{
  unzip(fileName) 
}

# read colum names
featureNames <- read.table(paste(dir,"features.txt", sep = "/"))

# load data
trainX<- read.table(paste(dir,"train","X_train.txt", sep = "/"), col.names = featureNames[,2])
testX<- read.table(paste(dir,"test","X_test.txt", sep = "/"),col.names = featureNames[,2])

# load labels
trainY<- read.table(paste(dir,"train","Y_train.txt", sep = "/"),col.names = c("activity"))
testY<- read.table(paste(dir,"test","Y_test.txt", sep = "/"),col.names = c("activity"))

#load subject
trainSub<- read.table(paste(dir,"train","subject_train.txt", sep = "/"), col.names = c("subject"))
testSub<- read.table(paste(dir,"test","subject_test.txt", sep = "/"), col.names = c("subject"))



######################################################################
# 1. Merges the training and the test sets to create one data set.
dataSet <- cbind(rbind(trainSub,testSub ), rbind(trainY,testY), rbind(trainX,testX))

#######################################################################
# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
dataSet =dataSet[, grep("mean|std|subject|activity", names(dataSet))]

#######################################################################
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.

# load activity lables
activitiLabels<- read.table(paste(dir,"activity_labels.txt", sep = "/"))

actGroup <- factor(dataSet$activity)
levels(actGroup) <- activitiLabels[,2]
dataSet$activity <- actGroup

#######################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.

# check if reshape2 package is installed

if (!"reshape2" %in% installed.packages()) {
  install.packages("reshape2")
}
library("reshape2")

longData <- melt(dataSet,(id.vars=c("subject","activity")))
tidyData <- dcast(longData, subject + activity ~ variable, mean)
write.table(tidyData, "tidy_data.txt", row.name = FALSE)



