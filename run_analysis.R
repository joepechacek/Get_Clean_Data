################################################################################
##           Getting and Cleaning Data - Course Project                       ##
##                                                                            ##
##  The following script contains the R code to read in files from a study    ##
##  that measured the accelerometers and gyro from a Samsung Galaxy S-II for  ##
##  a group of 30 volunteers.  see the README.md file for specifics on using  ##
##  this script.                                                              ##
##                                                                            ##
################################################################################

require(dplyr)
require(tidyr)

##  Begin the load of the various data files needed.
##  These must be in the current working directory.

##  Read in the file with the columnNames so it can be passed to other functions later
columnNames <- read.table("features.txt",
                          sep = " ", 
                          stringsAsFactors = FALSE)[,2]

##  Read in the observed data for each subject in each activity.  Through trial
##  during this process, I found that the column names using the col.names 
##  argument in read.table() resulted in truncated column names that were not 
##  very pretty.  Using the setNames() function resulted in a better outcome.
testData <- read.table("X_test.txt")
testData <- setNames(testData, columnNames)

trainData <- read.table("X_train.txt")
trainData <- setNames(trainData, columnNames)

##  Read in the files with the subject that performed each activity
testSubject <- read.table("subject_test.txt", col.names = "Subject.ID", colClasses = "factor")
trainSubject <- read.table("subject_train.txt", col.names = "Subject.ID", colClasses = "factor")

##  Read in the files that contain the activity performed in each group and combine
##  the masterActivity list to include the 'Activity.Name' variable for each group
masterActivity <- read.table("activity_labels.txt", col.names = c("Activity.ID", "Activity.Name"))
testActivity <- read.table("y_test.txt", col.names = "Activity.ID")
testActivity$Activity.Name <- masterActivity[testActivity[,1], 2]
trainActivity <- read.table("y_train.txt", col.names = "Activity.ID")
trainActivity$Activity.Name <- masterActivity[trainActivity[,1], 2]

##  Combine the data frames for both groups to create a single data frame
##  of all variables and indexes for that group.
testDataAll <- cbind(testSubject, testActivity, testData)[, -2]
trainDataAll <- cbind(trainSubject, trainActivity, trainData)[, -2]

##  rbind the test and training data frames into a single data frame.
allData <- rbind(testDataAll, trainDataAll)

##  Use select() to parse out the columns requested for outcome #1
##  and then cbind them together.  Not very elegant but it works.
allDataSub <- select(allData, Subject.ID:Activity.Name)
allDataMean <- select(allData, contains("mean()"))
allDataStd <- select(allData, contains("std()"))
allData <- cbind(allDataSub, allDataMean, allDataStd)

##  Clean up data frames that are no longer needed
rm(list = c("testSubject", "testActivity", "testData", "testDataAll",
            "trainSubject", "trainActivity", "trainData","trainDataAll", 
            "masterActivity", "columnNames", "allDataSub", "allDataMean",
            "allDataStd"))


##  The second part of the Project Assignment was to create a tidy dataset
##  that contains the average of each variable for each activity and each subject

## To start with, create a data frame tbl to work with
data_dft <- tbl_df(allData)

##  Rather than chain all the functions together, I have created a couple 
##  intermediate steps to better follow the flow of the data transformations.

##  The first step is to gather() the data into a long dataset
data_dft <- gather(data_dft, Measured.Variable, Measured.Value, -(Subject.ID:Activity.Name))

##  Start with group_by to create groups on Activity.Name, Subject.ID and Measured.Variable
grpData <- group_by(data_dft, Subject.ID, Activity.Name, Measured.Variable)

##  Create a summarized dataset with the Mean and SD of the readings
summarizedData <- summarize(grpData, Measured.Value.Average = mean(Measured.Value))

##  Clean up data frames that are no longer needed
rm(list = c("data_dft", "grpData"))

##  Output the final tidy dataset
write.table(summarizedData, "tidyData.txt", row.name = FALSE)
