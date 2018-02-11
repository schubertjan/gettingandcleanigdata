require(dplyr)

### download the data and unzip the files ###
#create folder Data_science > Getting_data > assigment in the default working directory 
setwd("~/Data_Science/Getting_data/assignment")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,"data.zip", mode = "wb")
unzip("data.zip")

### read the labels ###
filePath <- "~/Data_Science/Getting_data/assignment/UCI HAR Dataset/"; features <- read.csv(paste0(filePath,"features.txt"), sep = " ", header = F)
filePath <- "~/Data_Science/Getting_data/assignment/UCI HAR Dataset/"; activLabel <- read.table(paste0(filePath,"activity_labels.txt"), sep = " ", header = F)


### read the test data ###
#read the measurement test data and the measurement names  
filePath <- "~/Data_Science/Getting_data/assignment/UCI HAR Dataset/test/"; Xtest <- read.table(paste0(filePath,"X_test.txt"))
Xtest <- setNames(Xtest,features[,2]) #assign measurement names
#read the activity test data
filePath <- "~/Data_Science/Getting_data/assignment/UCI HAR Dataset/test/"; Ytest <- read.table(paste0(filePath,"y_test.txt"))
Ytest <- setNames(Ytest,"activityname") #rename the column to activename
#read the subject data for test
filePath <- "~/Data_Science/Getting_data/assignment/UCI HAR Dataset/test/"; subjectTest <- read.table(paste0(filePath,"subject_test.txt"))
subjectTest <- setNames(subjectTest,"subject") #rename the column to subjecttest
#merge the test measurement, activity data and sublect data.
test <- cbind(subjectTest, Ytest, Xtest)

### merge training data ###
#read the measurement traning data
filePath <- "~/Data_Science/Getting_data/assignment/UCI HAR Dataset/train/"; Xtrain <- read.table(paste0(filePath,"X_train.txt"))
Xtrain <- setNames(Xtrain,features[,2]) #assign measurement names
#read the activity test data
filePath <- "~/Data_Science/Getting_data/assignment/UCI HAR Dataset/train/"; Ytrain <- read.table(paste0(filePath,"y_train.txt"))
Ytrain <- setNames(Ytrain,"activityname") #rename the column to activename
#read the subject data for test
filePath <- "~/Data_Science/Getting_data/assignment/UCI HAR Dataset/train/"; subjectTrain <- read.table(paste0(filePath,"subject_train.txt"))
subjectTrain <- setNames(subjectTrain,"subject") #rename the column to subjecttest
#merge the train measurement, activity data and sublect data.
train <- cbind(subjectTrain, Ytrain, Xtrain)

### merge test and train data ###
mergeData <- rbind(test,train)
rm(list = c("test","train","Xtest","Xtrain")) #remove original measurement data files

### extract only measurements on mean and standard deviation ###
valid_column_names <- make.names(names=names(mergeData), unique=TRUE, allow_ = TRUE) #remove invalid characters
names(mergeData) <- valid_column_names #assign new valid names
avgsdData <- mergeData %>% 
          select(subject, activityname, contains(".mean.."), 
          contains(".std..")) #select variables that contain mean and std 

###use descriptive activity names ###
avgsdData <- mutate(avgsdData,
                activityname = ifelse(activityname == 1,"Walking",activityname),
                activityname = ifelse(activityname == 2,"Walking_upstairs",activityname),
                activityname = ifelse(activityname == 3,"Walking_downstairs",activityname),
                activityname = ifelse(activityname == 4,"Sitting",activityname),
                activityname = ifelse(activityname == 5,"Standing",activityname),
                activityname = ifelse(activityname == 6,"Laying",activityname))

avgsdData$activityname <- as.factor(avgsdData$activityname) #make a factor

### Appropriately labels the data set with descriptive variable names ###
n <- names(avgsdData)
n <- sub("^t","time",n); n <- sub("^f","freq",n); n <- sub("Acc","accelerometer",n); n <- sub("gyro","gyroscope",n)
n <- sub(".","_",n, fixed = T);n <- sub("..","",n, fixed = T);n <- sub(".","",n, fixed = T)
n <- tolower(n)
avgsdData <- setNames(avgsdData,n)

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ###
output <- avgsdData %>%
  group_by(subject,activityname) %>%
  summarize_each(funs(mean))

write.csv(output,"Output.csv", row.names = F)