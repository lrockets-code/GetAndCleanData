##Merges the training and the test sets to create one data set.

##Extracts only the measurements on the mean and standard deviation for each measurement. 

##Uses descriptive activity names to name the activities in the data set

##Appropriately labels the data set with descriptive variable names. 

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Load: activity labels as coloumn 2 of data set
activity_labels <- read.table("D:\\TEST_DSToolBox\\datasciencecoursera\\Course3-FinalTest\\UCI HAR Dataset\\activity_labels.txt")[,2]

# Load: data column names coloumn 2 of data set
features <- read.table("D:\\TEST_DSToolBox\\datasciencecoursera\\Course3-FinalTest\\UCI HAR Dataset\\features.txt")[,2]

# Using grep to extract the features requested
requested_features <- grepl("mean|std", features)

# Load and process X_test & y_test data.
X_test <- read.table("D:\\TEST_DSToolBox\\datasciencecoursera\\Course3-FinalTest\\UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table("D:\\TEST_DSToolBox\\datasciencecoursera\\Course3-FinalTest\\UCI HAR Dataset\\test\\y_test.txt")
subject_test <- read.table("D:\\TEST_DSToolBox\\datasciencecoursera\\Course3-FinalTest\\UCI HAR Dataset\\test\\subject_test.txt")

names(X_test) = features

# Take out only requested columns
X_test = X_test[,requested_features]

# Add activity labels on y_test as a second column using y_test values as rows for activity label
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data all togheter as columns
test_data <- cbind(subject_test, y_test, X_test)

# Same for training data
X_train <- read.table("D:\\TEST_DSToolBox\\datasciencecoursera\\Course3-FinalTest\\UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table("D:\\TEST_DSToolBox\\datasciencecoursera\\Course3-FinalTest\\UCI HAR Dataset\\train\\y_train.txt")

subject_train <- read.table("D:\\TEST_DSToolBox\\datasciencecoursera\\Course3-FinalTest\\UCI HAR Dataset\\train\\subject_train.txt")

names(X_train) = features

X_train = X_train[,requested_features]


y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

train_data <- cbind(subject_train, y_train, X_train)

# Test  and Train now toghether
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_df      = melt(data, id = id_labels, measure.vars = data_labels)

# Apply mean function to dataset using dcast function. Averaging on subject and on Activity Label
tidy_df   = dcast(melt_df, subject + Activity_Label ~ variable, mean)

write.table(tidy_df, file = "./tidy_file.txt")