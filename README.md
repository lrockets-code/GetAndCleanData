# GetAndCleanData
This is the repository for the final exam of the Course 3
+ I start with the test data....
+ I am reading files as data frames
+ Then I am filtering data only for std or mean for the 3 axis 
+ I have at the end a test data with cols..(subject,Activity_ID,Activity_Label and the data filtered for std|mean)
+ Then I do the same for train data
+ Join all togheter test+ train
+ Finally.......
+ Using melt function I have id vars and data vars. id are subject,Activity_ID and Activity_Label

+ Then I calc the mean with the dcast function by subject and by Activity on the vars defined in the melt function

## Result is stored in a file.txt
