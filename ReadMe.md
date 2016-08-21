## Getting and cleaning data assignement - Read me

This repo contains solution of a Coursera's Getting and cleaning data assignement.

### About the script

The script is assuming the required file was downloaded and unzipped, not changed.

1. It merges the training and the test sets to create one data set
* Reads test data
* Labels the data set with descriptive variable names
* Reads subject test data
* Reads activity test data
* Combines subject, activity and test data into one data frame
* Reads train data
* Again labels the data set with variable names
* Reads subject train data
* Reads activity train data
* Combines subject, activity and train data into one data frame
* Combines the test and train data

2. Extracts only the measurements on the mean and standard deviation for each measurement
* Changes data frame from previous step to have only first and second columns 
and columns which names contains "mean" or "std" from original data frame

3. Uses descriptive s to name the activities in the data set
* Reads in the activity labels
* Assigns activity labels to activity number
* Rearanges the columns so the subject column is first, activity_labels is second, 
activity number is dropped, all the rest columns stay untouched

4. Appropriately labels the data set with descriptive variable names.
* Removes dashes, paretheses, commas from the column names to make them more tidy
* Replaces mean and std with capital letter for better readability

5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
variable for each activity and each subject.
* Aggregates the input data by subject and activity and calculates mean for selected columns
* Writes final data frame to a text file in working directory





