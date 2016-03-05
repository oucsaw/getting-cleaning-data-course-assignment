#
#  run_analysis.R
#
# This script assumes that the data file has been downloaded from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# and extracted into the directory `data` - a subdirectory of the
# current working directory.
# 
# This can be achieved by using the `obtain_data.R` script.
#
# This script:
#  * Loads the data
#  * Merges the training and the test sets to create one data set.
#  * Extracts only the measurements on the mean and standard deviation for each measurement.
#   * Uses descriptive activity names to name the activities in the data set
#   * Appropriately labels the data set with descriptive variable names.
#   * Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
#

#
# Initial setup
#  * load the required packages
#  * some inital global variables

## Packages
# dplyr - we will use various functions provided by dplyr to
# manipluate our obersvataions into tidy data
# We suppressWarnings here to prevent the messages that warn 
# about the functions that are masked by the `dplyr` package; we
# accept this is going to be the case.
suppressWarnings( library(dplyr) )

## Variables
# Base data directory
dataDir <- 'data/UCI HAR Dataset/'
# File containing feature labels
featureFile <- paste0(dataDir, 'features.txt')

# File containing activity labels
activityFile <- paste0(dataDir, 'activity_labels.txt')

# File containing project submission output
projectSubmissionFile <- 'data/project_submission.txt'

#
# Load the data
#
## Feature data
#
# Firstly, we load the labels for the 'features': the 561 measurements
# for each subject activity 

features <- read.table(featureFile, header=FALSE,
                       col.names = c('featureid', 'featurelabel') )

# Becuase we are going to use these as labels for our rows, let's
# clean this list of features up a little so that we are in control
# of the character escaping:

features$featurelabel <- gsub("-", " ", features$featurelabel)
features$featurelabel <- gsub("\\(\\)", "", features$featurelabel)

# We also expand the label names to be more descriptive

features$featurelabel <- gsub("^t", "time", features$featurelabel)
features$featurelabel <- gsub("^f", "frequency", features$featurelabel)
features$featurelabel <- gsub("Acc", "Accelerometer", features$featurelabel)
features$featurelabel <- gsub("Gyro", "Gyroscope", features$featurelabel)
features$featurelabel <- gsub("Mag", "Magnitute", features$featurelabel)
features$featurelabel <- gsub("std", "standard deviation", features$featurelabel)


## Activity data

# Load the activity id and lable

activity_labels <- read.table(activityFile, header = FALSE,
                              col.names=c('activityid', 'label'))

# A useful function to return the activity label when given
# the activity id
activity_label_from_id <- function(x) {
    activity_labels[x, 'label']
}

## Test and training data sets
#
# There are 3 files of interest for each of the data sets (we use the
# test filenames here, but the same is true of the train files):
#    * subject_test.txt - the labels of the participants
#    * y_test.txt       - the labels of the activities
#    * X_test.txt       - the observations of each feature
#
# We load the data by using the function below, which takes a data set
# label and the loads the subjects, activities and observations into
# 3 data frames, before adding the subject and activity information
# to the observations and returning the observation data

load_data_set <- function( datasetname ) {

    # Build the filename based on the data set name
    dataSubjectFile     <- paste0(dataDir, datasetname, 
                                    '/subject_', datasetname, '.txt')
    dataActivityFile    <- paste0(dataDir, datasetname, 
                                    '/y_', datasetname, '.txt')
    dataObservationFile <- paste0(dataDir, datasetname, 
                                    '/X_', datasetname, '.txt')
    
    # Read the subjects taking part in the data set
    subjectData <-  read.table(dataSubjectFile, header = FALSE,
                                         col.names = c('subjectid') )

    # Read the activities performed taking by the subjects in the data set
    activityData <- read.table(dataActivityFile, header = FALSE,
                                         col.names = c('activityid') )

    # Read the observations, using the feature set (loaded above) as
    # column lables
    observationData <- read.table(dataObservationFile, header = FALSE,
                                         col.names = features$featurelabel )

    # Add in the activity to the observations
    observationData$activity <- activityData$activityid
    # Add in the subject information to the observations
    observationData$subjectid <- subjectData$subjectid

    # Clean up
    rm(activityData, subjectData)

    # Return the data  set
    observationData
}

# Read the test data
test_observations  <- load_data_set( 'test' ) 
# Read the training data
train_observations <- load_data_set( 'train' )

#
# Merge the test and training data into one data set
#
# We merge the test and training data into one set of observations,
# using the merge funciton merging on the colum subjectid.
# We have to specify all=TRUE in order that we include all rows
# from each data set not just those where the subject appears in
# both data sets (as there are, by design of the data no rows
# appearing in both sets)
#
# We also quickly check that we have the correct number of
# observations before carrying on
#

observations <- merge(test_observations, train_observations,
                     by.X = 'subjectid', by.Y = 'subjectid', 
                     all = TRUE)

## Sanity check - is the number of rows as expected ?
test_observation_count  <- nrow(test_observations)
train_observation_count <- nrow(train_observations)
observation_count       <- nrow(observations)

if ( test_observation_count + train_observation_count != observation_count ) {
   stop('Total number of observations is wrong')
}

# Clean up - remove the test and training data sets that we no longer
# require having  merged these into a single data set; also clean up
# the count variables.

rm(test_observations,train_observations,
   test_observation_count,train_observation_count,
   observation_count)

# Extracts the mean and standard devation measurements

# Using the select function from the dplyr package we select only
# the mean and standard devation measurements and reorder the
# columns to make subjectid and activity are the first two
# columns.
#
# Note we are using matches and a regular expression to not reorder
# the columns as would happen by using contains. We are using case
# sensisitve matching to exclude the angular measurements - i.e. so we
# do not to match for example 'angle(tBodyAccMean,gravity)'
#
# The regular expression matches any columns that either:
#  * contain mean but not meanF (to ensure we do not match columns with meanFreq)
#  * contain std 

observations <- select(observations, subjectid, activity,
                  matches("(.*mean([^F]+|$))|(.*standard\\.deviation.*)", ignore.case=FALSE) )

# Update from activity column to contain descriptive name rather than id

# We use `mutate` from the `dplyr` package and the function
# activity_label_from_id function defined earlier to replace the
# id values in the activity column with the descriptive names

observations <- mutate(observations,
                       activity=activity_label_from_id(activity) )

# Create a new data set with the average of each variable for each activity
# and each subject.

# We use chaining to do this; firstly, we group the current set of
# observations by activity and subject and then call summarise_each
# to apply the mean function to each column. We then store the result
# in the variable project_submission.

projectSubmission <- 
    observations %>% 
        group_by(activity, subjectid) %>%
        summarise_each(funs(mean))

# We write this out to a file
write.table( projectSubmission,
             file = projectSubmissionFile,
             row.name = FALSE)

