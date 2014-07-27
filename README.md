CGCD_Project
============
## Content
This porject contains 3 files
- Readme.md this file
- CodeBook.md describing the data in the tidyDataset
- run_analysis.R an R script preparing the data

 
## Process
run_analysis.R first sets working directory and loads used libraries.
Data comes from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip [1].
Data is loaded as needed according to the questions, starting with test and then training.
We every time use dim, head and tail to validate proper import
using grepl we extract mean and std data from the loaded data
we load the activity description and subsequently the y-axis and factor them according to the activities
subsequently we label the columns according to feature file.
To create the final tidy dataset we load the subject file
and rearrange it using melt so we create a variable of variables of the original dataset, keeping subject and activity.
finally we calculate the mean of every variable grouped by subeject and activity and export the result.

thanks for reading already so far ;-)

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
