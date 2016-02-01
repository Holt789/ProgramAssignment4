# Coursera Getting Data Assignment

This repo contains an R script (run_analysis.R).  Its purpose is to take two input 
datasets and merge them to form third dataset containing only the measurement values 
for mean and standard deviation for each measurement.  

A fourth dataset (NewDataSet.txt) is then created containing tidy data set with 
the average of each variable for each activity and each subject.
 

# Input data
 The program will check for the existence of the following source data directory
 ./UCI HAR Dataset if the directory is there it will assume the data is present and proceed
 if the directory is not present it will download the required data and then proceed.
 

 The input datasets consist of 6 files files
  The 1st is the training dataset 
   X_train.txt - This contains the activity readings with a value from 1 - 6
   y_train.txt - 
   subject_train.txt - 

  The 2nd input dataset is the test data set.  This also consists of three input files
  X_test.txt
  y_test.txt
  subject_test.txt
  
# output data
  Two text files will be created containing the 
     ./UCI HAR Dataset/CombinedDataSet.txt - merged mean and standard deviation dataset 
     ./UCI HAR Dataset/NewDataSet.txt - new summarised dataset
   The summarised dataset will also be return from calling the run_analysis function
  