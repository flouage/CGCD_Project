## my CodeBook for tidyDataSet.txt
first unname column is the rowid

### Subject
number of the volunteer
1..30 integer

### Activity
the activity performed by the subject values: 
 - WALKING
 - WALKING_UPSTAIRS
 - WALKING_DOWNSTAIRS
 - SITTING
 - STANDING
 - LAYING
 
 ### Variablename
 a concatenation of
  - t|f :
    - t: time
    - f: FFT (fast foruier transform of the singal)
  - Body|Gravity 
    - Body: body motion components
    - Gravity: gravitational components
  - Acc|Gyro
    - Acc: acceleration from the accelerometer 
    - Gyro: Angular velocity from the gyroscope. 
  - Jerk: the derivitive of the previous (Acc|Gyro) signal
  - "-": seprator sign
  - mean()|std()|stdFreq(): 
    - mean(): the mean of the signal defined
    - std(): standard deviation of the signal mentioned
    - meanFreq(): the mean frequency
  - "-": seperator sign
  - X|Y|Z: directional components according to standard xyz framework
  
  ### mean of Variablename
  the mean of the corresponding variablename calcalated for the group subject, activity
  
  
