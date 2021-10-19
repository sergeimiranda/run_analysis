#Script for merging and accommodate test/training data from cellphone accelerometer

library(dplyr)
#Reads feature information and activity labels
#Place Samsung data in folder: UCI-HAR-Dataset
        #VariableFeature: table of labels for every variable used
        VariableFeature <- read.table("./UCI-HAR-Dataset/features.txt")
        #ActivityLabels: Table of activity labels used
        ActivityLabels <- read.table("./UCI-HAR-Dataset/activity_labels.txt")
        
#Reads test data, stores in Data frame
        #TestSubject: Vector of volunteer performing the experiment
        TestSubject <- read.table("./UCI-HAR-Dataset/test/subject_test.txt")
        #TestSet: Dataframe of experiments. Columns are variable features
        TestSet <- read.table("./UCI-HAR-Dataset/test/x_test.txt")
        #TestActivityLabel: Corresponding activity label
        TestActivityLabel <- read.table("./UCI-HAR-Dataset/test/y_test.txt")
        
#Reads train data, stores in Data frame
        #TrainSubject: Vector of volunteer performing the experiment
        TrainSubject <- read.table("./UCI-HAR-Dataset/train/subject_train.txt")
        #TrainSet: Dataframe of experiments. Columns are variable features
        TrainSet <- read.table("./UCI-HAR-Dataset/train/x_train.txt")
        #TrainActivityLabel: Corresponding activity label
        TrainActivityLabel <- read.table("./UCI-HAR-Dataset/train/y_train.txt")
        
#Data rearrangement
        #Fixing of spurious characters
        VariableFeature[,2] <- gsub("()","",VariableFeature[,2],fixed = TRUE)
        VariableFeature[,2] <- gsub(",","_",VariableFeature[,2],fixed = TRUE)
        VariableFeature[,2] <- gsub("-","_",VariableFeature[,2],fixed = TRUE)
        
        #Renaming columns actual variables names
        colnames(TrainSet) <- VariableFeature[,2]
        colnames(TestSet) <- VariableFeature[,2]
        
        #Replacement of Activity ID with actual activity name
        TestActivityLabel[,1]<- ActivityLabels[TestActivityLabel[,1],2]
        TrainActivityLabel[,1]<- ActivityLabels[TrainActivityLabel[,1],2]
        
        #Adding Activity columns
        TestSet$Activity <- TestActivityLabel
        TrainSet$Activity <- TrainActivityLabel
        
        #Adding Subject Colums
        TestSet$Subject <- TestSubject
        TrainSet$Subject <- TrainSubject
        
        #Merging Test and Train
        FullSet <- bind_rows(TestSet,TrainSet)
        
        #Filter dataset by mean and standard deviation variables
        FullSet <- select(FullSet, contains("mean"), contains("std"),
                          contains("Subject"), contains("Activity"))
        
        #Grouping Vectors
        variablesnames <- names(select(FullSet, !c(Subject, Activity)))
        FullSet_Average <- FullSet %>% group_by(Subject,Activity) %>% 
                summarise(across(everything()))
        
        write.table(apply(FullSet_Average,2,as.character),"./Tidy_Averaged.txt"
                    , row.names=FALSE)
