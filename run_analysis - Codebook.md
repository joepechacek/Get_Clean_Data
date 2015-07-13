*Updated: 2015-07-13*

## Project 1 - Codebook

### Overview

Following is the codebook that defines the variables and acceptable values
for the output file "tidyData.txt" that was produced with the run_analysis.R
script.  For more information on the raw data source, see the README.md file.

In preparation for sourcing the run_analysis.R script, the following items should
be completed to ensure the raw data files have been prepared for the script.

Each of the following files must be in the current working directory of the 
R session for the script to locate and use the data files.  If you are not sure
what the current working directory is, call `getwd()` from the R prompt `>`.

- features.txt
- activity_labels.txt
- X_train.txt
- y_train.txt
- subject_train.txt
- X_test.txt
- y_test.txt
- subject_test.txt

The user of the script does not need to perform any additional actions with 
the data.  DO NOT change the file names or content of the files.

### Dataset Variables

The output dataset "tidyData.txt" consists of four variables as defined below:

**Subject.ID:**

ID number for each of the study participants

- integer: 1 - 30    


**Activity.Name:**

Defines the type of activity performed

factor: 6 levels

- LAYING
- SITTING
- STANDING
- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS

**Measured.Variable:**

Defines the type of measurement from the Smartphone accelerometer or gyro.
                                        
factor: 66 levels

Each Measured.Variable is composed of 4 parts that describe the measurement made

- *t* or *f* : t = time domain measurement; f = frequency domain measurement
- *reading* : The name of the accelerometer or gyro reading from the Smartphone
- *-mean()* or *-std()* : Mean or Standard Deviation of values for specified *reading* in the dataset
- *-XYZ* : Label to define the X, Y, or Z axis of measurement if applicable

tBodyAcc-mean()-X

tBodyAcc-mean()-Y

tBodyAcc-mean()-Z

tGravityAcc-mean()-X

tGravityAcc-mean()-Y

tGravityAcc-mean()-Z

tBodyAccJerk-mean()-X

tBodyAccJerk-mean()-Y

tBodyAccJerk-mean()-Z

tBodyGyro-mean()-X

tBodyGyro-mean()-Y

tBodyGyro-mean()-Z

tBodyGyroJerk-mean()-X

tBodyGyroJerk-mean()-Y

tBodyGyroJerk-mean()-Z

tBodyAccMag-mean()

tGravityAccMag-mean()

tBodyAccJerkMag-mean()

tBodyGyroMag-mean()

tBodyGyroJerkMag-mean()

fBodyAcc-mean()-X

fBodyAcc-mean()-Y

fBodyAcc-mean()-Z

fBodyAccJerk-mean()-X

fBodyAccJerk-mean()-Y

fBodyAccJerk-mean()-Z

fBodyGyro-mean()-X

fBodyGyro-mean()-Y

fBodyGyro-mean()-Z

fBodyAccMag-mean()

fBodyBodyAccJerkMag-mean()

fBodyBodyGyroMag-mean()

fBodyBodyGyroJerkMag-mean()

tBodyAcc-std()-X

tBodyAcc-std()-Y

tBodyAcc-std()-Z

tGravityAcc-std()-X

tGravityAcc-std()-Y

tGravityAcc-std()-Z

tBodyAccJerk-std()-X

tBodyAccJerk-std()-Y

tBodyAccJerk-std()-Z

tBodyGyro-std()-X

tBodyGyro-std()-Y

tBodyGyro-std()-Z

tBodyGyroJerk-std()-X

tBodyGyroJerk-std()-Y

tBodyGyroJerk-std()-Z

tBodyAccMag-std()

tGravityAccMag-std()

tBodyAccJerkMag-std()

tBodyGyroMag-std()

tBodyGyroJerkMag-std()

fBodyAcc-std()-X

fBodyAcc-std()-Y

fBodyAcc-std()-Z

fBodyAccJerk-std()-X

fBodyAccJerk-std()-Y

fBodyAccJerk-std()-Z

fBodyGyro-std()-X

fBodyGyro-std()-Y

fBodyGyro-std()-Z

fBodyAccMag-std()

fBodyBodyAccJerkMag-std()

fBodyBodyGyroMag-std()

fBodyBodyGyroJerkMag-std()


**Measured.Value.Average:**

Average value for the Subject/Activity/Measurement sets

- number:
