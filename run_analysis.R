# this comment from Dave "The Master" Hood  was a necessary guide: 
# https://class.coursera.org/getdata-007/forum/thread?thread_id=49#comment-570

#Read in the Data
activity_labels <- read.table("./activity_labels.txt")
features <- read.table("./features.txt")    

x_train <- read.table("./train/X_train.txt")
x_test <- read.table("./test/X_test.txt")
subject_train <- read.table("./train/subject_train.txt")

y_train <- read.table("./train/y_train.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

# organise matching data
x_bind <- rbind(x_train, x_test)
y_bind <- rbind(y_train, y_test)
subject_bind <- rbind(subject_train, subject_test)

# 4. Appropriately labels the data set with descriptive variable names.
names(x_bind) <- features$V2
names(y_bind) <- "Activity"
names(subject_bind) <- "Subject"

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
x_bind <- x_bind[, grep("mean|std", names(x_bind))]

# 1. Merges the training and the test sets to create one data set.
all_bind <- cbind(x_bind, subject_bind, y_bind)

# 3. Uses descriptive activity names to name the activities in the data set
all_bind$Activity <- as.character(all_bind$Activity)
for(i in 1:10299){
if(grepl("1", all_bind[i, 48]) == TRUE) { 
  all_bind$Activity[i] <- "Walking"
} else if(grepl("2", all_bind[i, 48]) == TRUE) {
  all_bind$Activity[i] <- "Walking Upstairs"
} else if(grepl("3", all_bind[i, 48]) == TRUE) {
  all_bind$Activity[i] <- "Walking Downstairs"
} else if(grepl("4", all_bind[i, 48]) == TRUE) {
  all_bind$Activity[i] <- "Sitting"
} else if(grepl("5", all_bind[i, 48]) == TRUE) {
  all_bind$Activity[i] <- "Standing"
} else 
  all_bind$Activity[i] <- "Laying"
}

## Still to D
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

install.packages("reshape")
library(reshape)

splited <- split(all_bind$Subject, all_bind$Activity)
