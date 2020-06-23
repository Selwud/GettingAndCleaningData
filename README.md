---
title: "README.md"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Introduction
This document describes how the script "run_analysis.R" works and what the input and output should be.

## Requirement
In order to work properly, this script should be put on the same directory that the UCI HAR Dataset downloaded and unzipped from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The "data.table" package will be used, make sure that the package is installed.

## Description
0 - The script will first entirely clean up the variable environnement.

1 - It will load the data from the differents txt files in the UCI HAR Dataset file in        order to merge the "test" and "train" dataset and get the activity labels and subject     numbers.

2 - It will filter the columns of the results in order to have only the variables with        "mean" or "std" to have only the mean or standard deviation measurements, as well as      modify the names to remove parenthesis and upper case.
    The "activity" and "subject" columns are added.

3 - A melted dataset is then created with subject as ID and activity as label, before         create a tidy dataset which takes the average value by subject and activity.

4 - The script will finally create a txt file named "UCIHARtidydataset.txt" in the same       working directory that contains the tidy dataset.