# This program has been written for the programming assignment of the 'Getting Data' 
# coursera course.
# The purpose is to take two input datasets and merge them to form third dataset 
# (CombinedDataSet.txt) containing only the measurement values for mean and standard 
#  deviation for each measurement.  
# 
# A fourth dataset (NewDataSet.txt) is then created containing tidy data set with 
# the average of each variable for each activity and each subject.
# 
# for more information on the structure of the input and output datasets please see the
# README.md and Codebook.txt files in the following github repo
#  https://github.com/Holt789/ProgramAssignment4
#
# input data
# The program will check for the existence of the following source data directory
# ./UCI HAR Dataset if the directory is there it will assume the data is present and proceed
# if the directory is not present it will download the required data and then proceed.
# 
# Output data
#   two text files will be created containing the 
#     ./UCI HAR Dataset/CombinedDataSet.txt - merged mean and standard deviation dataset 
#     ./UCI HAR Dataset/NewDataSet.txt - new summarised dataset
# The summarised dataset will also be returned as a data frame when calling the 
# run_analysis function
#
# The input datasets consist of 6 files files
#  The 1st is the training dataset 
#   X_train.txt - This contains the activity readings with a value from 1 - 6
#   y_train.txt - 
#   subject_train.txt - 

#  The 2nd input dataset is the test data set.  This also consists of three input files
#  X_test.txt
#  y_test.txt
#  subject_test.txt

run_analysis <- function() {
  dataDir <- "./UCI HAR Dataset"
  tmpDF <- data.frame()
  
  # check to see if source data exists, if not download
  if (!file.exists(dataDir)){
    URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(URL, destfile = "./XFoo.zip")
    unzip ("./XFoo.zip", exdir = ".")
  }
  
  if (file.exists(dataDir)){
    require(plyr)
    library(plyr)

    # Features File
    features <- read.table("./UCI HAR Dataset/features.txt")
  
    # Get and transform the TRAINING Dataset
    trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")		# trainX contains the activity readings
  
    # create a new dataframe that is a subset of columns where feature name contains either std or mean
    trainX <- trainX[,features[grepl("mean|std",tolower(features$V2)),1]]
  
    # Assign correct column names to trainZ from the features tables removing ( ) and , characters
    colnames(trainX) <- gsub(",|-",".",gsub("\\(|\\)","",features[grepl("mean|std",tolower(features$V2)),2]))
  
    trainY <- read.table("./UCI HAR Dataset/train/y_train.txt")
    # trainY this contains the test number corresponding to the 6 activities so assign the label
    # Add identifying column as to the dataset
    trainY <- cbind(trainY, c('train'))
    names(trainY)[1]<-paste("activity")
    names(trainY)[2]<-paste("dataset")
  
    # trainSub contains the 30 corresponding participants
    trainSub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    names(trainSub)[1]<-paste("subject")
  
    # Add the trainsub and train y dataframes together into a temporary dataframe
    trainTmp <- cbind(trainSub, trainY)
  
    # Add the temporary dataframe to the trainX
    trainTmp <- cbind(trainTmp, trainX)
  
    # TEST Dataset 
    # testX contains the activity readings
    testX <- read.table("./UCI HAR Dataset/test/X_test.txt")
    testX <- testX[,features[grepl("mean|std",tolower(features$V2)),1]]
  
    colnames(testX) <- gsub(",|-",".",gsub("\\(|\\)","",features[grepl("mean|std",tolower(features$V2)),2]))
  
    testY <- read.table("./UCI HAR Dataset/test/y_test.txt")						 
    # testY this contains the test number corresponding to the 6 activities so assign the label
    # Add identifying column as to the dataset
    testY <- cbind(testY, c('test'))
    names(testY)[1]<-paste("activity")
    names(testY)[2]<-paste("dataset")
  
    # testSub contains the 30 corresponding participants
    testSub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    names(testSub)[1]<-paste("subject")
  
    # Add the testsub and test y dataframes together into a temporary dataframe
    testTmp <- cbind(testSub, testY)
  
    # Add the temporary dataframe to the testX
    testTmp <- cbind(testTmp, testX)
  
    # Create the combined dataset
    combinedDS <- rbind(trainTmp,testTmp)
  
    # Save the combined dataset to file
    #write.csv(combinedDS, file = "./UCI HAR Dataset/CombinedDataSet.csv")
    write.table(combinedDS, file = "./UCI HAR Dataset/CombinedDataSet.txt", row.name=FALSE)
  
    # Define get.means function to calculate means for new dataset group by subject  
    get.means <- function(df, count.column) { 
      ddply(df, .(subject,activity), function(d) mean(d[[count.column]]))
    }
  
    # Get all columns apart from subject, activity and dataset
    getAvgsFor <- names(combinedDS) 
    getAvgsFor <- getAvgsFor[!grepl("subject|activity|dataset", names(combinedDS))]
  
    # For each measurement calculate the average value per subject
    for (i in 1:length(getAvgsFor)) {
      tmpColumn <- get.means(combinedDS, getAvgsFor[i])
    
      # Build new dataset data frame
      if (i > 1) {
        tmpDF <- cbind(tmpDF, tmpColumn[,3])
        names(tmpDF)[i+2]<-paste(getAvgsFor[i])
      }
      else {
        tmpDF <- tmpColumn
        names(tmpDF)[3]<-paste(getAvgsFor[i])
      }
    }
  
    # write new dataset out to file NewDataSet.csv
    #write.csv(tmpDF, file = "./UCI HAR Dataset/NewDataSet.csv")
    
    write.table(tmpDF, file = "./UCI HAR Dataset/NewDataSet.txt", row.name=FALSE)
  }
  tmpDF
}