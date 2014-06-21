---
 assignment  : Practical Machine Learning - Course Project
 author      : Nicolò Marchi
---

# Exercise Prediction
#### by Alicia Brown, Spring 2014, Practical Machine Learning Course Project
========================================================

## Synopsis: 
The goal of this project is to predict the manner of performing unilateral dumbbell biceps curls based on data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. The 5 possible methods include -
* A: exactly according to the specification 
* B: throwing the elbows to the front
* C: lifting the dumbbell only halfway 
* D: lowering the dumbbell only halfway
* E: throwing the hips to the front

We are provided a dataset of 19,622 records consisting of 160 variables including classe which is the actual activity performed by a user. We used this dataset to train a model to predict future activities. In order to complete the model, this dataset was separated into a training and test set, where 75% of the records were assigned to the training set. Since there are a large number of variables to create the model with, a Random Forest model was selected because of its ability to handle many variables and high accuracy rate of selecting predictors. After scrubbing the data set to remove variables with high rate of NA values, non-accelerometer variables, and employing cross validation to eliminate highly correlated variables, the resulting model was created using 41 of the original 159 columns. The out-of-bag estimate, which is the estimated error rate for future predictions in the test set was 0.77% and resulted in perfectly predicting the actual test set of 20 records that were submitted for this assignment. However, since Random Forests are prone to overfit the sample, cross validation was employed to gain a more accurate estimate of what the out-of-sample error truly is for this model.

#### Load libraries and setup working directory
