*Updated: 2015-07-13*

## Purpose

The purpose of the script run_analysis.R is to load and analyze a series of 
files from the University of California - Irvine Machine Learning Repository
dataset Human Activity Recognition Using Smartphones.  The study was conducted
with 30 volunteer participants who wore Samsung Galaxy S-II Smartphones that 
had been set to record the phone accelerometer and gyro readings while the 
subjects performed up to 6 different activities.

The raw data files can be found at the following website:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The downloaded data ZIP file from the website contains more details on the 
specifics of the study and what is included in each of the raw data files.  
For this analysis there are specific files that are needed and they fall into
three general groups.

The first group are common files that describe the Activities performed and the
various readings (Features) that were recorded during the study.

The second and third group of files contain the data measurement labels that
define which subject performed what activity related to each reading recorded.
One dataset is for a training group that comprised 70% or 21 of the Subjects
and the other is a test group that comprised the remainig 30% or 9 Subjects.

Each of the files listed below must be in the current working directory of the 
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

The user of the script does not need to perform any additional preparations to
the data.  DO NOT change the files or filenames as the script will fail
to work otherwise.

## Script Overview

The script will preform 2 basic functions to tranform the data.

The first function is to read in and then format the raw data files into a 
single data frame.  There are 561 individual Features (Smartphone measurements) 
for each Subject/Activity pair in the raw data.  For this analysis we are only 
interested in the Mean and Standard Deviation values included in the data set,
so the full dataset will be filtered to include only those values.  Note that 
there are some Features that include the word "mean" within the name that are 
not values that are being used for this analysis as they do not provide the 
overall mean of the measurements, so special care was taken to exlcude those 
Features that did not fit the criteria.  The final count of Features should be
66 in this case.

The second outcome of the script is to summarize the combined filtered data to
show the Average for each Feature by Subject and Activity.  To perform this in 
a clean and tidy way, the dataset was converted to a long-format with only 4 
variables being used.  See the **codebook** for definitions of the variables 
including the expected values, type and range for each variable.  Once the 
dataset has been transformed and summarized to include the Average for each of 
the Feature/Subject/Activity interations, a final tidy dataset is output as a 
text file named "tidyData.txt" in the current working directory.

To reload the data into R, call the following function with "tidyData.txt" file
in the current working directory.

`summarizedData <- read.table("tidyData.txt", header = TRUE)`
