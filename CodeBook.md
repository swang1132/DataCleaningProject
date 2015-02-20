##CodeBook
This is a code book that describes the **variables**, the **dataset**, and **steps** to take for cleaning up the dataset for the further analysis.

# The source of Dataset

- Original data: [Human Activity Recognition Using Smartphones Data Set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- Original description of the dataset: [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Dataset Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

# The Contents of the Dataset

The dataset includes the following files:

1. 'README.txt'
1. 'features_info.txt': Shows information about the variables used on the feature vector.
1. 'features.txt': List of all features.
1. 'activity_labels.txt': Links the class labels with their activity name.
1. 'train/X_train.txt': Training set.
1. 'train/y_train.txt': Training labels.
1. 'test/X_test.txt': Test set.
1. 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

# Steps to clean up the Dataset

Through the following five steps, the dataset could be cleaned up for the further data analysis. 

1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement.
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive activity names.
1. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# How to run_analysis.R

User needs to setup the workspace before execute **run_analysis.R**. The script will execute the following steps to clean up the dataset. Note: To keep the data integrity, the download step needs also be scripted.

- Download and unzip the dataset to the selected subdirectory.
- Load both Train and Tes dataset.
- Load the features and activity labels.
- Extract the mean and standard deviation column names and data.
- Process each dataset attached proper activity labels and feature description.
- Merge both datasets into one final dataset.