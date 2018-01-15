---
title: "CodeBook"
author: "ryzhokhina"
date: "January 15, 2018"
output: html_document
---

## Code Book

This code book will describe the data used in this project, as well as the processing required to create the resulting tidy data set.

## Pre Analysis

This script will check if the data file is present in your working directory. If not, will download and unzip the file.

## 1. Read data and Merge

* featureNames : description(label) of each variables in X_test and X_train
* trainX : values of variables in train
* testY : values of variables in test
* trainY : activity ID in train
* testY : activity ID in test
* trainSub : subject IDs for train
* testSub : subject IDs for test
* activitiLabels: escription of activity IDs in y_test and y_train
* dataSet : merging the training and the test sets. It contains subject, activity and featuresName colums
 
## 2. Extract only mean() and std()
To extract only mean and std columns "grep" was used.

* dataSet : at the end of this step, dataSet will only contain mean and std variables

## 3. Uses descriptive activity names to name the activities in the data set.
## 4. Appropriately labels the data set with descriptive variable names.

In this step activitiLabels data frame was load from activity_labels.txt.

* actGroup : factored activity column of dataSet.

Rename each levels with 2nd column of activitiLabels. Finally apply the renamed "actGroup" to dataSet's activity column.

## 5.Output tidy data

In this part, dataSet is melted to create tidy data. Finally output the data as "tidy_data.txt".

* longData : melted tall and skinny dataSet.
* tidyData : casete longData which has means of each variables.