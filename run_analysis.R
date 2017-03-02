rm(list=ls())

library(dplyr)

## Creat directory
url1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

dnld_file<-"./zipped.zip"

## Download File
if(!dir.exists("UCI HAR Dataset")){
  download.file(url1,dnld_file)
}

## Unzip File
unzipped_dir<-"./UCI HAR Dataset"
if(!dir.exists(unzipped_dir)){
  unzip(dnld_file,exdir=".")
}

data_dir<-"./UCI HAR Dataset"

## Import all the relevant data
features_list<-read.table(paste(data_dir,"features.txt",sep="/"))
activity_labels<-read.table(paste(data_dir,"activity_labels.txt",sep="/"))

test_data<-read.table(paste(data_dir,"test/X_test.txt",sep="/"))
test_subjects<-read.table(paste(data_dir,"test/subject_test.txt",sep="/"))
test_labels<-read.table(paste(data_dir,"test/y_test.txt",sep="/"))

train_data<-read.table(paste(data_dir,"train/X_train.txt",sep="/"))
train_subjects<-read.table(paste(data_dir,"train/subject_train.txt",sep="/"))
train_labels<-read.table(paste(data_dir,"train/y_train.txt",sep="/"))

#Extract only mean ans std from the data set
relevant_col_index<-grep("mean|std",features_list$V2)
relevant_col_name<-grep("mean|std",features_list$V2,value=TRUE)
relevant_col_name<-gsub("\\()","",relevant_col_name)
relevant_test_data<-select(test_data,relevant_col_index)
relevant_train_data<-select(train_data,relevant_col_index)

#Merge Labels and subjects
total_labels<-rbind(test_labels,train_labels)
total_subjects<-rbind(test_subjects,train_subjects)

#Match labels with activity labels
total_label_names<-activity_labels[match(total_labels[,1],
                                         activity_labels[,1]),2]

#Combine only test and train data
total_data<-rbind(relevant_test_data,relevant_train_data)

#Create the first row of labels
label_row<-c("Subjects","Activity",relevant_col_name)

#Create a total tidy dateset
total_dataset<-cbind(total_subjects,total_label_names,total_data)
names(total_dataset)<-label_row

## Create a tidy dataset with mean of each subject and activity
reordered_data<-group_by(total_dataset,Activity,Subjects)
summarized_data<-summarize_each(reordered_data,funs(mean))

## Optinal -> Write CSV files of tidy ordered data
#write.csv(total_dataset,paste(data_dir,"merged_data.csv",sep="/"))

write.table(summarized_data,"tidy_data.csv",row.names = FALSE)

