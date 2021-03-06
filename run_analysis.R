require(plyr)

##
## Section 1 - Preprocessing the datasets 
##

## It is very crucial to script the steps of downloading and of unzipping data sets
if(!file.exists("./dataset")) {
        dir.create("./dataset")        
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, dest="./dataset/Dataset.zip")
unzip(zipfile="./dataset/Dataset.zip", exdir="./dataset")

## List all files in the dataset directory
dataPath <- file.path("./dataset", "UCI HAR Dataset")
allfiles <- list.files(dataPath, recursive=TRUE)
allfiles

##
## Loading data, activity, and subject to both Train and Test datasets
##

## Set 1 - Train Dataset
trainData <- read.table(file.path(dataPath, "train", "X_train.txt"), header = FALSE)
trainActivity <- read.table(file.path(dataPath, "train", "y_train.txt"), header = FALSE)
trainSubject <- read.table(file.path(dataPath, "train", "subject_train.txt"), header = FALSE)
        
## Set 2 - Test Dataset
testData <- read.table(file.path(dataPath, "test", "X_test.txt"), header = FALSE)
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"), header = FALSE)
testSubject <- read.table(file.path(dataPath, "test", "subject_test.txt"), header = FALSE)

## Loading other required files - features and activity 
features <- read.table(file.path(dataPath, "features.txt"), colClasses = c("character"))
activityLabels <- read.table(file.path(dataPath, "activity_labels.txt"), col.names = c("ActivityId", "Activity"))

##
## Section 2 - Project Requirement
##

# Step 1 - Binding Train dataset and Test dataset and setting proper column headers
trainSet <- cbind(cbind(trainData, trainSubject), trainActivity)
testSet <- cbind(cbind(testData, testSubject), testActivity)
wholeSet <- rbind(trainSet, testSet)
setlabels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(wholeSet) <- setlabels


## Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
meanStdSet <- wholeSet[,grepl("mean|std|Subject|ActivityId", names(wholeSet))]

## Step 3 - Uses descriptive activity names to name the activities in the data set
meanStdSet <- join(meanStdSet, activityLabels, by = "ActivityId", match = "first")
meanStdSet <- meanStdSet[,-1]

# Step 4 - Appropriately labels the data set with descriptive names.

# Remove parentheses
names(meanStdSet) <- gsub('\\(|\\)',"",names(meanStdSet), perl = TRUE)
# Make syntactically valid names
names(meanStdSet) <- make.names(names(meanStdSet))
# Make clearer names
names(meanStdSet) <- gsub('Acc',"Acceleration",names(meanStdSet))
names(meanStdSet) <- gsub('GyroJerk',"AngularAcceleration",names(meanStdSet))
names(meanStdSet) <- gsub('Gyro',"AngularSpeed",names(meanStdSet))
names(meanStdSet) <- gsub('Mag',"Magnitude",names(meanStdSet))
names(meanStdSet) <- gsub('^t',"TimeDomain.",names(meanStdSet))
names(meanStdSet) <- gsub('^f',"FrequencyDomain.",names(meanStdSet))
names(meanStdSet) <- gsub('\\.mean',".Mean",names(meanStdSet))
names(meanStdSet) <- gsub('\\.std',".StandardDeviation",names(meanStdSet))
names(meanStdSet) <- gsub('Freq\\.',"Frequency.",names(meanStdSet))
names(meanStdSet) <- gsub('Freq$',"Frequency",names(meanStdSet))

## Step 5 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyMeanSet = ddply(meanStdSet, c("Subject","Activity"), numcolwise(mean))
write.table(tidyMeanSet, file = file.path(dataPath, "tidydata.txt"))

