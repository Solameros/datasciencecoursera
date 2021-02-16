
## Code Book

The run_analysis.R script performs the data preparation for further analysis later.

Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

Assign each data to variables
features <- features.txt : 561 obs
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activity_labels <- activity_labels.txt : 6 obs
List of activities performed when the corresponding measurements were taken and its codes (labels)
subject_test <- test/subject_test.txt : 2947 obs
contains test data of 30 volunteer test subjects being observed
x_test <- test/X_test.txt : 2947 obs
contains recorded features test data
y_test <- test/y_test.txt : 2947 obs
contains test data of activity labels
subject_train <- test/subject_train.txt : 7352 obs
contains train data of 30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 obs
contains recorded features train data
y_train <- test/y_train.txt : 7352 obs
contains train data of activities’code labels

Merges the training and the test sets to create one data set
data_y (10299 obs) is created by merging y_train and y_test using rbind() function
mean_sd (1 row, 561 columns) is a logical vector that shows whether "mean", "Mean" or "std" string can be found in column name
Subject_id (10299 obs, 1 variable) is created by merging subject_train and subject_test using rbind() function
data (10299 obs, 88 variables)is created by merging x_train, x_test, data_y and Subject_id using rbind() and cbind() functions


Extracts only the measurements on the mean and standard deviation for each measurement
using mean_sd to filter data to extract only mean and standard deviation data

Uses descriptive activity names to name the activities in the data set
The second column of the data is filled with corresponding activity taken from activity_labels variable

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
AverageData (180 obs, 88 variables) is created by sumarizing data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
