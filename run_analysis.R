
### 0 Downloads the required data and unzip the files
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Dataset.zip")
#unzip("Dataset.zip")
#unlink("Dataset.zip") ## delete unneeded file to save disk space
###



## 1 Merges the training and the test sets to create one data set.

# reads test data
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)

# labels the data set with descriptive variable names
colnames(test_data) <- features[,2]

# reads subject test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
colnames(subject_test) <- "subject"

# reads activity test data
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
colnames(activity_test) <- "activity"

# combine subject, activity and test data into one data frame
test <- cbind(subject_test, activity_test)
test <- cbind(test, test_data)

# reads train data
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)

# again labels the data set with variable names
colnames(train_data) <- features[,2]

# reads subject train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
colnames(subject_train) <- "subject"

# reads activity train data
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
colnames(activity_train) <- "activity"

# combine subject, activity and train data into one data frame
train <- cbind(subject_train, activity_train)
train <- cbind(train, train_data)


# combine the test and train data
all <- rbind(test, train)


## 2 Extracts only the measurements on the mean and standard deviation for each measurement.

# Changes 'all' data frame to have only first and second columns 
# and columns which names contains "mean" or "std" from original data frame

all <- all[ , c(1,2,grep("mean|std", colnames(all)))] 
	

## 3 Uses descriptive s to name the activities in the data set

# reads in the activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
colnames(activity_labels) <- c("activity","activity_name")

# assigns activity labels to activity number
all <- merge(all, activity_labels, by.x="activity", by.y="activity", sort=FALSE)

# rearange the columns so the subject column is first, activity_labels is second, 
# activity (number) is dropped, all the rest stays untouched
all <- all[,c(2,82,3:81)]


## 4 Appropriately labels the data set with descriptive variable names.

# removes dashes, paretheses, commas from the column names to make them more tidy
names(all) <- gsub("[-()//,]" , "" , names(all))

# replace mean and std with capital letter for better readability
names(all) <- gsub("mean" , "Mean" , names(all))
names(all) <- gsub("std" , "Std" , names(all))

## 5 From the data set in step 4, creates a second, independent tidy data set with the average of each 
## variable for each activity and each subject.

# aggregates the input data by subject and activity and calculates mean for selected
# columns
final <- aggregate(all[,c(3:81)], by=list(subject=all[,1], activity=all[,2]), mean)


# writes final data frame to a text file in working directory
write.table(final, "final.txt", row.names=FALSE)

######

### Code to be used to read in the "final.txt" file
#data <-read.table("final.txt", header=TRUE)
#View(data)
#
# Read in code taken from: 
# https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
###
