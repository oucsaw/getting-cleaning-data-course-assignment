# Getting and Cleaning Data Course Project

This repository contains my submission for the Course project
for the Getting and Cleaning Data course.

It includes the required files:

* README.md - this file
* CodeBook.md - details of the variables, units and relevant information of our output
* run_analysis.R - the R script to read the initial data file, and produce the required clean data sets

as well as the helper files:

  * obtain_data.R - download and unzip the data files

## Overview

The purpose of this project is to demonstrate our ability to collect,
work with, and clean a data set. The goal is to prepare tidy data that
can be used for later analysis. 

The original data is a set of measurements from a mobile phone
embedded accelerometer and gyroscope of 30 volunteers performing a 
range of six activities. This data is split into a test and a training
set of data.

The test set of data contains data form 30% of the volunteers,
whereas the training data contains the remaining 70% of data.

## Run analysis script

The run analysis script (`run_analysis.R`) assumes that the data files
have been downloaded and extracted into the directory `data/` in the
current directory. The script `obtain_data.R` will do this if required.

This script

* Loads the data
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In the sections below we outline the methods used to achieve the above
steps.

### Loading the data

The first step is to load the data: this includes the labels for the
`features` of the data along with the data sets which are split
across 3 files for each of the test and training data:

* the set of observations - on row per subject per activity (a file containing a set of rows of 561 observations for each of the features/observations)
* the activities for each of the observations (a file containing a list of activity numbers, one per row; the numbers are matched to the corresponding activities using the  the `UCI HAR Dataset/activity_labels.txt' file)
* the subject for each of the observations (a file containing a list of subject
identifies numbers, one per row)

To load the data, we firstly load the feature labels and activity labels
before loading the data sets.

The feature labels are contained within the space separated file
`data/UCI HAR Dataset/features.txt`; this file contains two columns:
an feature identifier (a integer sequence running between 1 and 561)
and the short name or label  of the feature. We load this into the
data frame `features`. We label the columns of the data frame
`featureid` and `featurelabel`, respectively. We also expand the
feature labels to be more descriptive at this point.

Next we load the activity labels - these are contained within the
space seperated file `data/UCI HAR Dataset/activity_labels.txt`. This
file contains two columns the activity id (a number between 1 and 6)
and the activity label (a text label of the activity). We load this
data into a data frame containing 2 columns: `activityid` and `label`.

We also at this point define a function to replace the activityid with
it's label.

At this point we load the test and training data into the data frames
* test_observations
* train_observations

To do this we write a function that will load each data set into a data
frame and return the data frame. The function `load_data_set` takes the
data set label (either `test` or `train`) and then loads the three files
that make up the data set, combining these into a single data frame which
is returned. The data is split over 3 files for each data set
contained in a directory named after the dataset:

* subject_<DATASET>.txt - the labels of the participants
* y_<DATASET>.txt       - the labels of the activities
* X_<DATASET>.txt       - the observations of each feature
(e.g. `train/subject_train.txt`, `train/y_train.txt` and
`train/X_train.txt`).

### Merging the data

Now we have the 2 data sets (`test_observations` and
`train_observations`) loaded we wish to combine these into a single
data set of observations. 

We do this by using the merge function, and merging the data sets
using the `subjectid` column as the key for the merge. Given we know
that the subjects have been split between the 2 data sets so that no
subject will appear in both, we specify `all = TRUE` so that observations
that are only present in one of the data sets appear in the results.

We also at this point quickly check that we have achieved the desired
result by checking that the number of observations is the same as
the sum of the number of test and training observations.

At this point we also clean up the environment by removing the now
unrequired data frames and count variables:

* `test_observations`
* `train_observations`
* `test_observation_count`
* `train_observations`

### Extract the measurements required

We now extract only the measurements that we are interested in -
having loaded all 561 observations, for this exercise we are only
concerned with those observations representing the mean and standard
 
in the signal window sample - these are identified as using the
`angle(<data>)` feature label and contain the string 'Mean'. 

To make this more concrete we are interested in the features which
contain either `mean()` or `std()` but that are not angular vectors. To
update our data frame we use the `select` function from the `dplyr`
package (which is loaded as part of the script initialisation). We
select the columns based on their names (which in turn where loaded
from the feature set earlier) using the matches function with a
regular expression matching either mean but not meanFreq,  or standard
deviation.  We also take this opportunity to re-order the columns so
that subjectid and activityid are the first two columns in the dataset.

### Labels activities with descriptive names

Finally we change the activity column from an activity id to a
descriptive name using the `activity_label_from_id` function we
defined earlier on.  We use the `mutate` function from the `dplyr`
package to achieve this.

### Tidy data

Before moving on, we should consider if we now have tidy data. From
https://github.com/jtleek/datasharing we know that tidy data should
follow the principals:

* Each variable you measure should be in one column
* Each different observation of that variable should be in a different row
* There should be one table for each "kind" of variable
* If you have multiple tables, they should include a column in the table that allows them to be linked

We do indeed have one variable per column, and each observation is
in a row. We are only dealing with one kind of data and that data is
in a single table. There may be an argument to split up the
observations into a table per activity or to add extra columns per
activity, but we view activity as an observation in this instance.

### Average of each variable for each activity and each subject

We now average each variable for each activity and each subject. To to
this we firstly group the existing data by subject and then activity
using the `dplyr` package's `group_by` function. This will then allow
us to summarise the data to form the desired data frame. Note that we
use the summarise_each function to allow us to apply the function
`mean` to each column in turn without having to specify each column
name.

Finally, we use `write.table` to write the result to a file, for
submitting as part of this project.

## Obtaining the data script

The obtain data script (`obtain_data.R`) will download the provided
zip file for the assignment, saving it in the directory `./downloads` in
a file called `dataset.zip`. The script will create the directory if
it does not exist. 

The script will only download the file only if has not already been
downloaded.

Once downloaded the script will extract the zip file into the
`./data` directory - creating the directory if it does not exist.

The script will always extract the data file, and overwrite any
existing files, as it is assumed that this is the required action
if the script is run. 
