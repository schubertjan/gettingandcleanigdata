#### Data and Variables
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeaccelerometer -XYZ and timegyroscope-XYZ. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing freqbodyaccelerometer -XYZ, freqbodyaccelerometerjerk-XYZ, freqbodygyroscope-XYZ, freqbodyaccelerometerjerkmag, freqbodygyroscopemag, fBodygyrospocejerkmag. (Note the 'freq' to indicate frequency domain signals).

This data is merged with subject id (variable "subject") and activity of the subject (variable "activityname").

#### Aggregations
Mean values and standard deviations for each varible were selected. Those varibles were aggregated by mean for each subject and activity. Thus, the final dataset contains mean values for each variable by each subject and activity. 


