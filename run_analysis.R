library(dplyr)

# Gather required data

if (!file.exists("data")) {
  dir.create("data")
}

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "data/dataset.zip",
              method = "curl")

unzip("data/dataset.zip", exdir = "data/", overwrite = T)

# Read train and test data

subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")

# Read features and activity labels

features <- read.table("data/UCI HAR Dataset/features.txt")[,2]
activityLabels <- read.table("data/UCI HAR Dataset/activity_labels.txt")[,2]

# Merge test and train data

x_total <- rbind(x_train, x_test)
y_total <- rbind(y_train, y_test)
subject_total <- rbind(subject_train, subject_test)

selected_var <- grep("mean\\(\\)|std\\(\\)", features)
x_total <- x_total[, selected_var]
colnames(x_total) <- features[selected_var]

colnames(y_total) <- "activity"
y_total$activitylabel <- factor(y_total$activity, labels = as.character(activityLabels))
activitylabel <- y_total[, -1]
# Make tidy dataset

colnames(subject_total) <- "subject"
total <- cbind(x_total, activitylabel, subject_total)
mean_total <- total %>% 
  group_by(activitylabel, subject) %>% summarize_each(list(mean = mean))

# Write out dataset

write.table(mean_total, 
            file = "tidydataset.txt")

