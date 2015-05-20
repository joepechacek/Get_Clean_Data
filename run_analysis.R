################################################################################
##           Getting and Cleaning Data - Course Project                       ##
##                                                                            ##
##  The following script contains the R code to read in files from a study    ##
##  that measured the accelerometers and gyro from a Samsung Galaxy S II for  ##
##  a group of 30 volunteers.                                                 ##
##                                                                            ##
##  The purpose of this script is to perform two separate outcomes:           ##
##  1) The first outcome is to convert raw data files from the study into a   ##
##     merged dataset with all observations from two groups - a test group    ##
##     and a training group.  Each group has 3 groups of files that must be   ##
##     combined to provide the indexes needed to identify the subject in each ##
##     group and the activity they performed during each measurement taken.   ##
##     After the files needed to 'rebuild' the data are completed, the two    ##
##     groups can be combined into a single dataset.  This combined data will ##
##     then be filtered to only contain the mean and standard deviation       ## 
##     values for each measurement made in the study.                         ##
##  2) The second outcome is to create a tidy dataset that will contain the   ##
##     average value for each variable for each activity for each subject.    ##
##     Note that each subject did not perform all of the activities listed.   ##
##                                                                            ##
################################################################################

require(dplyr)
require(tidyr)

##  Beign the load of the various data files needed.
##  These must be in the current working directory.

##  Read in the file with the columnNames so it can be passed to other functions later
columnNames <- read.table("features.txt",
                          sep = " ", 
                          stringsAsFactors = FALSE)[,2]

##  Read in the observed data for each subject in each activity
testData <- read.table("X_test.txt", col.names = columnNames)
trainData <- read.table("X_train.txt", col.names = columnNames)

##  Read in the files with the subject that performed each activity
testSubject <- read.table("subject_test.txt", col.names = "Subject.ID", colClasses = "factor")
trainSubject <- read.table("subject_train.txt", col.names = "Subject.ID", colClasses = "factor")

##  Read in the files that contain the activity performed in each group and merge
##  to add the 'Activity.Name' variable for each group
masterActivity <- read.table("activity_labels.txt", col.names = c("Activity.ID", "Activity.Name"))
testActivity <- merge(read.table("y_test.txt", col.names = "Activity.ID"), masterActivity)
trainActivity <- merge(read.table("y_train.txt", col.names = "Activity.ID"), masterActivity)

##  Combine the data frames for both groups to create a single data frame
##  of all variables and indexes for that group.
testDataAll <- cbind(testSubject, testActivity, testData)[, -2]
trainDataAll <- cbind(trainSubject, trainActivity, trainData)[, -2]

##  Merge the test and training data frames into a single data frame.
allData <- rbind(testDataAll, trainDataAll)

##  Use select() to parse out the columns requested for outcome #1
##  and then cbind them together.  Not very elegant but it works.
allDataSub <- select(allData, Subject.ID:Activity.Name)
allDataMean <- select(allData, contains(".mean."))
allDataStd <- select(allData, contains(".std."))
allData <- cbind(allDataSub, allDataMean, allDataStd)

##  Clean up data frames that are no longer needed
rm(list = c("testSubject", "testActivity", "testData", "testDataAll",
            "trainSubject", "trainActivity", "trainData","trainDataAll", 
            "masterActivity", "columnNames", "allDataMean", "allDataStd"))


##  The second part of the Project Assignment was to create a tidy dataset
##  that contains the average of each variable for each activity and each subject

## To start with, create a data frame tbl to work with
data_dft <- tbl_df(allData)

##  Rather than chain all the functions together, I have created a couple 
##  intermediate steps to better follow the flow of the data transformations.

##  The first step is to gather() the data into a tall-skinney dataset
data_dft <- gather(data_dft, Measured.Variable, Measured.Value, -(Subject.ID:Activity.Name))

##  Start with group_by to create groups on Activity.Name and Subject.ID
grpData <- group_by(data_dft, Subject.ID, Activity.Name, Measured.Variable)

##  Create a summarized dataset with the Mean and SD of the selected columns
summarizedData <- summarize(grpData, Measured.Value.Average = mean(Measured.Value))

##  Clean up data frames that are no longer needed
rm(list = c("allDataSub", "data_dft", "grpData"))

##  Output the final tidy dataset
write.table(summarizedData, "tidyData.txt", row.name = FALSE)

