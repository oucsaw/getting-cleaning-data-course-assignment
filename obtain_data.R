#
# Download and extract the data for the Assignment
#
# Our assigment is to produce tidy data from the provided dataset
# (a series of measurements from smartphones for various subjects
# and activities). This script downloads the data and extracts
# the data files to ensure that the 'run_analysis.R' script will
# execute.

# The URL for the data (as provided in the assignment)
zipfileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# We store the downloaded file in the dowloads directory
downloadedDIR <- './downloads/'
downloadedZIP <- './downloads/dataset.zip'

# We extract the zipfile into the data directory
dataDIR <- './data/'

# Create any missing directories
if ( ! file.exists( downloadedDIR ) ) { dir.create( downloadedDIR ) }
if ( ! file.exists( dataDIR )       ) { dir.create( dataDIR )       }

# See if we have already downloaded the file - and only download this
# file if it is not already present
if ( ! file.exists( downloadedZIP ) ) {
     # Download the file (which as it is https, means that we need to use
     # method = 'curl' on this Mac)
     download.file(dataURL, dest=downloadedZIP, method='curl')
}

#
# Extract the ZIP file into the data directory
# We always overwrite the data; this might not be the best choice
# but we assume that as we are trying to get the data, we need to
# ensure we have a valid, unedited copy. 
#
unzip(downloadedZIP, exdir=dataDIR, overwrite=TRUE)


