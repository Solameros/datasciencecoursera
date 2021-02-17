
library(dplyr)

X_train <- data.table::fread(file = "./UCI HAR Dataset/train/X_train.txt")
y_train <- data.table::fread(file = "./UCI HAR Dataset/train/y_train.txt")
subject_train <- data.table::fread(file = "./UCI HAR Dataset/train/subject_train.txt")

X_test <- data.table::fread(file = "./UCI HAR Dataset/test/X_test.txt")
y_test <- data.table::fread(file = "./UCI HAR Dataset/test/y_test.txt")
subject_test <- data.table::fread(file = "./UCI HAR Dataset/test/subject_test.txt")

features <- data.table::fread(file = "./UCI HAR Dataset/features.txt")[,2]
activity_labels <- data.table::fread(file = "./UCI HAR Dataset/activity_labels.txt")

ToLabel <- function(level) {
  if (level == 1) return("WALKING")
  else if (level == 2) return("WALKING_UPSTAIRS")
  else if (level == 3) return("WALKING_DOWNSTAIRS")
  else if (level == 4) return("SITTING")
  else if (level == 5) return("STANDING")
  else return("LAYING")
  
}

#Merges the training and the test sets to create one data set.
data <- rbind(X_train, X_test)

#Appropriately labels the data set with descriptive variable names.
names(data) <- as.character(unlist(features))

#Extracts only the measurements on the mean and standard deviation for each measurement. 
keeps <- c("mean", "Mean", "std")
mean_sd <- as.logical(sapply(colnames(data),grepl,pattern = paste(keeps,collapse = "|")))
data <- data[,mean_sd, with = FALSE]

#Uses descriptive activity names to name the activities in the data set.
data_y <- rbind(y_train, y_test)
data <- cbind(data_y, data)
data[,1] <- sapply(unlist(data[,1]), ToLabel)
colnames(data)[1] <- "Activity"


subject_id <- rbind(subject_train,subject_test)
colnames(subject_id) <- "Subject_id"
data <- cbind(subject_id, data)

#From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
AverageData <- data %>% group_by(Subject_id, Activity) %>% summarise_all(funs(mean))
