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
 
## Input data detail
 The input datasets consist of 6 files files
  The 1st is the training dataset 
   X_train.txt -  7352 obs of 561 variables, each variable a different measurement (86 selected)
   y_train.txt -  7352 obs of 1 variables, this pertains to activity readings with a value from 1 - 6
   subject_train.txt - 7352 obs of 1 variables, this pertains to the subject undertaking the test values 1 - 30

  The 2nd input dataset is the test data set.  This also consists of three input files
  X_test.txt -  2947 obs of 561 variables, each variable a different measurement (86 selected)
  y_test.txt -  2947 obs of 1 variables, this pertains to activity readings with a value from 1 - 6
  subject_test.txt - 2947 obs of 1 variables, this pertains to the subject undertaking the test values 1 - 30

# Merge detail
	Using the features file a check was made for all variables with either mean or std in their name.
	This logical marix is then used to select the 86 mean and std measurement variables into the merged 
	dataset.
	for both the input datasets the subject_ and the y_ variables were added to the X_ data frame.
	A third field dataset was also added to label which of the two input dataset the observation came.

	The combined dataset therefore consists 10299 observations of 89 variables. For more details see the code book.
	Once the combined dataset has been created and output to file the data contained in the combined dataset is then
	summarised taking the mean of each measurement in the combined dataset grouped by activity and subject.  
	This final dataset consists of 180 observations of 88 vairables.
	  
# Output data
  Two text files will be created containing the 
     ./UCI HAR Dataset/CombinedDataSet.txt 	- merged mean and standard deviation dataset 
     ./UCI HAR Dataset/NewDataSet.txt 			- new summarised dataset
  
  The summarised dataset will also be returned as a data frame when calling the run_analysis function
  

  
# RAW Data Notes 
==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones