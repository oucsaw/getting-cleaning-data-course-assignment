# Code book for Project submission

## Overview

This file is based on information from the `features.txt` and
`features_info.txt` documents downloaded with the data set. We
aim to document each column in the project submission file.

## Data

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six activities
(WALKING, WALKING _UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. This has lead
to the capturing of data from from the accelerometer and gyroscope
3-axial raw signals tAcc-XYZ and tGyro-XYZ of the smartphone.  These
time domain signals (prefix 't' to denote time) were captured at a
constant rate of 50 Hz. Then they were filtered using a median filter
and a 3rd order low pass Butterworth filter with a corner frequency
of 20 Hz to remove noise. Similarly, the acceleration signal was then
separated into body and gravity acceleration signals (timeBodyAccelerometer-XYZ
and timeGravityAccelerometer-XYZ) using another low pass Butterworth filter
with a corner frequency of 0.3 Hz. 

(Note in the following -XYZ is used to denote 3-axial signals in the
X, Y and Z directions)

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (timeBodyAccelerometerJerk-XYZ
and timeBodyGyroscopeJerk-XYZ).  Also the magnitude of these
three-dimensional signals were calculated using the Euclidean
norm (timeBodyAccelerometerMagnitute, timeGravityAccelerometerMagnitute,
timeBodyAccelerometerJerkMagnitute, timeBodyGyroscopeMagnitute,
timeBodyGyroscopeJerkMagnitute). 

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing frequencyBodyAccelerometer-XYZ,
frequencyBodyAccelerometerJerk-XYZ, frequencyBodyGyroscope-XYZ,
frequencyBodyAccelerometerJerkMagnitude, frequencyBodyGyroscopeMagnitude,
frequencyBodyGyroscopeJerkMagnitude. (Note these measurements are frequency
domain signals)

We report in this data set the mean value and standard.deviation for the
above values, further taking the mean for each activity and each subject.

## List of columns

* `activity` - the descritive name of the activity undertaken by the subject one of `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`,  `STANDING` or `LAYING`
* `subjectid`- the unique identifier for each subject

Each of the following columns contains the mean of all the values for
each activity and subject:

* `timeBodyAccelerometer.mean.X`
* `timeBodyAccelerometer.mean.Y`
* `timeBodyAccelerometer.mean.Z`
* `timeBodyAccelerometer.standard.deviation.X`
* `timeBodyAccelerometer.standard.deviation.Y`
* `timeBodyAccelerometer.standard.deviation.Z`
* `timeGravityAccelerometer.mean.X`
* `timeGravityAccelerometer.mean.Y`
* `timeGravityAccelerometer.mean.Z`
* `timeGravityAccelerometer.standard.deviation.X`
* `timeGravityAccelerometer.standard.deviation.Y`
* `timeGravityAccelerometer.standard.deviation.Z`
* `timeBodyAccelerometerJerk.mean.X`
* `timeBodyAccelerometerJerk.mean.Y`
* `timeBodyAccelerometerJerk.mean.Z`
* `timeBodyAccelerometerJerk.standard.deviation.X`
* `timeBodyAccelerometerJerk.standard.deviation.Y`
* `timeBodyAccelerometerJerk.standard.deviation.Z`
* `timeBodyGyroscope.mean.X`
* `timeBodyGyroscope.mean.Y`
* `timeBodyGyroscope.mean.Z`
* `timeBodyGyroscope.standard.deviation.X`
* `timeBodyGyroscope.standard.deviation.Y`
* `timeBodyGyroscope.standard.deviation.Z`
* `timeBodyGyroscopeJerk.mean.X`
* `timeBodyGyroscopeJerk.mean.Y`
* `timeBodyGyroscopeJerk.mean.Z`
* `timeBodyGyroscopeJerk.standard.deviation.X`
* `timeBodyGyroscopeJerk.standard.deviation.Y`
* `timeBodyGyroscopeJerk.standard.deviation.Z`
* `timeBodyAccelerometerMagnitute.mean`
* `timeBodyAccelerometerMagnitute.standard.deviation`
* `timeGravityAccelerometerMagnitute.mean`
* `timeGravityAccelerometerMagnitute.standard.deviation`
* `timeBodyAccelerometerJerkMagnitute.mean`
* `timeBodyAccelerometerJerkMagnitute.standard.deviation`
* `timeBodyGyroscopeMagnitute.mean`
* `timeBodyGyroscopeMagnitute.standard.deviation`
* `timeBodyGyroscopeJerkMagnitute.mean`
* `timeBodyGyroscopeJerkMagnitute.standard.deviation`
* `frequencyBodyAccelerometer.mean.X`
* `frequencyBodyAccelerometer.mean.Y`
* `frequencyBodyAccelerometer.mean.Z`
* `frequencyBodyAccelerometer.standard.deviation.X`
* `frequencyBodyAccelerometer.standard.deviation.Y`
* `frequencyBodyAccelerometer.standard.deviation.Z`
* `frequencyBodyAccelerometerJerk.mean.X`
* `frequencyBodyAccelerometerJerk.mean.Y`
* `frequencyBodyAccelerometerJerk.mean.Z`
* `frequencyBodyAccelerometerJerk.standard.deviation.X`
* `frequencyBodyAccelerometerJerk.standard.deviation.Y`
* `frequencyBodyAccelerometerJerk.standard.deviation.Z`
* `frequencyBodyGyroscope.mean.X`
* `frequencyBodyGyroscope.mean.Y`
* `frequencyBodyGyroscope.mean.Z`
* `frequencyBodyGyroscope.standard.deviation.X`
* `frequencyBodyGyroscope.standard.deviation.Y`
* `frequencyBodyGyroscope.standard.deviation.Z`
* `frequencyBodyAccelerometerMagnitute.mean`
* `frequencyBodyAccelerometerMagnitute.standard.deviation`
* `frequencyBodyBodyAccelerometerJerkMagnitute.mean`
* `frequencyBodyBodyAccelerometerJerkMagnitute.standard.deviation`
* `frequencyBodyBodyGyroscopeMagnitute.mean`
* `frequencyBodyBodyGyroscopeMagnitute.standard.deviation`
* `frequencyBodyBodyGyroscopeJerkMagnitute.mean`
* `frequencyBodyBodyGyroscopeJerkMagnitute.standard.deviation`
