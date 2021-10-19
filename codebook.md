DATA BOOK
Getting and Cleaning Data - Course Project

SCRIPT
File:  run_analysis.r

Description
R Script to accommodate and analyze data from a Samsung wearable device. Data collected from the UCI Machine Learning Repository, data set: Human Recognition Using Smartphones Data Set.

The script executes the following:

-Reads feature variables and converts them to a data frame

-Read activity labels and converts them to a data frame

-Read both test and train activities, including activity and subject id for each case.  Converts them to data frames

-Fixes spurious characters on the variable names and includes them as variable columns for each set (train and test)

-Replaces the corresponding activity id with the actual activity name (ie: walking)

-Merges all the data set as one full set

-Using the previous a data set containing only the mean and standard deviation variables is created.  This one is analyzed and the mean value for each variable is created for every subject and activity. 

-The resulting data frame is written in a file called Tidy_Averaged.txt. The data frame is structured in the following manner (columns):

	Subject       Activity     ……    Measured Variables (mean values)
	
     .
     . 
     . 
     
    rows
