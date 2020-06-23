## Clean environnement
rm(list=ls())

## Import library
library(data.table)

## Read and store raw data
actlab <- fread("./UCI HAR Dataset/activity_labels.txt")
featur <- fread("./UCI HAR Dataset/features.txt")
# as well as merge test and train data
globdb <- rbind(fread("./UCI HAR Dataset/test/X_test.txt"),fread("./UCI HAR Dataset/train/X_train.txt"))
gloact <- rbind(fread("./UCI HAR Dataset/test/y_test.txt"),fread("./UCI HAR Dataset/train/y_train.txt"))
glosub <- rbind(fread("./UCI HAR Dataset/test/subject_test.txt"),fread("./UCI HAR Dataset/train/subject_train.txt"))

## Filter Mean and Std columns
meanstd <- featur[grep("-(mean|std).*",featur$V2)]
# Merge selected columns with activity and subject, and name the columns
globdb <- cbind(subset(globdb,select = meanstd$V1),gloact,glosub)
colnames(globdb) <- c(gsub("[-()]","",meanstd$V2),"activity","subject")

## Give activity label and set subject as factor
globdb$activity <- factor(globdb$activity, levels = actlab$V1, labels = gsub("_","",tolower(actlab$V2)))
globdb$subject <- as.factor(globdb$subject)

## Create Tidy data set with the average of each variable 
meltDB <- melt(globdb,id = c("subject","activity"))
TidyDB <- dcast(meltDB,activity + subject ~ variable,mean)

## Write txt file
write.table(TidyDB,file = "./UCIHARtidydataset.txt", row.names = FALSE)